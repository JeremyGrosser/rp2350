# 0 "rp2350/boot_stage2/boot2_generic_03h.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "rp2350/boot_stage2/boot2_generic_03h.S"
# 19 "rp2350/boot_stage2/boot2_generic_03h.S"
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
# 20 "rp2350/boot_stage2/boot2_generic_03h.S" 2

# 1 "rp2350/hardware_regs/include/hardware/regs/qmi.h" 1
# 22 "rp2350/boot_stage2/boot2_generic_03h.S" 2
# 88 "rp2350/boot_stage2/boot2_generic_03h.S"
pico_default_asm_setup

.section .text


regular_func _stage2_boot

    mv t0, ra
    li a3, 0x400d0000
    li a0, ( 1 << 30 | 1 << 8 | 4 << 0 |0)
    sw a0, 0x0000000c(a3)
    li a0, ( 0x03 << 0 |0)
    sw a0, 0x00000014(a3)
    li a0, ( 0x0 << 0 | 0x0 << 2 | 0x0 << 4 | 0x0 << 6 | 0x0 << 8 | 0x1 << 12 |0)
    sw a0, 0x00000010(a3)
# 115 "rp2350/boot_stage2/boot2_generic_03h.S"
# 1 "rp2350/boot_stage2/asminclude/boot2_helpers/exit_from_boot2.S" 1
# 15 "rp2350/boot_stage2/asminclude/boot2_helpers/exit_from_boot2.S"
    jr t0
# 116 "rp2350/boot_stage2/boot2_generic_03h.S" 2
