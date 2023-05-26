.gba
.arm
.open "sample0519.bin", OUT_FILE, 0x2000000

.org 0x2000144
  ; Reset regs (bg, dma, etc.)
  mov r0, #0x80
  swi 0x10000
  ; Reset sound regs
  mov r0, #0x40
  swi 0x10000
  ; Decompress multiboot
  ldr r0, [compressed_in]
  ldr r1,[compressed_out]
  swi 0x110000
  ; Patch out gc handshake
  ldr r0, [gc_handshake_addr]
  ldr r1, [gc_handshake_patch]
  strh r1, [r0]
  ; Patch out chipset check
  ldr r0, [chipset_check_addr]
  ldr r1, [chipset_check_patch]
  strh r1, [r0]
  ; Jump to decompressed multiboot
  ldr lr, [compressed_out]
  bx lr

  ; Most emulators load multiboot roms in 0x8000000 instead of 0x2000000,
  ; so this needs to be configuable.
  compressed_in:
    .word COMPRESSED_IN_ADDR
  compressed_out:
    .word 0x2018000

  gc_handshake_addr:
    .word 0x201e398
  gc_handshake_patch:
    ; b 0x0201e410
    .word 0xe03a
  
  chipset_check_addr:
    .word 0x201f5f6
  chipset_check_patch:
    ; mov r0, #0x0
    .word 0x2000

.close
