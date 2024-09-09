.syntax unified
.cpu cortex-m33
.thumb

.section .vectors, "ax"
.align 2
.global __vectors
__vectors:
.word __StackTop
.word _reset_handler
.word isr_nmi
.word isr_hardfault
.word isr_memmanage
.word isr_busfault
.word isr_usagefault
.word isr_securefault
.word isr_invalid
.word isr_invalid
.word isr_invalid
.word isr_svcall
.word isr_debugmonitor
.word isr_invalid
.word isr_pendsv
.word isr_systick

.word isr_irq0
.word isr_irq1
.word isr_irq2
.word isr_irq3
.word isr_irq4
.word isr_irq5
.word isr_irq6
.word isr_irq7
.word isr_irq8
.word isr_irq9
.word isr_irq10
.word isr_irq11
.word isr_irq12
.word isr_irq13
.word isr_irq14
.word isr_irq15
.word isr_irq16
.word isr_irq17
.word isr_irq18
.word isr_irq19
.word isr_irq20
.word isr_irq21
.word isr_irq22
.word isr_irq23
.word isr_irq24
.word isr_irq25
.word isr_irq26
.word isr_irq27
.word isr_irq28
.word isr_irq29
.word isr_irq30
.word isr_irq31
.word isr_irq32
.word isr_irq33
.word isr_irq34
.word isr_irq35
.word isr_irq36
.word isr_irq37
.word isr_irq38
.word isr_irq39
.word isr_irq40
.word isr_irq41
.word isr_irq42
.word isr_irq43
.word isr_irq44
.word isr_irq45
.word isr_irq46
.word isr_irq47
.word isr_irq48
.word isr_irq49
.word isr_irq50
.word isr_irq51

.macro decl_isr_bkpt name
.weak \name
.type \name,%function
.thumb_func
\name:
    bkpt #0
.endm

.macro decl_isr name
.weak \name
.type \name,%function
.thumb_set \name,__gnat_irq_trap
.endm

decl_isr_bkpt isr_invalid
decl_isr_bkpt isr_nmi
decl_isr_bkpt isr_hardfault
decl_isr_bkpt isr_memmanage
decl_isr_bkpt isr_busfault
decl_isr_bkpt isr_usagefault
decl_isr_bkpt isr_securefault
decl_isr_bkpt isr_svcall
decl_isr_bkpt isr_debugmonitor
decl_isr_bkpt isr_pendsv
decl_isr_bkpt isr_systick

decl_isr isr_irq0
decl_isr isr_irq1
decl_isr isr_irq2
decl_isr isr_irq3
decl_isr isr_irq4
decl_isr isr_irq5
decl_isr isr_irq6
decl_isr isr_irq7
decl_isr isr_irq8
decl_isr isr_irq9
decl_isr isr_irq10
decl_isr isr_irq11
decl_isr isr_irq12
decl_isr isr_irq13
decl_isr isr_irq14
decl_isr isr_irq15
decl_isr isr_irq16
decl_isr isr_irq17
decl_isr isr_irq18
decl_isr isr_irq19
decl_isr isr_irq20
decl_isr isr_irq21
decl_isr isr_irq22
decl_isr isr_irq23
decl_isr isr_irq24
decl_isr isr_irq25
decl_isr isr_irq26
decl_isr isr_irq27
decl_isr isr_irq28
decl_isr isr_irq29
decl_isr isr_irq30
decl_isr isr_irq31
decl_isr isr_irq32
decl_isr isr_irq33
decl_isr isr_irq34
decl_isr isr_irq35
decl_isr isr_irq36
decl_isr isr_irq37
decl_isr isr_irq38
decl_isr isr_irq39
decl_isr isr_irq40
decl_isr isr_irq41
decl_isr isr_irq42
decl_isr isr_irq43
decl_isr isr_irq44
decl_isr isr_irq45
decl_isr isr_irq46
decl_isr isr_irq47
decl_isr isr_irq48
decl_isr isr_irq49
decl_isr isr_irq50
decl_isr isr_irq51

.section .reset, "ax"
.type _entry_point,%function
.thumb_func
.global _entry_point
_entry_point:
    movs r0, #0
    ldr r1, =(0xe0000000 + 0x0000ed08)
    str r0, [r1]
    ldmia r0!, {r1, r2}
    msr msp, r1
    bx r2

.type _reset_handler,%function
.thumb_func
_reset_handler:
    ldr r0, =(0xd0000000 + 0x00000000)
    ldr r0, [r0]
    cmp r0, #0
    bne _core1_idle

    bl main
    b _entry_point

_core1_idle:
    wfe
    b _core1_idle

.weak __gnat_irq_trap
.type __gnat_irq_trap,%function
.thumb_func
.global __gnat_irq_trap
__gnat_irq_trap:
    bkpt #0
