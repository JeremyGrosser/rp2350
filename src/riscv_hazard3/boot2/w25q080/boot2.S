# 0 "rp2350/boot_stage2/boot2_w25q080.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "rp2350/boot_stage2/boot2_w25q080.S"
# 29 "rp2350/boot_stage2/boot2_w25q080.S"
# 1 "rp2350/pico_platform/include/pico/asm_helper.S" 1






# 1 "common/pico_base_headers/include/pico.h" 1
# 26 "common/pico_base_headers/include/pico.h"
# 1 "common/pico_base_headers/include/pico/types.h" 1
# 27 "common/pico_base_headers/include/pico.h" 2
# 1 "/home/synack/src/rp2040_hal/scripts/include/pico/version.h" 1
# 28 "common/pico_base_headers/include/pico.h" 2





# 1 "common/pico_base_headers/include/pico/config.h" 1
# 19 "common/pico_base_headers/include/pico/config.h"
# 1 "/home/synack/src/rp2040_hal/scripts/include/pico/config_autogen.h" 1
# 20 "common/pico_base_headers/include/pico/config.h" 2
# 34 "common/pico_base_headers/include/pico.h" 2

# 1 "rp2350/pico_platform/include/pico/platform.h" 1
# 23 "rp2350/pico_platform/include/pico/platform.h"
# 1 "rp2_common/pico_platform_compiler/include/pico/platform/compiler.h" 1
# 18 "rp2_common/pico_platform_compiler/include/pico/platform/compiler.h"
# 1 "rp2350/hardware_regs/include/hardware/platform_defs.h" 1
# 19 "rp2_common/pico_platform_compiler/include/pico/platform/compiler.h" 2
# 24 "rp2350/pico_platform/include/pico/platform.h" 2
# 1 "rp2_common/pico_platform_sections/include/pico/platform/sections.h" 1
# 25 "rp2350/pico_platform/include/pico/platform.h" 2
# 1 "rp2_common/pico_platform_panic/include/pico/platform/panic.h" 1
# 26 "rp2350/pico_platform/include/pico/platform.h" 2
# 1 "rp2350/hardware_regs/include/hardware/regs/addressmap.h" 1
# 27 "rp2350/pico_platform/include/pico/platform.h" 2
# 1 "rp2350/hardware_regs/include/hardware/regs/sio.h" 1
# 28 "rp2350/pico_platform/include/pico/platform.h" 2

# 1 "rp2350/hardware_regs/include/hardware/regs/rvcsr.h" 1
# 30 "rp2350/pico_platform/include/pico/platform.h" 2
# 36 "common/pico_base_headers/include/pico.h" 2
# 1 "common/pico_base_headers/include/pico/error.h" 1
# 37 "common/pico_base_headers/include/pico.h" 2
# 8 "rp2350/pico_platform/include/pico/asm_helper.S" 2



# 1 "rp2_common/hardware_hazard3/include/hardware/hazard3/instructions.h" 1
# 13 "rp2_common/hardware_hazard3/include/hardware/hazard3/instructions.h"
# 1 "rp2_common/hardware_hazard3/include/hardware/hazard3/features.h" 1
# 14 "rp2_common/hardware_hazard3/include/hardware/hazard3/instructions.h" 2
# 36 "rp2_common/hardware_hazard3/include/hardware/hazard3/instructions.h"
.macro h3.bextm rd rs1 rs2 nbits
.if (\nbits < 1) || (\nbits > 8)
.err
.endif



    srl \rd, \rs1, \rs2
    andi \rd, \rd, ((1 << \nbits) - 1)

.endm







.macro h3.bextmi rd rs1 shamt nbits
.if (\nbits < 1) || (\nbits > 8)
.err
.endif
.if (\shamt < 0) || (\shamt > 31)
.err
.endif



    srli \rd, \rs1, \shamt
    andi \rd, \rd, ((1 << \nbits) - 1)

.endm
# 76 "rp2_common/hardware_hazard3/include/hardware/hazard3/instructions.h"
.macro h3.block



    nop

.endm







.macro h3.unblock



    nop

.endm
# 12 "rp2350/pico_platform/include/pico/asm_helper.S" 2
# 20 "rp2350/pico_platform/include/pico/asm_helper.S"
.macro pico_default_asm_setup






.endm


.macro regular_func x
.global \x
.type \x,%function



\x:
.endm

.macro weak_func x
.weak \x
.type \x,%function



\x:
.endm

.macro regular_func_with_section x
.section .text.\x
regular_func \x
.endm


.macro wrapper_func x
regular_func __wrap_\x
.endm

.macro weak_wrapper_func x
weak_func __wrap_\x
.endm

.macro __pre_init_with_offset func, offset, priority_string1
.section .preinit_array.\priority_string1
.p2align 2
.word \func + \offset
.endm


.macro __pre_init func, priority_string1
__pre_init_with_offset func, 0, priority_string1
.endm
# 30 "rp2350/boot_stage2/boot2_w25q080.S" 2

# 1 "rp2350/hardware_regs/include/hardware/regs/pads_qspi.h" 1
# 32 "rp2350/boot_stage2/boot2_w25q080.S" 2
# 1 "rp2350/hardware_regs/include/hardware/regs/qmi.h" 1
# 33 "rp2350/boot_stage2/boot2_w25q080.S" 2
# 143 "rp2350/boot_stage2/boot2_w25q080.S"
pico_default_asm_setup
.section .text







regular_func _stage2_boot
    mv t0, ra
_pad_config:
    li a3, 0x40040000
    li a0, ( 2 << 4 | 0x00000001 | 0)
    sw a0, 0x00000004(a3)

    li a3, 0x40040000 + (0x3 << 12)
    li a0, 0x00000002
    sw a0, 0x00000008(a3)
    sw a0, 0x0000000c(a3)
    sw a0, 0x00000010(a3)
    sw a0, 0x00000014(a3)

    li a3, 0x400d0000




program_sregs:
    li a1, ( 30 << 22 | 0x00000001 | 0x00000040 | 0)
    sw a1, 0x00000000(a3)

1:
    lw a1, 0x00000000(a3)
    andi a1, a1, 0x00000002
    bnez a1, 1b


    li a0, 0x35
    jal read_flash_sreg
    addi a0, a0, -0x02
    beqz a0, _skip_sreg_programming


    li a0, 0x06
    sw a0, 0x00000004(a3)
    jal wait_qmi_ready
    lw a0, 0x00000008(a3)


    li a0, 0x01
    sw a0, 0x00000004(a3)
    sw zero, 0x00000004(a3)
    li a0, 0x02
    sw a0, 0x00000004(a3)
    jal wait_qmi_ready
    lw a0, 0x00000008(a3)
    lw a0, 0x00000008(a3)
    lw a0, 0x00000008(a3)


1:
    li a0, 0x05
    jal read_flash_sreg
    andi a0, a0, 0x1
    bnez a0, 1b

_skip_sreg_programming:

    andi a1, a1, ~0x00000001
    sw a1, 0x00000000(a3)


_qmi_config:
    li a0, ( 1 << 30 | 2 << 8 | 2 << 0 |0)
    sw a0, 0x0000000c(a3)
    li a0, ( 0xeb << 0 | 0xa0 << 8 |0)
    sw a0, 0x00000014(a3)
    li a0, ( 0x0 << 0 | 0x2 << 2 | 0x2 << 4 | 0x2 << 6 | 0x2 << 8 | 0x1 << 12 | 0x2 << 14 | 4 << 16 |0)
    sw a0, 0x00000010(a3)


    li a1, 0x14000000
    lw a1, (a1)


    bclri a0, a0, 12
    sw a0, 0x00000010(a3)
# 331 "rp2350/boot_stage2/boot2_w25q080.S"
# 1 "rp2350/boot_stage2/asminclude/boot2_helpers/exit_from_boot2.S" 1
# 15 "rp2350/boot_stage2/asminclude/boot2_helpers/exit_from_boot2.S"
    jr t0
# 332 "rp2350/boot_stage2/boot2_w25q080.S" 2


# 1 "rp2350/boot_stage2/asminclude/boot2_helpers/wait_qmi_ready.S" 1
# 14 "rp2350/boot_stage2/asminclude/boot2_helpers/wait_qmi_ready.S"
wait_qmi_ready:
1:
    lw a0, 0x00000000(a3)
    andi a0, a0, 0x00000002
    bnez a0, 1b

    ret
# 335 "rp2350/boot_stage2/boot2_w25q080.S" 2

# 1 "rp2350/boot_stage2/asminclude/boot2_helpers/read_flash_sreg.S" 1
# 15 "rp2350/boot_stage2/asminclude/boot2_helpers/read_flash_sreg.S"
.global read_flash_sreg
.type read_flash_sreg,%function

read_flash_sreg:

    mv t1, ra
    sw a0, 0x00000004(a3)

    sw a0, 0x00000004(a3)

    jal wait_qmi_ready

    lw a0, 0x00000008(a3)
    lw a0, 0x00000008(a3)
    jr t1
# 337 "rp2350/boot_stage2/boot2_w25q080.S" 2
