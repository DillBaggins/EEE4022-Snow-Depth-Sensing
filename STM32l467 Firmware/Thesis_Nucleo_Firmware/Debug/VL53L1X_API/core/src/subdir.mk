################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../VL53L1X_API/core/src/vl53l1_api.c \
../VL53L1X_API/core/src/vl53l1_api_calibration.c \
../VL53L1X_API/core/src/vl53l1_api_core.c \
../VL53L1X_API/core/src/vl53l1_api_debug.c \
../VL53L1X_API/core/src/vl53l1_api_preset_modes.c \
../VL53L1X_API/core/src/vl53l1_api_strings.c \
../VL53L1X_API/core/src/vl53l1_core.c \
../VL53L1X_API/core/src/vl53l1_core_support.c \
../VL53L1X_API/core/src/vl53l1_error_strings.c \
../VL53L1X_API/core/src/vl53l1_register_funcs.c \
../VL53L1X_API/core/src/vl53l1_silicon_core.c \
../VL53L1X_API/core/src/vl53l1_wait.c 

OBJS += \
./VL53L1X_API/core/src/vl53l1_api.o \
./VL53L1X_API/core/src/vl53l1_api_calibration.o \
./VL53L1X_API/core/src/vl53l1_api_core.o \
./VL53L1X_API/core/src/vl53l1_api_debug.o \
./VL53L1X_API/core/src/vl53l1_api_preset_modes.o \
./VL53L1X_API/core/src/vl53l1_api_strings.o \
./VL53L1X_API/core/src/vl53l1_core.o \
./VL53L1X_API/core/src/vl53l1_core_support.o \
./VL53L1X_API/core/src/vl53l1_error_strings.o \
./VL53L1X_API/core/src/vl53l1_register_funcs.o \
./VL53L1X_API/core/src/vl53l1_silicon_core.o \
./VL53L1X_API/core/src/vl53l1_wait.o 

C_DEPS += \
./VL53L1X_API/core/src/vl53l1_api.d \
./VL53L1X_API/core/src/vl53l1_api_calibration.d \
./VL53L1X_API/core/src/vl53l1_api_core.d \
./VL53L1X_API/core/src/vl53l1_api_debug.d \
./VL53L1X_API/core/src/vl53l1_api_preset_modes.d \
./VL53L1X_API/core/src/vl53l1_api_strings.d \
./VL53L1X_API/core/src/vl53l1_core.d \
./VL53L1X_API/core/src/vl53l1_core_support.d \
./VL53L1X_API/core/src/vl53l1_error_strings.d \
./VL53L1X_API/core/src/vl53l1_register_funcs.d \
./VL53L1X_API/core/src/vl53l1_silicon_core.d \
./VL53L1X_API/core/src/vl53l1_wait.d 


# Each subdirectory must supply rules for building sources it contributes
VL53L1X_API/core/src/%.o VL53L1X_API/core/src/%.su: ../VL53L1X_API/core/src/%.c VL53L1X_API/core/src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32L476xx -c -I../Core/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32L4xx/Include -I../Drivers/CMSIS/Include -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/core/inc" -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/platform/inc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-VL53L1X_API-2f-core-2f-src

clean-VL53L1X_API-2f-core-2f-src:
	-$(RM) ./VL53L1X_API/core/src/vl53l1_api.d ./VL53L1X_API/core/src/vl53l1_api.o ./VL53L1X_API/core/src/vl53l1_api.su ./VL53L1X_API/core/src/vl53l1_api_calibration.d ./VL53L1X_API/core/src/vl53l1_api_calibration.o ./VL53L1X_API/core/src/vl53l1_api_calibration.su ./VL53L1X_API/core/src/vl53l1_api_core.d ./VL53L1X_API/core/src/vl53l1_api_core.o ./VL53L1X_API/core/src/vl53l1_api_core.su ./VL53L1X_API/core/src/vl53l1_api_debug.d ./VL53L1X_API/core/src/vl53l1_api_debug.o ./VL53L1X_API/core/src/vl53l1_api_debug.su ./VL53L1X_API/core/src/vl53l1_api_preset_modes.d ./VL53L1X_API/core/src/vl53l1_api_preset_modes.o ./VL53L1X_API/core/src/vl53l1_api_preset_modes.su ./VL53L1X_API/core/src/vl53l1_api_strings.d ./VL53L1X_API/core/src/vl53l1_api_strings.o ./VL53L1X_API/core/src/vl53l1_api_strings.su ./VL53L1X_API/core/src/vl53l1_core.d ./VL53L1X_API/core/src/vl53l1_core.o ./VL53L1X_API/core/src/vl53l1_core.su ./VL53L1X_API/core/src/vl53l1_core_support.d ./VL53L1X_API/core/src/vl53l1_core_support.o ./VL53L1X_API/core/src/vl53l1_core_support.su ./VL53L1X_API/core/src/vl53l1_error_strings.d ./VL53L1X_API/core/src/vl53l1_error_strings.o ./VL53L1X_API/core/src/vl53l1_error_strings.su ./VL53L1X_API/core/src/vl53l1_register_funcs.d ./VL53L1X_API/core/src/vl53l1_register_funcs.o ./VL53L1X_API/core/src/vl53l1_register_funcs.su ./VL53L1X_API/core/src/vl53l1_silicon_core.d ./VL53L1X_API/core/src/vl53l1_silicon_core.o ./VL53L1X_API/core/src/vl53l1_silicon_core.su ./VL53L1X_API/core/src/vl53l1_wait.d ./VL53L1X_API/core/src/vl53l1_wait.o ./VL53L1X_API/core/src/vl53l1_wait.su

.PHONY: clean-VL53L1X_API-2f-core-2f-src

