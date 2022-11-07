#include "vl53l1_api.h"
#include "VL53L1_functions.h"
#include "stdio.h"

#ifndef uartOutputBuffLen
#define uartOutputBuffLen 800
#endif


// sharing global vars regarding VL53L1X device
extern I2C_HandleTypeDef hi2c1;
extern UART_HandleTypeDef huart2;
extern VL53L1_Dev_t                   dev;
extern VL53L1_DEV                     Dev ;
extern VL53L1_Error Status; //global device status var
extern VL53L1_RangingMeasurementData_t RangingData;
extern uint8_t measureMentDataReady;
extern VL53L1_CalibrationData_t calibrationData;
extern VL53L1_CalibrationData_t* pCalibrationData;

// sharing globals vars for uart comms
extern char uartTxBuf[];
extern int uartTxBufLen;

/*
 * Simple functions which establishes i2c communication with the sensor
 */
void SetupCommscanIseeDevice(){
	//these assignments happen on a global scale
	Dev->I2cDevAddr      = 0x52;
	Dev->I2cHandle	   = &hi2c1;
	Dev->comms_type      =  1;
	Dev->comms_speed_khz =  100;

	uartTxBufLen=sprintf(uartTxBuf,"checking to see if can see laser sensor\r\n");
	printToSerial();

	uint8_t ret;
	ret = HAL_I2C_IsDeviceReady(&hi2c1, dev.I2cDevAddr, 3, 5);
	if (ret != HAL_OK) /* No ACK Received At That Address */
	{
		uartTxBufLen=sprintf(uartTxBuf,"cant see laser sensor\r\n");
		printToSerial();
	}
	else if(ret == HAL_OK)
	{
		uartTxBufLen=sprintf(uartTxBuf,"can see laser sensor:) \r\n");
		printToSerial();
	}

	uartTxBufLen=sprintf(uartTxBuf,"performing DataInit function \r\n");
	printToSerial();
	Status = VL53L1_DataInit(Dev); // Data initialization
	if(Status){print_pal_error(Status);}
	else{
		uartTxBufLen=sprintf(uartTxBuf,"performing StaticInit function \r\n");
		printToSerial();
		Status = VL53L1_StaticInit(Dev); // Data initialization
		if (Status){print_pal_error(Status);}
	}
}


void setupDeviceForSingleRanging(){
	// setup for simple ranging
	uartTxBufLen=sprintf(uartTxBuf,"setting presetMode\r\n");
	printToSerial();
	Status=VL53L1_SetPresetMode(Dev,VL53L1_PRESETMODE_LITE_RANGING);
	if (Status){
		uartTxBufLen=sprintf(uartTxBuf,"something went wrong setting preset\r\n");
		printToSerial();
	}


	// set distance range
	uartTxBufLen=sprintf(uartTxBuf,"setting distance mode\r\n");
	printToSerial();
	if (!Status){
		uartTxBufLen=sprintf(uartTxBuf,"setting mode to medium range\r\n");
		printToSerial();
		Status= VL53L1_SetDistanceMode(Dev, VL53L1_DISTANCEMODE_MEDIUM);
		/* VL53L1_DISTANCEMODE_SHORT = up to 1.3m (better ambient light rejection)
		 * •VL53L1_DISTANCEMODE_MEDIUM = up to 3m
		 * •VL53L1_DISTANCEMODE_LONG = up to 4m
		 */
	}
	else{
		uartTxBufLen=sprintf(uartTxBuf,"error in setting distance mode\r\n");
		printToSerial();
		print_pal_error(Status);

	}


}



void refSPADCalibration(){
	uartTxBufLen=sprintf(uartTxBuf,"doing SPAD calibration\r\n");
	printToSerial();
	Status=VL53L1_PerformRefSpadManagement(Dev);
	if(Status){
			print_pal_error(Status);
		}
	Status=VL53L1_GetCalibrationData(Dev, pCalibrationData);
	Status=VL53L1_SetCalibrationData(Dev, pCalibrationData);
	if(Status){
		print_pal_error(Status);
	}
}

void offsetCalibration(int32_t calibrationDistance){
	// set measurement budget as advised by datasheed
	Status = VL53L1_SetMeasurementTimingBudgetMicroSeconds(Dev, 30000);
	Status = VL53L1_SetInterMeasurementPeriodMilliSeconds(Dev, 40000);

	if (Status){
		uartTxBufLen=sprintf(uartTxBuf,"something went wrong setting timing budget for offset calibration\r\n");
		printToSerial();
		print_pal_error(Status);
	}
	else{
		uartTxBufLen=sprintf(uartTxBuf,"timing budget set for calibration\r\n");
		printToSerial();
		Status=VL53L1_PerformOffsetSimpleCalibration(Dev, calibrationDistance);
		uartTxBufLen=sprintf(uartTxBuf,"done\r\n");
		printToSerial();

		//Status=VL53L1_PerformOffsetZeroDistanceCalibration (Dev);
	}

	// return measurement budget to my defaults
	if(Status){	setupDeviceForSingleRanging();}
	else{
		uartTxBufLen=sprintf(uartTxBuf,"something went wrong with settup back to single ranging mode\r\n");
		printToSerial();
		print_pal_error(Status);
	}

}

void crossTalkCalibration(int32_t calibrationDistance){
	Status = VL53L1_PerformSingleTargetXTalkCalibration(Dev, calibrationDistance);
	Status=VL53L1_enable_xtalk_compensation(Dev);
}

int takeSinglePollingMeasurement(){

	Status=VL53L1_StartMeasurement(Dev);
	/*
	if (Status){
		uartTxBufLen=sprintf(uartTxBuf,"Error Starting Measurement\r\n");
		printToSerial();
		print_pal_error(Status);
		return -1;
	}
	*/

	// wait for the measurement to be complete
	while(measureMentDataReady==0){
		Status=VL53L1_GetMeasurementDataReady(Dev, &measureMentDataReady);
		//if(!Status){print_pal_error(Status);}
		uartTxBufLen=sprintf(uartTxBuf,"waiting...\r\n");
		printToSerial();
	}

	// stop measuring
	Status=VL53L1_ClearInterruptAndStartMeasurement (Dev);
	if (!Status){print_pal_error(Status);}

	//get measurement data
	Status=VL53L1_GetRangingMeasurementData(Dev, &RangingData);
	if (!Status){print_pal_error(Status);}

	// print the ranging data to the console
	uartTxBufLen=sprintf(uartTxBuf,"Status:%d, Range in mm %d\r\n", RangingData.RangeStatus,RangingData.RangeMilliMeter);
	printToSerial();

	// if the ranging status is not OK
	if(RangingData.RangeStatus!=0){
		print_range_status(&RangingData);
	}

	return Status;
	return 0;
}

int takeMultiplePollingMeasurements(int numReadings){
	uint8_t readingStatuses[numReadings];
	int16_t readings[numReadings];


	Status=VL53L1_StartMeasurement(Dev);
		if (!Status){
			uartTxBufLen=sprintf(uartTxBuf,"Error Starting Measurement\r\n");
			printToSerial();
			return -1;

		}

		for (int i=0;i<numReadings;i++){
			// wait for the measurement to be complete
					while(measureMentDataReady==0){
						Status=VL53L1_GetMeasurementDataReady(Dev, &measureMentDataReady);
					}



					//get measurement data
					Status=VL53L1_GetRangingMeasurementData(Dev, &RangingData);

					// stop measuring
					Status=VL53L1_ClearInterruptAndStartMeasurement (Dev);

					readings[i]=RangingData.RangeMilliMeter;
					readingStatuses[i]=RangingData.RangeStatus;

					// add reading and status to comma delimited string to send to PC

		}

		sprintf(uartTxBuf,""); //reset buffer
		uint16_t written=0;

		//first do data
		for(int i = 0; i < numReadings; i++) {
		        written += snprintf(uartTxBuf + written, uartOutputBuffLen - written, "%i,",*(readings + i));
		        if(written == uartOutputBuffLen)
		            break;
		}

		// then do statuses
		for(int i = 0; i < numReadings; i++) {
		        written += snprintf(uartTxBuf + written, uartOutputBuffLen - written, "%u,",*(readingStatuses + i));
		        if(written == uartOutputBuffLen)
		            break;
		    }

		//print it
		uartTxBufLen=written;
		printToSerial();
		uartTxBufLen=sprintf(uartTxBuf,"\r\n");
		printToSerial();
		return 0;
}

/*
 * An adaption of a function in an example from ST
 */
void print_pal_error(VL53L1_Error Status){
    char buf[VL53L1_MAX_STRING_LENGTH];
    VL53L1_GetPalErrorString(Status, buf);
    uartTxBufLen=sprintf(uartTxBuf,"API Status: %i : %s\r\n", Status, buf);
    printToSerial();
}

/*
 * Prints a string to the console describing the ranging status
 */
void print_range_status(VL53L1_RangingMeasurementData_t* pRangingMeasurementData){
	char buf[VL53L1_MAX_STRING_LENGTH];
	VL53L1_GetRangeStatusString(pRangingMeasurementData->RangeStatus, buf);
	uartTxBufLen=sprintf(uartTxBuf,"Range Status: %i : %s\r\n", pRangingMeasurementData->RangeStatus, buf);
	printToSerial();
}
