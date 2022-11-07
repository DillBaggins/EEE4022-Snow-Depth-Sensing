# EEE4022-Snow-Depth-Sensing

This repo contains some of the core work resulting from my undergraduate thesis on "Investigating Techniques for In-Situ Snow Depth Measuring"

The project entailed the investigation of 
- Ultrasonic Time-of-Flight Sensing
- Laser Ranging

## Ultrasonic Driver/Receiver Circuit
Schematics and gerber files for the ultrasonic driver/receiever board can be found in the "Ultrasound Driving PCB" directory.
This circuit can be driven with a regulated $\pm$ 15V or an unregulated $\pm$\[16V,20V\]. 

This circuit has a number of problems, as explored in my thesis. The chief of which being the amount of cross-talk between the transducers, this could be corrected either by the design of an appropriate housing for the board or through signal processing means. Additionally, the fixed receiver gain is not ideal and should be revised to allow for the reciever gain to be digitally controller by the host microcontroller

## Ultrasonic Signal Sampling & Generation
Ultrasonic signals were generated using the DAC aboard the STM32l476-RG Nucleo board and transmitted/received signals sampled using a raspberry pi pico. This dual-microcontroller technique is sub-optimal and realistally, the STM32 is capable of both. 

Code for the sampling using the Pico can be found in the "RP2040 Firmware" directory and should be compiled as described [here](https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf)

Code for the generation of ultrasonic signals using the STM can be found in the "STM32l467 Firmware". This was primarily written using HAL functions and should port to other STMs fairly well. 

## Interface with the VL53L1X Laser Ranging Sensor
The [VL53l1X](https://www.st.com/en/imaging-and-photonics-solutions/vl53l1x.html) is an I2C laser ranging device from ST. The firmware for interfacing with this device can also be found in the "STM32l467 Firmware" directory. 

## Time of flight Signal Processing
There were a series of functions developed in the course of this work for the processing of time-of-flight signals. These were written in MATLAB and can be found in the "Signal Processing Functions" directory
