################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/FreeRTOS_tick_config.c \
../src/croutine.c \
../src/event_groups.c \
../src/heap_4.c \
../src/list.c \
../src/main.c \
../src/platform.c \
../src/port.c \
../src/printf-stdarg.c \
../src/queue.c \
../src/tasks.c \
../src/timers.c 

LD_SRCS += \
../src/lscript.ld 

S_UPPER_SRCS += \
../src/FreeRTOS_asm_vectors.S \
../src/portASM.S 

OBJS += \
./src/FreeRTOS_asm_vectors.o \
./src/FreeRTOS_tick_config.o \
./src/croutine.o \
./src/event_groups.o \
./src/heap_4.o \
./src/list.o \
./src/main.o \
./src/platform.o \
./src/port.o \
./src/portASM.o \
./src/printf-stdarg.o \
./src/queue.o \
./src/tasks.o \
./src/timers.o 

C_DEPS += \
./src/FreeRTOS_tick_config.d \
./src/croutine.d \
./src/event_groups.d \
./src/heap_4.d \
./src/list.d \
./src/main.d \
./src/platform.d \
./src/port.d \
./src/printf-stdarg.d \
./src/queue.d \
./src/tasks.d \
./src/timers.d 

S_UPPER_DEPS += \
./src/FreeRTOS_asm_vectors.d \
./src/portASM.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../FreeRTOSZ_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../FreeRTOSZ_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


