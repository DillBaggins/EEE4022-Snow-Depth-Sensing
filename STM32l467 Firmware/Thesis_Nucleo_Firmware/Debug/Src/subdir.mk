################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../VL53L1X_API/platform/Src/vl53l1_platform.c \
../VL53L1X_API/platform/Src/vl53l1_platform_init.c \
../VL53L1X_API/platform/Src/vl53l1_platform_log.c 

OBJS += \
./Src/vl53l1_platform.o \
./Src/vl53l1_platform_init.o \
./Src/vl53l1_platform_log.o 

C_DEPS += \
./Src/vl53l1_platform.d \
./Src/vl53l1_platform_init.d \
./Src/vl53l1_platform_log.d 


# Each subdirectory must supply rules for building sources it contributes
Src/vl53l1_platform.o: C:/Users/dylan/OneDrive/UNI/2022/Thesis\ Things/Code/Nucleo\ code/Thesis_Nucleo_Firmware/VL53L1X_API/platform/Src/vl53l1_platform.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32L476xx -c -I../Core/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32L4xx/Include -I../Drivers/CMSIS/Include -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/core/inc" -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/platform/inc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Src/vl53l1_platform_init.o: C:/Users/dylan/OneDrive/UNI/2022/Thesis\ Things/Code/Nucleo\ code/Thesis_Nucleo_Firmware/VL53L1X_API/platform/Src/vl53l1_platform_init.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32L476xx -c -I../Core/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32L4xx/Include -I../Drivers/CMSIS/Include -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/core/inc" -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/platform/inc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Src/vl53l1_platform_log.o: C:/Users/dylan/OneDrive/UNI/2022/Thesis\ Things/Code/Nucleo\ code/Thesis_Nucleo_Firmware/VL53L1X_API/platform/Src/vl53l1_platform_log.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32L476xx -c -I../Core/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32L4xx/Include -I../Drivers/CMSIS/Include -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/core/inc" -I"C:/Users/dylan/OneDrive/UNI/2022/Thesis Things/Code/Nucleo code/Thesis_Nucleo_Firmware/VL53L1X_API/platform/inc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/vl53l1_platform.d ./Src/vl53l1_platform.o ./Src/vl53l1_platform.su ./Src/vl53l1_platform_init.d ./Src/vl53l1_platform_init.o ./Src/vl53l1_platform_init.su ./Src/vl53l1_platform_log.d ./Src/vl53l1_platform_log.o ./Src/vl53l1_platform_log.su

.PHONY: clean-Src

