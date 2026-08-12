# 0 "C:\\Users\\esteb\\OneDrive\\Documentos\\SEGGER Embedded Studio Projects\\Tarea 1\\STM32F4xx\\Source\\stm32f407xx_Vectors.s"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "C:\\Users\\esteb\\OneDrive\\Documentos\\SEGGER Embedded Studio Projects\\Tarea 1\\STM32F4xx\\Source\\stm32f407xx_Vectors.s"
# 61 "C:\\Users\\esteb\\OneDrive\\Documentos\\SEGGER Embedded Studio Projects\\Tarea 1\\STM32F4xx\\Source\\stm32f407xx_Vectors.s"
        .syntax unified
# 73 "C:\\Users\\esteb\\OneDrive\\Documentos\\SEGGER Embedded Studio Projects\\Tarea 1\\STM32F4xx\\Source\\stm32f407xx_Vectors.s"
.macro VECTOR Name=
        .section .vectors, "ax"
        .code 16
        .word \Name
.endm




.macro EXC_HANDLER Name=



        .section .vectors, "ax"
        .word \Name



        .section .init.\Name, "ax"
        .thumb_func
        .weak \Name
        .balign 2
\Name:
        1: b 1b
.endm




.macro ISR_HANDLER Name=



        .section .vectors, "ax"
        .word \Name
# 116 "C:\\Users\\esteb\\OneDrive\\Documentos\\SEGGER Embedded Studio Projects\\Tarea 1\\STM32F4xx\\Source\\stm32f407xx_Vectors.s"
        .section .init.\Name, "ax"
        .thumb_func
        .weak \Name
        .balign 2
\Name:
        1: b 1b

.endm




.macro ISR_RESERVED
        .section .vectors, "ax"
        .word 0
.endm




.macro ISR_RESERVED_DUMMY
        .section .vectors, "ax"
        .word Dummy_Handler
.endm







        .extern __stack_end__
        .extern Reset_Handler
        .extern HardFault_Handler
# 163 "C:\\Users\\esteb\\OneDrive\\Documentos\\SEGGER Embedded Studio Projects\\Tarea 1\\STM32F4xx\\Source\\stm32f407xx_Vectors.s"
        .section .vectors, "ax"
        .code 16
        .balign 512
        .global _vectors
_vectors:



        VECTOR __stack_end__
        VECTOR Reset_Handler
        EXC_HANDLER NMI_Handler
        VECTOR HardFault_Handler





        EXC_HANDLER MemManage_Handler
        EXC_HANDLER BusFault_Handler
        EXC_HANDLER UsageFault_Handler

        ISR_RESERVED
        ISR_RESERVED
        ISR_RESERVED
        ISR_RESERVED
        EXC_HANDLER SVC_Handler



        EXC_HANDLER DebugMon_Handler

        ISR_RESERVED
        EXC_HANDLER PendSV_Handler
        EXC_HANDLER SysTick_Handler




        ISR_HANDLER WWDG_IRQHandler
        ISR_HANDLER PVD_IRQHandler
        ISR_HANDLER TAMP_STAMP_IRQHandler
        ISR_HANDLER RTC_WKUP_IRQHandler
        ISR_HANDLER FLASH_IRQHandler
        ISR_HANDLER RCC_IRQHandler
        ISR_HANDLER EXTI0_IRQHandler
        ISR_HANDLER EXTI1_IRQHandler
        ISR_HANDLER EXTI2_IRQHandler
        ISR_HANDLER EXTI3_IRQHandler
        ISR_HANDLER EXTI4_IRQHandler
        ISR_HANDLER DMA1_Stream0_IRQHandler
        ISR_HANDLER DMA1_Stream1_IRQHandler
        ISR_HANDLER DMA1_Stream2_IRQHandler
        ISR_HANDLER DMA1_Stream3_IRQHandler
        ISR_HANDLER DMA1_Stream4_IRQHandler
        ISR_HANDLER DMA1_Stream5_IRQHandler
        ISR_HANDLER DMA1_Stream6_IRQHandler
        ISR_HANDLER ADC_IRQHandler
        ISR_HANDLER CAN1_TX_IRQHandler
        ISR_HANDLER CAN1_RX0_IRQHandler
        ISR_HANDLER CAN1_RX1_IRQHandler
        ISR_HANDLER CAN1_SCE_IRQHandler
        ISR_HANDLER EXTI9_5_IRQHandler
        ISR_HANDLER TIM1_BRK_TIM9_IRQHandler
        ISR_HANDLER TIM1_UP_TIM10_IRQHandler
        ISR_HANDLER TIM1_TRG_COM_TIM11_IRQHandler
        ISR_HANDLER TIM1_CC_IRQHandler
        ISR_HANDLER TIM2_IRQHandler
        ISR_HANDLER TIM3_IRQHandler
        ISR_HANDLER TIM4_IRQHandler
        ISR_HANDLER I2C1_EV_IRQHandler
        ISR_HANDLER I2C1_ER_IRQHandler
        ISR_HANDLER I2C2_EV_IRQHandler
        ISR_HANDLER I2C2_ER_IRQHandler
        ISR_HANDLER SPI1_IRQHandler
        ISR_HANDLER SPI2_IRQHandler
        ISR_HANDLER USART1_IRQHandler
        ISR_HANDLER USART2_IRQHandler
        ISR_HANDLER USART3_IRQHandler
        ISR_HANDLER EXTI15_10_IRQHandler
        ISR_HANDLER RTC_Alarm_IRQHandler
        ISR_HANDLER OTG_FS_WKUP_IRQHandler
        ISR_HANDLER TIM8_BRK_TIM12_IRQHandler
        ISR_HANDLER TIM8_UP_TIM13_IRQHandler
        ISR_HANDLER TIM8_TRG_COM_TIM14_IRQHandler
        ISR_HANDLER TIM8_CC_IRQHandler
        ISR_HANDLER DMA1_Stream7_IRQHandler
        ISR_HANDLER FSMC_IRQHandler
        ISR_HANDLER SDIO_IRQHandler
        ISR_HANDLER TIM5_IRQHandler
        ISR_HANDLER SPI3_IRQHandler
        ISR_HANDLER UART4_IRQHandler
        ISR_HANDLER UART5_IRQHandler
        ISR_HANDLER TIM6_DAC_IRQHandler
        ISR_HANDLER TIM7_IRQHandler
        ISR_HANDLER DMA2_Stream0_IRQHandler
        ISR_HANDLER DMA2_Stream1_IRQHandler
        ISR_HANDLER DMA2_Stream2_IRQHandler
        ISR_HANDLER DMA2_Stream3_IRQHandler
        ISR_HANDLER DMA2_Stream4_IRQHandler
        ISR_HANDLER ETH_IRQHandler
        ISR_HANDLER ETH_WKUP_IRQHandler
        ISR_HANDLER CAN2_TX_IRQHandler
        ISR_HANDLER CAN2_RX0_IRQHandler
        ISR_HANDLER CAN2_RX1_IRQHandler
        ISR_HANDLER CAN2_SCE_IRQHandler
        ISR_HANDLER OTG_FS_IRQHandler
        ISR_HANDLER DMA2_Stream5_IRQHandler
        ISR_HANDLER DMA2_Stream6_IRQHandler
        ISR_HANDLER DMA2_Stream7_IRQHandler
        ISR_HANDLER USART6_IRQHandler
        ISR_HANDLER I2C3_EV_IRQHandler
        ISR_HANDLER I2C3_ER_IRQHandler
        ISR_HANDLER OTG_HS_EP1_OUT_IRQHandler
        ISR_HANDLER OTG_HS_EP1_IN_IRQHandler
        ISR_HANDLER OTG_HS_WKUP_IRQHandler
        ISR_HANDLER OTG_HS_IRQHandler
        ISR_HANDLER DCMI_IRQHandler
        ISR_RESERVED
        ISR_HANDLER HASH_RNG_IRQHandler
        ISR_HANDLER FPU_IRQHandler


        .section .vectors, "ax"
_vectors_end:
# 307 "C:\\Users\\esteb\\OneDrive\\Documentos\\SEGGER Embedded Studio Projects\\Tarea 1\\STM32F4xx\\Source\\stm32f407xx_Vectors.s"
        .section .init.Dummy_Handler, "ax"
        .thumb_func
        .weak Dummy_Handler
        .balign 2
Dummy_Handler:
        1: b 1b
