        .syntax unified
        .global _start
        .global SysTick_Handler
        .text

        .equ SYST_CSR,             0xE000E010
        .equ SYST_RVR,             0xE000E014
        .equ SYST_CVR,             0xE000E018
        
        .equ RCC_BASE,             0x40023800
        .equ RCC_OFFSET,           0x30

        .equ GPIOA_BASE,           0x40020000
        .equ GPIOB_BASE,           0x40020400
        .equ GPIOE_BASE,           0x40021000

        .equ MODER_OFFSET,         0x00
        .equ PUPDR_OFFSET,         0x0C
        .equ IDR_OFFSET,           0x10
        .equ ODR_OFFSET,           0x14


        .thumb_func
_start:
         //Se pone en cero el clock
       LDR R0,=SYST_CSR
       MOV R1,0x00
       STR R1, [R0]
       //Se pone el numero de ciclos
       LDR R1,=15999
       LDR R0,=SYST_RVR
       STR R1, [R0]
       //se borran el registro del contador
       LDR R1,=0
       LDR R0,=SYST_CVR
       STR R1, [R0]
       //Se configuran el clksource y el tickint
       MOV R1,0x7
       LDR R0,=SYST_CSR
       STR R1, [R0]

       //Se habilita el reloj
       LDR R0, =RCC_BASE
       LDR R1, [R0, #RCC_OFFSET]
       ORR R1, R1, #0x13          // bit0=GPIOA, bit1=GPIOB, bit4=GPIOE
       STR R1, [R0, #RCC_OFFSET]

       MOV R3, #7
       ADD R4, R3, #8
       LDR R0,=GPIOE_BASE
       BL pines

      
       //PA8
       LDR R0,=GPIOA_BASE
       LDR R1,[R0, #MODER_OFFSET]
       MOV R2,0x01
       LSL R2, R2, #16
       ORR R1,R1,R2
       STR R1, [R0, #MODER_OFFSET]
        
       MOV R2, 0x01
       LSL R2, R2, #17
       BIC R1,R1,R2
       STR R1, [R0, #MODER_OFFSET]

       LDR R0,=GPIOA_BASE
       LDR R1,[R0, #MODER_OFFSET]
       MOV R2,0x03
       BIC R1,R1,R2
       STR R1, [R0, #MODER_OFFSET]
       //PA0

       LDR R1,[R0, #PUPDR_OFFSET]
       MOV R2,0x01
       LSL R2, R2, #1
       ORR R1,R1,R2
       STR R1, [R0, #PUPDR_OFFSET]
        
       LDR R0, =GPIOE_BASE
       LDR R1, [R0, #ODR_OFFSET]
       MOV R2, 0
       STR R2, [R0, #ODR_OFFSET]

       LDR R0, =GPIOA_BASE
       LDR R1, [R0, #ODR_OFFSET]
       MOV R3, 0x01
       BIC R2, R1, R3, LSL #8
       STR R2, [R0, #ODR_OFFSET]

       MOV R8, #0
       MOV R9, #0
       MOV R10, #0
       MOV R4, #0
       MOV R12, 1


loop:
       CMP R12, 1
       BNE pulso

       CMP R10, #10
       BEQ boton

       CMP R9, #150
       BLT loop

       MOV R9, #0
       B instruccion
instruccion:
           // enciende el led correspondiente de la matriz
       LDR R0, =GPIOE_BASE
       LDR R1, [R0, #ODR_OFFSET]
       MOV R2, #1
       LSL R2, R2, #7
       LSL R2, R2, R8
       EOR R1, R1, R2
       STR R1, [R0, #ODR_OFFSET]
       CMP R8, #0
       BEQ borrar
       B continuar
borrar:
       //Apaga únicamente el led correspondiente al ODR14
       LDR R0, =GPIOE_BASE
       LDR R1, [R0, #ODR_OFFSET]
       MOV R2, #1
       LSL R2, R2, #14
       BIC R1, R1, R2
       STR R1, [R0, #ODR_OFFSET]
       B continuar
continuar:
       //Apaga el led anterior al encendido actualmente
       LSR R2, R2, #1
       BIC R1, R1, R2
       STR R1, [R0, #ODR_OFFSET]

       ADD R8, R8, #1
       CMP R8, #7
       BLE loop

       MOV R8, #0
      b loop
SysTick_Handler:
        ADD R9,  R9,  #1
        ADD R10, R10, #1
        ADD R7,  R7,  #1
        BX LR
boton:
        // Antirebote de 10ms
        MOV R10, #0
        LDR R0, =GPIOA_BASE
        LDR R1, [R0, #IDR_OFFSET]
        MOV R3, #1
        AND R1, R3, R1
        CMP R1, #1
        BEQ pulso
        
        B loop
pulso:
        // Comprueba si el led seleccionado es el correcto y actua en base a eso
        MOV R12, 2
        LDR R0, =GPIOE_BASE
        LDR R1, [R0, #ODR_OFFSET]
        CMP R1, 2048
        BEQ Ganaste

        b perdiste
        //Hace la animación de victoria
Ganaste:
       CMP R9, #500
       BLT Ganaste
       MOV R9, #0

       ganaste1:
       LDR R0, =GPIOE_BASE
       LDR R1, [R0, #ODR_OFFSET]
       MOV R2, #1
       LSL R2, R2, #11
       BIC R1, R1, R2
       STR R1, [R0, #ODR_OFFSET]
       CMP R9, #500
       BLT ganaste1

       LDR R0, =GPIOE_BASE
       LDR R1, [R0, #ODR_OFFSET]
       MOV R2, #1
       LSL R2, R2, #11
       ORR R1, R1, R2
       STR R1, [R0, #ODR_OFFSET]
       MOV R9, #0
       ADD R4, R4, #1
       CMP R4, #3
       BNE loop

       MOV R4, #0
       MOV R12, 1
       MOV R8, #0
       MOV R10, #0
       LDR R0, =GPIOE_BASE
       LDR R1, [R0, #ODR_OFFSET]
       MOV R2, #1
       LSL R2, R2, #11
       BIC R1, R1, R2
       STR R1, [R0, #ODR_OFFSET]
       b loop    
//Hace la animación de derrota
perdiste:
       CMP R9, #2000
       BLT perdiste
       MOV R12, 1
       MOV R8, #0
       MOV R10, #0

       LSL R2, R2, #1
       LDR R0, =GPIOE_BASE
       LDR R1, [R0, #ODR_OFFSET]
       BIC R1, R1, R2
       STR R1, [R0, #ODR_OFFSET]

       b loop
       //Habilita los pines a declarando el pin inicial y cuantos pines a partir de este
pines:
       PUSH {LR}
       loop_pines:
       LSL R3, R3, #1
       LDR R1,[R0, #MODER_OFFSET]
       MOV R2,0x01
       LSL R2, R2, R3
       ORR R1,R1,R2
       STR R1, [R0, #MODER_OFFSET]
       ADD R5, R3, #1
        
       MOV R2, 0x01
       LSL R2, R2, R5
       BIC R1,R1,R2
       STR R1, [R0, #MODER_OFFSET]
       LSR R3, R3, #1
       ADD R3, R3, #1
       CMP R3, R4
       BNE loop_pines
       POP {LR}
        BX LR

        