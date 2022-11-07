################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../VL53L1X_API/platform/src/vl53l1_platform.c \
../VL53L1X_API/platform/src/vl53l1_platform_init.c \
../VL53L1X_API/platform/src/vl53l1_platform_log.c 

OBJS += \
./VL53L1X_API/platform/src/vl53l1_platform.o \
./VL53L1X_API/platform/src/vl53l1_platform_init.o \
./VL53L1X_API/platform/src/vl53l1_platform_log.o 

C_DEPS += \
./VL53L1X_API/platform/src/vl53l1_platform.d \
./VL53L1X_API/platform/src/vl53l1_platform_init.d \
./VL53L1X_API/platform/src/vl53l1_platform_log.d 


# Each subdirectory must supply rules for building sources it contributes
VL53L1X_API/platform/src/%.o VL53L1X_API/platform/src/%.su: ../VL53L1X_API/platform/src/%.c VL53L1X_API/platform/src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32L476xx -c -I../Core/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32L4xx/Include -I../Drivers/CMSIS/Include -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/core/inc" -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/platform/inc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-VL53L1X_API-2f-platform-2f-src

clean-VL53L1X_API-2f-platform-2f-src:
	-$(RM) ./VL53L1X_API/platform/src/vl53l1_platform.d ./VL53L1X_API/platform/src/vl53l1_platform.o ./VL53L1X_API/platform/src/vl53l1_platform.su ./VL53L1X_API/platform/src/vl53l1_platform_init.d ./VL53L1X_API/platform/src/vl53l1_platform_init.o ./VL53L1X_API/platform/src/vl53l1_platform_init.su ./VL53L1X_API/platform/src/vl53l1_platform_log.d ./VL53L1X_API/platform/src/vl53l1_platform_log.o ./VL53L1X_API/platform/src/vl53l1_platform_log.su

.PHONY: clean-VL53L1X_API-2f-platform-2f-src

