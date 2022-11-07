cmake_minimum_required(VERSION 3.12)

include(pico_sdk_import.cmake)



project(ADC_over_USB)

pico_sdk_init()

add_executable(ADC_over_USB main.c)

target_link_libraries(ADC_over_USB 
                pico_stdlib
                hardware_adc
                hardware_dma
                # For the dummy output:
                )

pico_enable_stdio_usb(ADC_over_USB 1)
pico_enable_stdio_uart(ADC_over_USB 0)

pico_add_extra_outputs(ADC_over_USB)