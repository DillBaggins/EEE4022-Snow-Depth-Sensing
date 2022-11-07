
void SetupCommscanIseeDevice(void);
void print_pal_error(VL53L1_Error);
void setupDeviceForSingleRanging(void);
int takeSinglePollingMeasurement(void);
int takeMultiplePollingMeasurements(int);
void printToSerial(void);
void print_range_status(VL53L1_RangingMeasurementData_t*);

//calibration functions
void refSPADCalibration();
void offsetCalibration(int32_t calibrationDistance);
void crossTalkCalibration(int32_t calibrationDistance);
