
// io
#include <stdio.h>
#include "pico/stdlib.h" //includes gpio stuff

// for ADC things
#include "hardware/dma.h"
#include "hardware/adc.h"

//gpio
#include "hardware/gpio.h"

// defining ADC GPIO Pins
#define ADC0 26
#define ADC1 27

//i am hoping to get all samples in one DMA session over 1s
#define numSamples 250000
uint8_t sampleArr[numSamples]; 
#define numSamplesAtOnce 10000

// making dma channel a global var for convenience
uint dma_chan;

//for button debouncing
unsigned long debounceTime;
const int delayTime=1000; 
bool takeSamplesFlag=false;
float tempC=0.0;

//function prototypes
void takeSamples(void);
size_t join_integers(uint8_t *num, size_t num_len, char *buf, size_t buf_len);
int setupADCforSampling(void);

/*
GPIO callback function
*/
void gpio_callback(uint gpio, uint32_t events) {
    if ((to_ms_since_boot(get_absolute_time())-debounceTime)>delayTime) {
        debounceTime = to_ms_since_boot(get_absolute_time());
        //printf("button pushed");
        takeSamplesFlag=true;
       /// printf("bool set true");
    }
}


int main() {
    //setup ISB comms
    stdio_usb_init();
    sleep_ms(2000);

    // set up button for trigger samples
   gpio_init(1);
   gpio_pull_up(1);
   gpio_set_irq_enabled_with_callback(1, GPIO_IRQ_EDGE_FALL , true, &gpio_callback);
   debounceTime=to_ms_since_boot(get_absolute_time());

    // read the temperature before samples are taken (taking samples may slightly heat up CPU)
    adc_init(); 
    adc_set_temp_sensor_enabled(true);
    adc_select_input(4);
    const float conversionFactor = 3.3f / (1 << 12);

    float adc = (float)adc_read() * conversionFactor;
    tempC = 27.0f - (adc - 0.706f) / 0.001721f;
    adc_set_temp_sensor_enabled(false);

   
    setupADCforSampling();


    

   
    while (true) {
        if (stdio_usb_connected()){
            char c=getchar();
            if (c=='T'||c=='t'){
                printf("%.02f\n",tempC);
            }
            else if (c=='S'|c=='s'){
                takeSamples();
            }
            else{
                ;
            } 
        }
        

        // uncomment if want to use button method
        /*
        if (takeSamplesFlag==true)
        {
            takeSamples();
            while(takeSamplesFlag){
                tight_loop_contents(); //wait til samples are printed
            }
            //printf("ready");
        }
        sleep_us(1000); // for some reason, takeSamples wont run unless this here
        */
        
    }
    return 0;
}

void takeSamples(){
    dma_channel_start(dma_chan); 
    adc_run(true);

    // Once DMA finishes, stop any new conversions from starting, and clean up
    // the FIFO in case the ADC was still mid-conversion.
    dma_channel_wait_for_finish_blocking(dma_chan);
   // printf("Capture finished\n\n");
    adc_run(false);
    adc_fifo_drain();

    /*
    //print out samples, 10 000 at a time
   char text[numSamplesAtOnce*5]; //8 bit ADC value and a comma (and extra space for justin)
   for (int i=0; i < (numSamples/(numSamplesAtOnce)-1) ; i++){ //loop through each batch
    printf("%u\r\n",i*numSamplesAtOnce); //okay the loop works
    join_integers(&sampleArr[i*numSamplesAtOnce],numSamplesAtOnce,text,numSamplesAtOnce*5);
    sleep_us(1000);
    printf(text);
    printf("\n\n");
    sleep_us(1000);  
   }
   */

    /*
    // uncomment if doing saving via putty
    for (int i=0;i<numSamples;i++){
        printf("%u,",sampleArr[i]);
        sleep_us(100); //hoping this makes transfer more stable
    }
    */
    

    // try write all data to stdout
    fwrite(sampleArr,1,numSamples,stdout);

  

    // get ready for next batch of samples
    takeSamplesFlag=false;
    setupADCforSampling();
    return;
}


int setupADCforSampling(){
    // set up GPIO pins for ADC use
    adc_gpio_init(ADC0);
    adc_gpio_init(ADC1);
    adc_init();

    // selecting ADC channels
    uint adc_channel_mask= 0x05; //=0b0101
    adc_set_round_robin(adc_channel_mask);
    adc_select_input(0); //making sure channel 0 is samped first for consistency

    // setup ADC FIFO queue
     adc_fifo_setup(
        true,    // Write each completed conversion to the sample FIFO
        true,    // Enable DMA data request (DREQ)
        1,       // DREQ (and IRQ) asserted when at least 1 sample present
        false,   // We won't see the ERR bit because of 8 bit reads; disable.
        true     // Shift each sample to 8 bits when pushing to FIFO
    );

    /*
    ADC is run by 48MHz clock, each conversion takes 96 cycles:

    I want to sample each channel at 125kHz 
    (nyquist is 80kHz, but since I can why not)  
    */
   uint totalSampleRate=250000;
   adc_set_clkdiv(48000000/totalSampleRate);

    //////////////////////////////////////////////////////////////////////////////////
    //printf("Arming DMA\n");
    sleep_ms(1000);
    // Set up the DMA to start transferring data as soon as it appears in FIFO
    dma_chan = dma_claim_unused_channel(true);
    dma_channel_config cfg = dma_channel_get_default_config(dma_chan);

    // Reading from constant address, writing to incrementing byte addresses
    channel_config_set_transfer_data_size(&cfg, DMA_SIZE_8);
    channel_config_set_read_increment(&cfg, false);
    channel_config_set_write_increment(&cfg, true);

    // Pace transfers based on availability of ADC samples
    channel_config_set_dreq(&cfg, DREQ_ADC);
    //configure DMA 
    dma_channel_configure(dma_chan, &cfg,
        sampleArr,    // dst
        &adc_hw->fifo,  // src
        numSamples,  // transfer count
        false            // start immediately
    );

    return 0;
}


/*
 * Turns an array of unsigned ints into a comma delimited string.
 adapted from:
https://stackoverflow.com/questions/1745811/using-c-convert-a-dynamically-allocated-int-array-to-a-comma-separated-string-a
 */
size_t join_integers(uint8_t *num, size_t num_len, char *buf, size_t buf_len) {
    size_t i;
    uint16_t written = 0;

    for(int i = 0; i < num_len; i++) {
        written += snprintf(buf + written, buf_len - written, "%u,",*(num + i));
        if(written == buf_len)
            break;
    }
    return written;
}