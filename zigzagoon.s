.gba
.arm
.open "zigzagoon.bin", OUT_FILE, 0x2000000

.org 0x2000144
  ; Reset regs (bg, dma, etc.)
  mov r0, #0x80
  swi 0x10000
  ; Reset sound regs
  mov r0, #0x40
  swi 0x10000
  ; Decompress multiboot
  ldr r0,[compressed_in]
  ldr r1,[compressed_out]
  swi 0x110000
  ; Patch out gc handshake
  ldr r0, [gc_handshake_addr]
  ldr r1, [gc_handshake_patch]
  str r1, [r0]
  ; Patch out chipset check
  ldr r0, [chipset_check_addr]
  ldr r1, [chipset_check_patch]
  strh r1, [r0]
  ; Patch maker and game code
  ldr r0, [make_and_game_check_addr]
  ldr r1, [make_and_game_check_patch]
  strh r1, [r0]
  ; Broken RTC check
  ; It looks like the zigzagoon is only given
  ; if the player's RTC is broken, so we make
  ; the rom think it's broken.
  ldr r0, [broken_rtc_check_addr]
  ldr r1, [broken_rtc_check_patch]
  strh r1, [r0]
  ; Jump to decompressed multiboot
  ldr lr,[compressed_out]
  bx lr

  ; Most emulators load multiboot roms in 0x8000000 instead of 0x2000000,
  ; so this needs to be configuable.
  compressed_in:
    .word COMPRESSED_IN_ADDR
  compressed_out:
    .word 0x2010000    

  gc_handshake_addr:
    .word 0x20102cc
  gc_handshake_patch:
    ; nop
    ; nop
    .word 0x00000000

  chipset_check_addr:
    .word 0x201503e
  chipset_check_patch:
    ; mov r0, #0x0
    .dh 0x2000

  .align 4
  make_and_game_check_addr:
    .word 0x201041a
  make_and_game_check_patch:
    ; b 0x2010498   ; jump to "identified ruby"
    .word 0xe03d

  .align 4
  broken_rtc_check_addr:
    .word 0x201072a
  broken_rtc_check_patch:
    ; b 0x0201073c  ; jump to "yeah, it's broken"
    .dh 0xe007

.close
