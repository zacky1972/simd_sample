	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 11, 3
	.file	1 "/Users/zacky/github/simd_sample" "native/arm/monochrome_filter_1.c"
	.file	2 "/Library/Developer/CommandLineTools/usr/lib/clang/12.0.5/include" "arm_neon.h"
	.file	3 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_types" "_uint8_t.h"
	.file	4 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types" "_int8_t.h"
	.file	5 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_types" "_uint16_t.h"
	.file	6 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_types" "_uint32_t.h"
	.globl	_monochrome_filter_1            ; -- Begin function monochrome_filter_1
	.p2align	2
_monochrome_filter_1:                   ; @monochrome_filter_1
Lfunc_begin0:
	.loc	1 66 0                          ; native/arm/monochrome_filter_1.c:66:0
	.cfi_startproc
; %bb.0:
	;DEBUG_VALUE: monochrome_filter_1:size <- $x0
	;DEBUG_VALUE: monochrome_filter_1:size <- $x0
	;DEBUG_VALUE: monochrome_filter_1:pixel_r <- $x1
	;DEBUG_VALUE: monochrome_filter_1:pixel_r <- $x1
	;DEBUG_VALUE: monochrome_filter_1:pixel_g <- $x2
	;DEBUG_VALUE: monochrome_filter_1:pixel_g <- $x2
	;DEBUG_VALUE: monochrome_filter_1:pixel_b <- $x3
	;DEBUG_VALUE: monochrome_filter_1:pixel_b <- $x3
	;DEBUG_VALUE: i <- 0
	;DEBUG_VALUE: monochrome_filter_1:f32x4_mono_r <- undef
	;DEBUG_VALUE: monochrome_filter_1:f32x4_mono_g <- undef
	;DEBUG_VALUE: monochrome_filter_1:f32x4_mono_b <- undef
	.loc	1 71 5 prologue_end             ; native/arm/monochrome_filter_1.c:71:5
	cbz	x0, LBB0_3
Ltmp0:
; %bb.1:                                ; %.lr.ph.preheader
	;DEBUG_VALUE: monochrome_filter_1:pixel_b <- $x3
	;DEBUG_VALUE: monochrome_filter_1:pixel_g <- $x2
	;DEBUG_VALUE: monochrome_filter_1:pixel_r <- $x1
	;DEBUG_VALUE: monochrome_filter_1:size <- $x0
	;DEBUG_VALUE: i <- 0
	.loc	1 0 5 is_stmt 0                 ; native/arm/monochrome_filter_1.c:0:5
	mov	x8, #0
	mov	w9, #5767
	movk	w9, #16025, lsl #16
	dup.4s	v0, w9
	mov	w9, #17826
	movk	w9, #16150, lsl #16
	dup.4s	v1, w9
	mov	w9, #30933
	movk	w9, #15849, lsl #16
	dup.4s	v2, w9
Ltmp1:
LBB0_2:                                 ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
	;DEBUG_VALUE: monochrome_filter_1:pixel_b <- $x3
	;DEBUG_VALUE: monochrome_filter_1:pixel_g <- $x2
	;DEBUG_VALUE: monochrome_filter_1:pixel_r <- $x1
	;DEBUG_VALUE: monochrome_filter_1:size <- $x0
	;DEBUG_VALUE: i <- $w8
	.loc	1 80 92 is_stmt 1               ; native/arm/monochrome_filter_1.c:80:92
	ldr	q3, [x1, x8]
Ltmp2:
	;DEBUG_VALUE: u8x16_pixel_r <- $q3
	;DEBUG_VALUE: __ret <- $q3
	.loc	1 81 92                         ; native/arm/monochrome_filter_1.c:81:92
	ldr	q4, [x2, x8]
Ltmp3:
	;DEBUG_VALUE: u8x16_pixel_g <- $q4
	;DEBUG_VALUE: __ret <- $q4
	.loc	1 83 40                         ; native/arm/monochrome_filter_1.c:83:40
	ushll.8h	v5, v3, #0
Ltmp4:
	;DEBUG_VALUE: u16x8_pixel_r_low <- $q5
	.loc	1 84 41                         ; native/arm/monochrome_filter_1.c:84:41
	ushll2.8h	v3, v3, #0
Ltmp5:
	;DEBUG_VALUE: u16x8_pixel_r_high <- $q3
	.loc	1 86 40                         ; native/arm/monochrome_filter_1.c:86:40
	ushll.8h	v6, v4, #0
Ltmp6:
	;DEBUG_VALUE: u16x8_pixel_g_low <- $q6
	.loc	1 87 41                         ; native/arm/monochrome_filter_1.c:87:41
	ushll2.8h	v4, v4, #0
Ltmp7:
	;DEBUG_VALUE: u32x4_pixel_g_low_high <- undef
	;DEBUG_VALUE: u32x4_pixel_g_low_low <- undef
	;DEBUG_VALUE: u32x4_pixel_r_low_high <- undef
	;DEBUG_VALUE: u32x4_pixel_r_low_low <- undef
	;DEBUG_VALUE: u16x8_pixel_g_high <- $q4
	.loc	1 95 92                         ; native/arm/monochrome_filter_1.c:95:92
	ldr	q7, [x3, x8]
Ltmp8:
	;DEBUG_VALUE: u8x16_pixel_b <- $q7
	;DEBUG_VALUE: __ret <- $q7
	.loc	1 97 45                         ; native/arm/monochrome_filter_1.c:97:45
	ushll.4s	v16, v5, #0
	ucvtf.4s	v16, v16
Ltmp9:
	;DEBUG_VALUE: f32x4_pixel_r_low_low <- undef
	.loc	1 98 45                         ; native/arm/monochrome_filter_1.c:98:45
	ushll.4s	v17, v6, #0
	ucvtf.4s	v17, v17
Ltmp10:
	;DEBUG_VALUE: f32x4_pixel_g_low_low <- undef
	.loc	1 99 45                         ; native/arm/monochrome_filter_1.c:99:45
	fmul.4s	v16, v16, v0
Ltmp11:
	;DEBUG_VALUE: f32x4_pixel_m_low_low <- $q16
	.loc	1 101 40                        ; native/arm/monochrome_filter_1.c:101:40
	ushll.8h	v18, v7, #0
Ltmp12:
	;DEBUG_VALUE: u16x8_pixel_b_low <- $q18
	.loc	1 102 41                        ; native/arm/monochrome_filter_1.c:102:41
	ushll2.8h	v7, v7, #0
Ltmp13:
	;DEBUG_VALUE: u16x8_pixel_b_high <- $q7
	.loc	1 104 33                        ; native/arm/monochrome_filter_1.c:104:33
	fmul.4s	v17, v17, v1
	fadd.4s	v16, v16, v17
Ltmp14:
	;DEBUG_VALUE: u32x4_pixel_b_low_high <- undef
	;DEBUG_VALUE: u32x4_pixel_b_low_low <- undef
	;DEBUG_VALUE: f32x4_pixel_m_low_low <- $q16
	.loc	1 108 45                        ; native/arm/monochrome_filter_1.c:108:45
	ushll.4s	v17, v18, #0
	ucvtf.4s	v17, v17
Ltmp15:
	;DEBUG_VALUE: f32x4_pixel_b_low_low <- undef
	.loc	1 110 33                        ; native/arm/monochrome_filter_1.c:110:33
	fmul.4s	v17, v17, v2
	fadd.4s	v16, v17, v16
Ltmp16:
	;DEBUG_VALUE: f32x4_pixel_m_low_low <- $q16
	.loc	1 112 46                        ; native/arm/monochrome_filter_1.c:112:46
	ushll2.4s	v5, v5, #0
Ltmp17:
	ucvtf.4s	v5, v5
Ltmp18:
	;DEBUG_VALUE: f32x4_pixel_r_low_high <- undef
	.loc	1 113 46                        ; native/arm/monochrome_filter_1.c:113:46
	ushll2.4s	v6, v6, #0
Ltmp19:
	ucvtf.4s	v6, v6
Ltmp20:
	;DEBUG_VALUE: f32x4_pixel_g_low_high <- undef
	.loc	1 114 46                        ; native/arm/monochrome_filter_1.c:114:46
	fmul.4s	v5, v5, v0
Ltmp21:
	;DEBUG_VALUE: f32x4_pixel_m_low_high <- $q5
	.loc	1 116 34                        ; native/arm/monochrome_filter_1.c:116:34
	fmul.4s	v6, v6, v1
	fadd.4s	v5, v5, v6
Ltmp22:
	;DEBUG_VALUE: f32x4_pixel_m_low_high <- $q5
	.loc	1 117 46                        ; native/arm/monochrome_filter_1.c:117:46
	ushll2.4s	v6, v18, #0
	ucvtf.4s	v6, v6
Ltmp23:
	;DEBUG_VALUE: f32x4_pixel_b_low_high <- undef
	.loc	1 118 34                        ; native/arm/monochrome_filter_1.c:118:34
	fmul.4s	v6, v6, v2
	fadd.4s	v5, v6, v5
Ltmp24:
	;DEBUG_VALUE: f32x4_pixel_m_low_high <- $q5
	.loc	1 121 23                        ; native/arm/monochrome_filter_1.c:121:23
	fcvtnu.4s	v6, v16
	.loc	1 121 13 is_stmt 0              ; native/arm/monochrome_filter_1.c:121:13
	xtn.4h	v6, v6
	.loc	1 122 23 is_stmt 1              ; native/arm/monochrome_filter_1.c:122:23
	fcvtnu.4s	v5, v5
Ltmp25:
	.loc	1 120 40                        ; native/arm/monochrome_filter_1.c:120:40
	xtn2.8h	v6, v5
Ltmp26:
	;DEBUG_VALUE: u32x4_pixel_g_high_high <- undef
	;DEBUG_VALUE: u32x4_pixel_g_high_low <- undef
	;DEBUG_VALUE: u32x4_pixel_r_high_high <- undef
	;DEBUG_VALUE: u32x4_pixel_r_high_low <- undef
	;DEBUG_VALUE: u16x8_pixel_m_low <- $q6
	.loc	1 130 46                        ; native/arm/monochrome_filter_1.c:130:46
	ushll.4s	v5, v3, #0
	ucvtf.4s	v5, v5
Ltmp27:
	;DEBUG_VALUE: f32x4_pixel_r_high_low <- undef
	.loc	1 131 46                        ; native/arm/monochrome_filter_1.c:131:46
	ushll.4s	v16, v4, #0
Ltmp28:
	ucvtf.4s	v16, v16
Ltmp29:
	;DEBUG_VALUE: f32x4_pixel_g_high_low <- undef
	.loc	1 132 46                        ; native/arm/monochrome_filter_1.c:132:46
	fmul.4s	v5, v5, v0
Ltmp30:
	;DEBUG_VALUE: f32x4_pixel_m_high_low <- $q5
	.loc	1 134 34                        ; native/arm/monochrome_filter_1.c:134:34
	fmul.4s	v16, v16, v1
	fadd.4s	v5, v5, v16
Ltmp31:
	;DEBUG_VALUE: u32x4_pixel_b_high_high <- undef
	;DEBUG_VALUE: u32x4_pixel_b_high_low <- undef
	;DEBUG_VALUE: f32x4_pixel_m_high_low <- $q5
	.loc	1 138 46                        ; native/arm/monochrome_filter_1.c:138:46
	ushll.4s	v16, v7, #0
	ucvtf.4s	v16, v16
Ltmp32:
	;DEBUG_VALUE: f32x4_pixel_b_high_low <- undef
	.loc	1 140 34                        ; native/arm/monochrome_filter_1.c:140:34
	fmul.4s	v16, v16, v2
	fadd.4s	v5, v16, v5
Ltmp33:
	;DEBUG_VALUE: f32x4_pixel_m_high_low <- $q5
	.loc	1 142 47                        ; native/arm/monochrome_filter_1.c:142:47
	ushll2.4s	v3, v3, #0
Ltmp34:
	ucvtf.4s	v3, v3
Ltmp35:
	;DEBUG_VALUE: f32x4_pixel_r_high_high <- undef
	.loc	1 143 47                        ; native/arm/monochrome_filter_1.c:143:47
	ushll2.4s	v4, v4, #0
Ltmp36:
	ucvtf.4s	v4, v4
Ltmp37:
	;DEBUG_VALUE: f32x4_pixel_g_high_high <- undef
	.loc	1 144 47                        ; native/arm/monochrome_filter_1.c:144:47
	fmul.4s	v3, v3, v0
Ltmp38:
	;DEBUG_VALUE: f32x4_pixel_m_high_high <- $q3
	.loc	1 146 35                        ; native/arm/monochrome_filter_1.c:146:35
	fmul.4s	v4, v4, v1
	fadd.4s	v3, v3, v4
Ltmp39:
	;DEBUG_VALUE: f32x4_pixel_m_high_high <- $q3
	.loc	1 147 47                        ; native/arm/monochrome_filter_1.c:147:47
	ushll2.4s	v4, v7, #0
	ucvtf.4s	v4, v4
Ltmp40:
	;DEBUG_VALUE: f32x4_pixel_b_high_high <- undef
	.loc	1 148 35                        ; native/arm/monochrome_filter_1.c:148:35
	fmul.4s	v4, v4, v2
	fadd.4s	v3, v4, v3
Ltmp41:
	;DEBUG_VALUE: f32x4_pixel_m_high_high <- $q3
	.loc	1 151 23                        ; native/arm/monochrome_filter_1.c:151:23
	fcvtnu.4s	v4, v5
	.loc	1 151 13 is_stmt 0              ; native/arm/monochrome_filter_1.c:151:13
	xtn.4h	v4, v4
	.loc	1 152 23 is_stmt 1              ; native/arm/monochrome_filter_1.c:152:23
	fcvtnu.4s	v3, v3
Ltmp42:
	.loc	1 150 41                        ; native/arm/monochrome_filter_1.c:150:41
	xtn2.8h	v4, v3
Ltmp43:
	;DEBUG_VALUE: u16x8_pixel_m_high <- $q4
	.loc	1 155 13                        ; native/arm/monochrome_filter_1.c:155:13
	xtn.8b	v3, v6
	.loc	1 154 36                        ; native/arm/monochrome_filter_1.c:154:36
	xtn2.16b	v3, v4
Ltmp44:
	;DEBUG_VALUE: __s1 <- $q3
	;DEBUG_VALUE: u8x16_pixel_m <- $q3
	.loc	1 158 59                        ; native/arm/monochrome_filter_1.c:158:59
	str	q3, [x1, x8]
Ltmp45:
	;DEBUG_VALUE: __s1 <- $q3
	.loc	1 159 59                        ; native/arm/monochrome_filter_1.c:159:59
	str	q3, [x2, x8]
Ltmp46:
	;DEBUG_VALUE: __s1 <- $q3
	.loc	1 160 59                        ; native/arm/monochrome_filter_1.c:160:59
	str	q3, [x3, x8]
Ltmp47:
	.loc	1 71 43                         ; native/arm/monochrome_filter_1.c:71:43
	add	w8, w8, #16                     ; =16
Ltmp48:
	;DEBUG_VALUE: i <- $w8
	.loc	1 71 31 is_stmt 0               ; native/arm/monochrome_filter_1.c:71:31
	and	x8, x8, #0xffff
Ltmp49:
	.loc	1 71 5                          ; native/arm/monochrome_filter_1.c:71:5
	cmp	x8, x0
	b.lo	LBB0_2
Ltmp50:
LBB0_3:                                 ; %._crit_edge
	;DEBUG_VALUE: monochrome_filter_1:pixel_b <- $x3
	;DEBUG_VALUE: monochrome_filter_1:pixel_g <- $x2
	;DEBUG_VALUE: monochrome_filter_1:pixel_r <- $x1
	;DEBUG_VALUE: monochrome_filter_1:size <- $x0
	.loc	1 162 1 is_stmt 1               ; native/arm/monochrome_filter_1.c:162:1
	ret
Ltmp51:
Lfunc_end0:
	.cfi_endproc
                                        ; -- End function
	.globl	_init_monochrome_filter_1       ; -- Begin function init_monochrome_filter_1
	.p2align	2
_init_monochrome_filter_1:              ; @init_monochrome_filter_1
Lfunc_begin1:
	.loc	1 165 0                         ; native/arm/monochrome_filter_1.c:165:0
	.cfi_startproc
; %bb.0:
	.loc	1 167 1 prologue_end            ; native/arm/monochrome_filter_1.c:167:1
	ret
Ltmp52:
Lfunc_end1:
	.cfi_endproc
                                        ; -- End function
	.file	7 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/arm" "_types.h"
	.file	8 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types" "_size_t.h"
	.file	9 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include" "stdint.h"
	.section	__DWARF,__debug_loc,regular,debug
Lsection_debug_loc:
Ldebug_loc0:
.set Lset0, Lfunc_begin0-Lfunc_begin0
	.quad	Lset0
.set Lset1, Ltmp1-Lfunc_begin0
	.quad	Lset1
	.short	2                               ; Loc expr size
	.byte	48                              ; DW_OP_lit0
	.byte	159                             ; DW_OP_stack_value
.set Lset2, Ltmp1-Lfunc_begin0
	.quad	Lset2
.set Lset3, Ltmp49-Lfunc_begin0
	.quad	Lset3
	.short	1                               ; Loc expr size
	.byte	88                              ; DW_OP_reg8
	.quad	0
	.quad	0
Ldebug_loc1:
.set Lset4, Ltmp2-Lfunc_begin0
	.quad	Lset4
.set Lset5, Ltmp5-Lfunc_begin0
	.quad	Lset5
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	67                              ; 67
	.quad	0
	.quad	0
Ldebug_loc2:
.set Lset6, Ltmp2-Lfunc_begin0
	.quad	Lset6
.set Lset7, Ltmp5-Lfunc_begin0
	.quad	Lset7
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	67                              ; 67
	.quad	0
	.quad	0
Ldebug_loc3:
.set Lset8, Ltmp3-Lfunc_begin0
	.quad	Lset8
.set Lset9, Ltmp7-Lfunc_begin0
	.quad	Lset9
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	68                              ; 68
	.quad	0
	.quad	0
Ldebug_loc4:
.set Lset10, Ltmp3-Lfunc_begin0
	.quad	Lset10
.set Lset11, Ltmp7-Lfunc_begin0
	.quad	Lset11
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	68                              ; 68
	.quad	0
	.quad	0
Ldebug_loc5:
.set Lset12, Ltmp4-Lfunc_begin0
	.quad	Lset12
.set Lset13, Ltmp17-Lfunc_begin0
	.quad	Lset13
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	69                              ; 69
	.quad	0
	.quad	0
Ldebug_loc6:
.set Lset14, Ltmp5-Lfunc_begin0
	.quad	Lset14
.set Lset15, Ltmp34-Lfunc_begin0
	.quad	Lset15
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	67                              ; 67
	.quad	0
	.quad	0
Ldebug_loc7:
.set Lset16, Ltmp6-Lfunc_begin0
	.quad	Lset16
.set Lset17, Ltmp19-Lfunc_begin0
	.quad	Lset17
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	70                              ; 70
	.quad	0
	.quad	0
Ldebug_loc8:
.set Lset18, Ltmp7-Lfunc_begin0
	.quad	Lset18
.set Lset19, Ltmp36-Lfunc_begin0
	.quad	Lset19
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	68                              ; 68
	.quad	0
	.quad	0
Ldebug_loc9:
.set Lset20, Ltmp8-Lfunc_begin0
	.quad	Lset20
.set Lset21, Ltmp13-Lfunc_begin0
	.quad	Lset21
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	71                              ; 71
	.quad	0
	.quad	0
Ldebug_loc10:
.set Lset22, Ltmp8-Lfunc_begin0
	.quad	Lset22
.set Lset23, Ltmp13-Lfunc_begin0
	.quad	Lset23
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	71                              ; 71
	.quad	0
	.quad	0
Ldebug_loc11:
.set Lset24, Ltmp11-Lfunc_begin0
	.quad	Lset24
.set Lset25, Ltmp28-Lfunc_begin0
	.quad	Lset25
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	80                              ; 80
	.quad	0
	.quad	0
Ldebug_loc12:
.set Lset26, Ltmp12-Lfunc_begin0
	.quad	Lset26
.set Lset27, Ltmp50-Lfunc_begin0
	.quad	Lset27
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	82                              ; 82
	.quad	0
	.quad	0
Ldebug_loc13:
.set Lset28, Ltmp13-Lfunc_begin0
	.quad	Lset28
.set Lset29, Ltmp50-Lfunc_begin0
	.quad	Lset29
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	71                              ; 71
	.quad	0
	.quad	0
Ldebug_loc14:
.set Lset30, Ltmp21-Lfunc_begin0
	.quad	Lset30
.set Lset31, Ltmp25-Lfunc_begin0
	.quad	Lset31
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	69                              ; 69
	.quad	0
	.quad	0
Ldebug_loc15:
.set Lset32, Ltmp26-Lfunc_begin0
	.quad	Lset32
.set Lset33, Ltmp50-Lfunc_begin0
	.quad	Lset33
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	70                              ; 70
	.quad	0
	.quad	0
Ldebug_loc16:
.set Lset34, Ltmp30-Lfunc_begin0
	.quad	Lset34
.set Lset35, Ltmp50-Lfunc_begin0
	.quad	Lset35
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	69                              ; 69
	.quad	0
	.quad	0
Ldebug_loc17:
.set Lset36, Ltmp38-Lfunc_begin0
	.quad	Lset36
.set Lset37, Ltmp42-Lfunc_begin0
	.quad	Lset37
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	67                              ; 67
	.quad	0
	.quad	0
Ldebug_loc18:
.set Lset38, Ltmp43-Lfunc_begin0
	.quad	Lset38
.set Lset39, Ltmp50-Lfunc_begin0
	.quad	Lset39
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	68                              ; 68
	.quad	0
	.quad	0
Ldebug_loc19:
.set Lset40, Ltmp44-Lfunc_begin0
	.quad	Lset40
.set Lset41, Ltmp50-Lfunc_begin0
	.quad	Lset41
	.short	2                               ; Loc expr size
	.byte	144                             ; DW_OP_regx
	.byte	67                              ; 67
	.quad	0
	.quad	0
	.section	__DWARF,__debug_abbrev,regular,debug
Lsection_abbrev:
	.byte	1                               ; Abbreviation Code
	.byte	17                              ; DW_TAG_compile_unit
	.byte	1                               ; DW_CHILDREN_yes
	.byte	37                              ; DW_AT_producer
	.byte	14                              ; DW_FORM_strp
	.byte	19                              ; DW_AT_language
	.byte	5                               ; DW_FORM_data2
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.ascii	"\202|"                         ; DW_AT_LLVM_sysroot
	.byte	14                              ; DW_FORM_strp
	.byte	16                              ; DW_AT_stmt_list
	.byte	23                              ; DW_FORM_sec_offset
	.byte	27                              ; DW_AT_comp_dir
	.byte	14                              ; DW_FORM_strp
	.ascii	"\341\177"                      ; DW_AT_APPLE_optimized
	.byte	25                              ; DW_FORM_flag_present
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	2                               ; Abbreviation Code
	.byte	52                              ; DW_TAG_variable
	.byte	0                               ; DW_CHILDREN_no
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	3                               ; Abbreviation Code
	.byte	1                               ; DW_TAG_array_type
	.byte	1                               ; DW_CHILDREN_yes
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	4                               ; Abbreviation Code
	.byte	33                              ; DW_TAG_subrange_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	55                              ; DW_AT_count
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	5                               ; Abbreviation Code
	.byte	36                              ; DW_TAG_base_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	62                              ; DW_AT_encoding
	.byte	11                              ; DW_FORM_data1
	.byte	11                              ; DW_AT_byte_size
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	6                               ; Abbreviation Code
	.byte	36                              ; DW_TAG_base_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	11                              ; DW_AT_byte_size
	.byte	11                              ; DW_FORM_data1
	.byte	62                              ; DW_AT_encoding
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	7                               ; Abbreviation Code
	.byte	22                              ; DW_TAG_typedef
	.byte	0                               ; DW_CHILDREN_no
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	8                               ; Abbreviation Code
	.byte	1                               ; DW_TAG_array_type
	.byte	1                               ; DW_CHILDREN_yes
	.ascii	"\207B"                         ; DW_AT_GNU_vector
	.byte	25                              ; DW_FORM_flag_present
	.byte	11                              ; DW_AT_byte_size
	.byte	11                              ; DW_FORM_data1
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	9                               ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	1                               ; DW_CHILDREN_yes
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.ascii	"\347\177"                      ; DW_AT_APPLE_omit_frame_ptr
	.byte	25                              ; DW_FORM_flag_present
	.byte	64                              ; DW_AT_frame_base
	.byte	24                              ; DW_FORM_exprloc
	.byte	122                             ; DW_AT_call_all_calls
	.byte	25                              ; DW_FORM_flag_present
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	39                              ; DW_AT_prototyped
	.byte	25                              ; DW_FORM_flag_present
	.byte	63                              ; DW_AT_external
	.byte	25                              ; DW_FORM_flag_present
	.ascii	"\341\177"                      ; DW_AT_APPLE_optimized
	.byte	25                              ; DW_FORM_flag_present
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	10                              ; Abbreviation Code
	.byte	5                               ; DW_TAG_formal_parameter
	.byte	0                               ; DW_CHILDREN_no
	.byte	2                               ; DW_AT_location
	.byte	24                              ; DW_FORM_exprloc
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	11                              ; Abbreviation Code
	.byte	52                              ; DW_TAG_variable
	.byte	0                               ; DW_CHILDREN_no
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	12                              ; Abbreviation Code
	.byte	11                              ; DW_TAG_lexical_block
	.byte	1                               ; DW_CHILDREN_yes
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	13                              ; Abbreviation Code
	.byte	52                              ; DW_TAG_variable
	.byte	0                               ; DW_CHILDREN_no
	.byte	2                               ; DW_AT_location
	.byte	23                              ; DW_FORM_sec_offset
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	14                              ; Abbreviation Code
	.byte	52                              ; DW_TAG_variable
	.byte	0                               ; DW_CHILDREN_no
	.byte	2                               ; DW_AT_location
	.byte	24                              ; DW_FORM_exprloc
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	15                              ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	0                               ; DW_CHILDREN_no
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.ascii	"\347\177"                      ; DW_AT_APPLE_omit_frame_ptr
	.byte	25                              ; DW_FORM_flag_present
	.byte	64                              ; DW_AT_frame_base
	.byte	24                              ; DW_FORM_exprloc
	.byte	122                             ; DW_AT_call_all_calls
	.byte	25                              ; DW_FORM_flag_present
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	63                              ; DW_AT_external
	.byte	25                              ; DW_FORM_flag_present
	.ascii	"\341\177"                      ; DW_AT_APPLE_optimized
	.byte	25                              ; DW_FORM_flag_present
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	16                              ; Abbreviation Code
	.byte	15                              ; DW_TAG_pointer_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	0                               ; EOM(3)
	.section	__DWARF,__debug_info,regular,debug
Lsection_info:
Lcu_begin0:
.set Lset42, Ldebug_info_end0-Ldebug_info_start0 ; Length of Unit
	.long	Lset42
Ldebug_info_start0:
	.short	4                               ; DWARF version number
.set Lset43, Lsection_abbrev-Lsection_abbrev ; Offset Into Abbrev. Section
	.long	Lset43
	.byte	8                               ; Address Size (in bytes)
	.byte	1                               ; Abbrev [1] 0xb:0x4ed DW_TAG_compile_unit
	.long	0                               ; DW_AT_producer
	.short	12                              ; DW_AT_language
	.long	48                              ; DW_AT_name
	.long	70                              ; DW_AT_LLVM_sysroot
.set Lset44, Lline_table_start0-Lsection_line ; DW_AT_stmt_list
	.long	Lset44
	.long	72                              ; DW_AT_comp_dir
                                        ; DW_AT_APPLE_optimized
	.quad	Lfunc_begin0                    ; DW_AT_low_pc
.set Lset45, Lfunc_end1-Lfunc_begin0    ; DW_AT_high_pc
	.long	Lset45
	.byte	2                               ; Abbrev [2] 0x2e:0xb DW_TAG_variable
	.long	104                             ; DW_AT_name
	.long	57                              ; DW_AT_type
	.byte	1                               ; DW_AT_decl_file
	.byte	10                              ; DW_AT_decl_line
	.byte	3                               ; Abbrev [3] 0x39:0xc DW_TAG_array_type
	.long	69                              ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0x3e:0x6 DW_TAG_subrange_type
	.long	76                              ; DW_AT_type
	.byte	16                              ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x45:0x7 DW_TAG_base_type
	.long	114                             ; DW_AT_name
	.byte	4                               ; DW_AT_encoding
	.byte	4                               ; DW_AT_byte_size
	.byte	6                               ; Abbrev [6] 0x4c:0x7 DW_TAG_base_type
	.long	120                             ; DW_AT_name
	.byte	8                               ; DW_AT_byte_size
	.byte	7                               ; DW_AT_encoding
	.byte	2                               ; Abbrev [2] 0x53:0xb DW_TAG_variable
	.long	140                             ; DW_AT_name
	.long	57                              ; DW_AT_type
	.byte	1                               ; DW_AT_decl_file
	.byte	28                              ; DW_AT_decl_line
	.byte	2                               ; Abbrev [2] 0x5e:0xb DW_TAG_variable
	.long	150                             ; DW_AT_name
	.long	57                              ; DW_AT_type
	.byte	1                               ; DW_AT_decl_file
	.byte	46                              ; DW_AT_decl_line
	.byte	7                               ; Abbrev [7] 0x69:0xb DW_TAG_typedef
	.long	116                             ; DW_AT_type
	.long	160                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	77                              ; DW_AT_decl_line
	.byte	8                               ; Abbrev [8] 0x74:0xd DW_TAG_array_type
                                        ; DW_AT_GNU_vector
	.byte	16                              ; DW_AT_byte_size
	.long	129                             ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0x7a:0x6 DW_TAG_subrange_type
	.long	76                              ; DW_AT_type
	.byte	4                               ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x81:0xb DW_TAG_typedef
	.long	69                              ; DW_AT_type
	.long	172                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	42                              ; DW_AT_decl_line
	.byte	7                               ; Abbrev [7] 0x8c:0xb DW_TAG_typedef
	.long	151                             ; DW_AT_type
	.long	182                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	67                              ; DW_AT_decl_line
	.byte	8                               ; Abbrev [8] 0x97:0xd DW_TAG_array_type
                                        ; DW_AT_GNU_vector
	.byte	16                              ; DW_AT_byte_size
	.long	164                             ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0x9d:0x6 DW_TAG_subrange_type
	.long	76                              ; DW_AT_type
	.byte	16                              ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0xa4:0xb DW_TAG_typedef
	.long	175                             ; DW_AT_type
	.long	193                             ; DW_AT_name
	.byte	3                               ; DW_AT_decl_file
	.byte	31                              ; DW_AT_decl_line
	.byte	5                               ; Abbrev [5] 0xaf:0x7 DW_TAG_base_type
	.long	201                             ; DW_AT_name
	.byte	8                               ; DW_AT_encoding
	.byte	1                               ; DW_AT_byte_size
	.byte	7                               ; Abbrev [7] 0xb6:0xb DW_TAG_typedef
	.long	193                             ; DW_AT_type
	.long	215                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	59                              ; DW_AT_decl_line
	.byte	8                               ; Abbrev [8] 0xc1:0xd DW_TAG_array_type
                                        ; DW_AT_GNU_vector
	.byte	16                              ; DW_AT_byte_size
	.long	206                             ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0xc7:0x6 DW_TAG_subrange_type
	.long	76                              ; DW_AT_type
	.byte	16                              ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0xce:0xb DW_TAG_typedef
	.long	217                             ; DW_AT_type
	.long	225                             ; DW_AT_name
	.byte	4                               ; DW_AT_decl_file
	.byte	30                              ; DW_AT_decl_line
	.byte	5                               ; Abbrev [5] 0xd9:0x7 DW_TAG_base_type
	.long	232                             ; DW_AT_name
	.byte	6                               ; DW_AT_encoding
	.byte	1                               ; DW_AT_byte_size
	.byte	7                               ; Abbrev [7] 0xe0:0xb DW_TAG_typedef
	.long	235                             ; DW_AT_type
	.long	244                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	69                              ; DW_AT_decl_line
	.byte	8                               ; Abbrev [8] 0xeb:0xd DW_TAG_array_type
                                        ; DW_AT_GNU_vector
	.byte	16                              ; DW_AT_byte_size
	.long	248                             ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0xf1:0x6 DW_TAG_subrange_type
	.long	76                              ; DW_AT_type
	.byte	8                               ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0xf8:0xb DW_TAG_typedef
	.long	259                             ; DW_AT_type
	.long	255                             ; DW_AT_name
	.byte	5                               ; DW_AT_decl_file
	.byte	31                              ; DW_AT_decl_line
	.byte	5                               ; Abbrev [5] 0x103:0x7 DW_TAG_base_type
	.long	264                             ; DW_AT_name
	.byte	7                               ; DW_AT_encoding
	.byte	2                               ; DW_AT_byte_size
	.byte	7                               ; Abbrev [7] 0x10a:0xb DW_TAG_typedef
	.long	277                             ; DW_AT_type
	.long	279                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	58                              ; DW_AT_decl_line
	.byte	8                               ; Abbrev [8] 0x115:0xd DW_TAG_array_type
                                        ; DW_AT_GNU_vector
	.byte	8                               ; DW_AT_byte_size
	.long	206                             ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0x11b:0x6 DW_TAG_subrange_type
	.long	76                              ; DW_AT_type
	.byte	8                               ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x122:0xb DW_TAG_typedef
	.long	301                             ; DW_AT_type
	.long	288                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	71                              ; DW_AT_decl_line
	.byte	8                               ; Abbrev [8] 0x12d:0xd DW_TAG_array_type
                                        ; DW_AT_GNU_vector
	.byte	16                              ; DW_AT_byte_size
	.long	314                             ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0x133:0x6 DW_TAG_subrange_type
	.long	76                              ; DW_AT_type
	.byte	4                               ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x13a:0xb DW_TAG_typedef
	.long	325                             ; DW_AT_type
	.long	299                             ; DW_AT_name
	.byte	6                               ; DW_AT_decl_file
	.byte	31                              ; DW_AT_decl_line
	.byte	5                               ; Abbrev [5] 0x145:0x7 DW_TAG_base_type
	.long	308                             ; DW_AT_name
	.byte	7                               ; DW_AT_encoding
	.byte	4                               ; DW_AT_byte_size
	.byte	7                               ; Abbrev [7] 0x14c:0xb DW_TAG_typedef
	.long	343                             ; DW_AT_type
	.long	321                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	68                              ; DW_AT_decl_line
	.byte	8                               ; Abbrev [8] 0x157:0xd DW_TAG_array_type
                                        ; DW_AT_GNU_vector
	.byte	8                               ; DW_AT_byte_size
	.long	248                             ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0x15d:0x6 DW_TAG_subrange_type
	.long	76                              ; DW_AT_type
	.byte	4                               ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x164:0xb DW_TAG_typedef
	.long	367                             ; DW_AT_type
	.long	332                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	66                              ; DW_AT_decl_line
	.byte	8                               ; Abbrev [8] 0x16f:0xd DW_TAG_array_type
                                        ; DW_AT_GNU_vector
	.byte	8                               ; DW_AT_byte_size
	.long	164                             ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0x175:0x6 DW_TAG_subrange_type
	.long	76                              ; DW_AT_type
	.byte	8                               ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	9                               ; Abbrev [9] 0x17c:0x339 DW_TAG_subprogram
	.quad	Lfunc_begin0                    ; DW_AT_low_pc
.set Lset46, Lfunc_end0-Lfunc_begin0    ; DW_AT_high_pc
	.long	Lset46
                                        ; DW_AT_APPLE_omit_frame_ptr
	.byte	1                               ; DW_AT_frame_base
	.byte	111
                                        ; DW_AT_call_all_calls
	.long	342                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	65                              ; DW_AT_decl_line
                                        ; DW_AT_prototyped
                                        ; DW_AT_external
                                        ; DW_AT_APPLE_optimized
	.byte	10                              ; Abbrev [10] 0x191:0xd DW_TAG_formal_parameter
	.byte	1                               ; DW_AT_location
	.byte	80
	.long	387                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	65                              ; DW_AT_decl_line
	.long	1226                            ; DW_AT_type
	.byte	10                              ; Abbrev [10] 0x19e:0xd DW_TAG_formal_parameter
	.byte	1                               ; DW_AT_location
	.byte	81
	.long	433                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	65                              ; DW_AT_decl_line
	.long	1255                            ; DW_AT_type
	.byte	10                              ; Abbrev [10] 0x1ab:0xd DW_TAG_formal_parameter
	.byte	1                               ; DW_AT_location
	.byte	82
	.long	441                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	65                              ; DW_AT_decl_line
	.long	1255                            ; DW_AT_type
	.byte	10                              ; Abbrev [10] 0x1b8:0xd DW_TAG_formal_parameter
	.byte	1                               ; DW_AT_location
	.byte	83
	.long	449                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	65                              ; DW_AT_decl_line
	.long	1255                            ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x1c5:0xb DW_TAG_variable
	.long	473                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	67                              ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x1d0:0xb DW_TAG_variable
	.long	486                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	68                              ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x1db:0xb DW_TAG_variable
	.long	499                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	69                              ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	12                              ; Abbrev [12] 0x1e6:0x2ce DW_TAG_lexical_block
	.quad	Lfunc_begin0                    ; DW_AT_low_pc
.set Lset47, Ltmp50-Lfunc_begin0        ; DW_AT_high_pc
	.long	Lset47
	.byte	13                              ; Abbrev [13] 0x1f3:0xf DW_TAG_variable
.set Lset48, Ldebug_loc0-Lsection_debug_loc ; DW_AT_location
	.long	Lset48
	.long	457                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	71                              ; DW_AT_decl_line
	.long	1260                            ; DW_AT_type
	.byte	12                              ; Abbrev [12] 0x202:0x2b1 DW_TAG_lexical_block
	.quad	Ltmp1                           ; DW_AT_low_pc
.set Lset49, Ltmp47-Ltmp1               ; DW_AT_high_pc
	.long	Lset49
	.byte	13                              ; Abbrev [13] 0x20f:0xf DW_TAG_variable
.set Lset50, Ldebug_loc1-Lsection_debug_loc ; DW_AT_location
	.long	Lset50
	.long	512                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	80                              ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x21e:0xf DW_TAG_variable
.set Lset51, Ldebug_loc3-Lsection_debug_loc ; DW_AT_location
	.long	Lset51
	.long	532                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	81                              ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x22d:0xf DW_TAG_variable
.set Lset52, Ldebug_loc5-Lsection_debug_loc ; DW_AT_location
	.long	Lset52
	.long	546                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	83                              ; DW_AT_decl_line
	.long	224                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x23c:0xf DW_TAG_variable
.set Lset53, Ldebug_loc6-Lsection_debug_loc ; DW_AT_location
	.long	Lset53
	.long	564                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	84                              ; DW_AT_decl_line
	.long	224                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x24b:0xf DW_TAG_variable
.set Lset54, Ldebug_loc7-Lsection_debug_loc ; DW_AT_location
	.long	Lset54
	.long	583                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	86                              ; DW_AT_decl_line
	.long	224                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x25a:0xb DW_TAG_variable
	.long	601                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	93                              ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x265:0xb DW_TAG_variable
	.long	624                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	92                              ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x270:0xb DW_TAG_variable
	.long	646                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	90                              ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x27b:0xb DW_TAG_variable
	.long	669                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	89                              ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x286:0xf DW_TAG_variable
.set Lset55, Ldebug_loc8-Lsection_debug_loc ; DW_AT_location
	.long	Lset55
	.long	691                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	87                              ; DW_AT_decl_line
	.long	224                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x295:0xf DW_TAG_variable
.set Lset56, Ldebug_loc9-Lsection_debug_loc ; DW_AT_location
	.long	Lset56
	.long	710                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	95                              ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x2a4:0xb DW_TAG_variable
	.long	724                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	97                              ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x2af:0xb DW_TAG_variable
	.long	746                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	98                              ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x2ba:0xf DW_TAG_variable
.set Lset57, Ldebug_loc11-Lsection_debug_loc ; DW_AT_location
	.long	Lset57
	.long	768                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	99                              ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x2c9:0xf DW_TAG_variable
.set Lset58, Ldebug_loc12-Lsection_debug_loc ; DW_AT_location
	.long	Lset58
	.long	790                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	101                             ; DW_AT_decl_line
	.long	224                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x2d8:0xf DW_TAG_variable
.set Lset59, Ldebug_loc13-Lsection_debug_loc ; DW_AT_location
	.long	Lset59
	.long	808                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	102                             ; DW_AT_decl_line
	.long	224                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x2e7:0xb DW_TAG_variable
	.long	827                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	107                             ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x2f2:0xb DW_TAG_variable
	.long	850                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	106                             ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x2fd:0xb DW_TAG_variable
	.long	872                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	108                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x308:0xb DW_TAG_variable
	.long	894                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	112                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x313:0xb DW_TAG_variable
	.long	917                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	113                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x31e:0xf DW_TAG_variable
.set Lset60, Ldebug_loc14-Lsection_debug_loc ; DW_AT_location
	.long	Lset60
	.long	940                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	114                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x32d:0xb DW_TAG_variable
	.long	963                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	117                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x338:0xb DW_TAG_variable
	.long	986                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	128                             ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x343:0xb DW_TAG_variable
	.long	1010                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	127                             ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x34e:0xb DW_TAG_variable
	.long	1033                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	125                             ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x359:0xb DW_TAG_variable
	.long	1057                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	124                             ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x364:0xf DW_TAG_variable
.set Lset61, Ldebug_loc15-Lsection_debug_loc ; DW_AT_location
	.long	Lset61
	.long	1080                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	120                             ; DW_AT_decl_line
	.long	224                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x373:0xb DW_TAG_variable
	.long	1098                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	130                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x37e:0xb DW_TAG_variable
	.long	1121                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	131                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x389:0xf DW_TAG_variable
.set Lset62, Ldebug_loc16-Lsection_debug_loc ; DW_AT_location
	.long	Lset62
	.long	1144                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	132                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x398:0xb DW_TAG_variable
	.long	1167                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	137                             ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x3a3:0xb DW_TAG_variable
	.long	1191                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	136                             ; DW_AT_decl_line
	.long	290                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x3ae:0xb DW_TAG_variable
	.long	1214                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	138                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x3b9:0xb DW_TAG_variable
	.long	1237                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	142                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x3c4:0xb DW_TAG_variable
	.long	1261                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	143                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x3cf:0xf DW_TAG_variable
.set Lset63, Ldebug_loc17-Lsection_debug_loc ; DW_AT_location
	.long	Lset63
	.long	1285                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	144                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	11                              ; Abbrev [11] 0x3de:0xb DW_TAG_variable
	.long	1309                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	147                             ; DW_AT_decl_line
	.long	105                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x3e9:0xf DW_TAG_variable
.set Lset64, Ldebug_loc18-Lsection_debug_loc ; DW_AT_location
	.long	Lset64
	.long	1333                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	150                             ; DW_AT_decl_line
	.long	224                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x3f8:0xf DW_TAG_variable
.set Lset65, Ldebug_loc19-Lsection_debug_loc ; DW_AT_location
	.long	Lset65
	.long	1357                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	154                             ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	12                              ; Abbrev [12] 0x407:0x1d DW_TAG_lexical_block
	.quad	Ltmp1                           ; DW_AT_low_pc
.set Lset66, Ltmp2-Ltmp1                ; DW_AT_high_pc
	.long	Lset66
	.byte	13                              ; Abbrev [13] 0x414:0xf DW_TAG_variable
.set Lset67, Ldebug_loc2-Lsection_debug_loc ; DW_AT_location
	.long	Lset67
	.long	526                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	80                              ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	12                              ; Abbrev [12] 0x424:0x1d DW_TAG_lexical_block
	.quad	Ltmp2                           ; DW_AT_low_pc
.set Lset68, Ltmp3-Ltmp2                ; DW_AT_high_pc
	.long	Lset68
	.byte	13                              ; Abbrev [13] 0x431:0xf DW_TAG_variable
.set Lset69, Ldebug_loc4-Lsection_debug_loc ; DW_AT_location
	.long	Lset69
	.long	526                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	81                              ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	12                              ; Abbrev [12] 0x441:0x1d DW_TAG_lexical_block
	.quad	Ltmp7                           ; DW_AT_low_pc
.set Lset70, Ltmp8-Ltmp7                ; DW_AT_high_pc
	.long	Lset70
	.byte	13                              ; Abbrev [13] 0x44e:0xf DW_TAG_variable
.set Lset71, Ldebug_loc10-Lsection_debug_loc ; DW_AT_location
	.long	Lset71
	.long	526                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	95                              ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	12                              ; Abbrev [12] 0x45e:0x1c DW_TAG_lexical_block
	.quad	Ltmp44                          ; DW_AT_low_pc
.set Lset72, Ltmp45-Ltmp44              ; DW_AT_high_pc
	.long	Lset72
	.byte	14                              ; Abbrev [14] 0x46b:0xe DW_TAG_variable
	.byte	2                               ; DW_AT_location
	.byte	144
	.byte	67
	.long	1352                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	158                             ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	12                              ; Abbrev [12] 0x47a:0x1c DW_TAG_lexical_block
	.quad	Ltmp45                          ; DW_AT_low_pc
.set Lset73, Ltmp46-Ltmp45              ; DW_AT_high_pc
	.long	Lset73
	.byte	14                              ; Abbrev [14] 0x487:0xe DW_TAG_variable
	.byte	2                               ; DW_AT_location
	.byte	144
	.byte	67
	.long	1352                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	159                             ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	12                              ; Abbrev [12] 0x496:0x1c DW_TAG_lexical_block
	.quad	Ltmp46                          ; DW_AT_low_pc
.set Lset74, Ltmp47-Ltmp46              ; DW_AT_high_pc
	.long	Lset74
	.byte	14                              ; Abbrev [14] 0x4a3:0xe DW_TAG_variable
	.byte	2                               ; DW_AT_location
	.byte	144
	.byte	67
	.long	1352                            ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	160                             ; DW_AT_decl_line
	.long	140                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	15                              ; Abbrev [15] 0x4b5:0x15 DW_TAG_subprogram
	.quad	Lfunc_begin1                    ; DW_AT_low_pc
.set Lset75, Lfunc_end1-Lfunc_begin1    ; DW_AT_high_pc
	.long	Lset75
                                        ; DW_AT_APPLE_omit_frame_ptr
	.byte	1                               ; DW_AT_frame_base
	.byte	111
                                        ; DW_AT_call_all_calls
	.long	362                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	164                             ; DW_AT_decl_line
                                        ; DW_AT_external
                                        ; DW_AT_APPLE_optimized
	.byte	7                               ; Abbrev [7] 0x4ca:0xb DW_TAG_typedef
	.long	1237                            ; DW_AT_type
	.long	392                             ; DW_AT_name
	.byte	8                               ; DW_AT_decl_file
	.byte	31                              ; DW_AT_decl_line
	.byte	7                               ; Abbrev [7] 0x4d5:0xb DW_TAG_typedef
	.long	1248                            ; DW_AT_type
	.long	399                             ; DW_AT_name
	.byte	7                               ; DW_AT_decl_file
	.byte	68                              ; DW_AT_decl_line
	.byte	5                               ; Abbrev [5] 0x4e0:0x7 DW_TAG_base_type
	.long	415                             ; DW_AT_name
	.byte	7                               ; DW_AT_encoding
	.byte	8                               ; DW_AT_byte_size
	.byte	16                              ; Abbrev [16] 0x4e7:0x5 DW_TAG_pointer_type
	.long	164                             ; DW_AT_type
	.byte	7                               ; Abbrev [7] 0x4ec:0xb DW_TAG_typedef
	.long	248                             ; DW_AT_type
	.long	459                             ; DW_AT_name
	.byte	9                               ; DW_AT_decl_file
	.byte	45                              ; DW_AT_decl_line
	.byte	0                               ; End Of Children Mark
Ldebug_info_end0:
	.section	__DWARF,__debug_str,regular,debug
Linfo_string:
	.asciz	"Apple clang version 12.0.5 (clang-1205.0.22.11)" ; string offset=0
	.asciz	"monochrome_filter_1.c"         ; string offset=48
	.asciz	"/"                             ; string offset=70
	.asciz	"/Users/zacky/github/simd_sample" ; string offset=72
	.asciz	"mono_r_16"                     ; string offset=104
	.asciz	"float"                         ; string offset=114
	.asciz	"__ARRAY_SIZE_TYPE__"           ; string offset=120
	.asciz	"mono_g_16"                     ; string offset=140
	.asciz	"mono_b_16"                     ; string offset=150
	.asciz	"float32x4_t"                   ; string offset=160
	.asciz	"float32_t"                     ; string offset=172
	.asciz	"uint8x16_t"                    ; string offset=182
	.asciz	"uint8_t"                       ; string offset=193
	.asciz	"unsigned char"                 ; string offset=201
	.asciz	"int8x16_t"                     ; string offset=215
	.asciz	"int8_t"                        ; string offset=225
	.asciz	"signed char"                   ; string offset=232
	.asciz	"uint16x8_t"                    ; string offset=244
	.asciz	"uint16_t"                      ; string offset=255
	.asciz	"unsigned short"                ; string offset=264
	.asciz	"int8x8_t"                      ; string offset=279
	.asciz	"uint32x4_t"                    ; string offset=288
	.asciz	"uint32_t"                      ; string offset=299
	.asciz	"unsigned int"                  ; string offset=308
	.asciz	"uint16x4_t"                    ; string offset=321
	.asciz	"uint8x8_t"                     ; string offset=332
	.asciz	"monochrome_filter_1"           ; string offset=342
	.asciz	"init_monochrome_filter_1"      ; string offset=362
	.asciz	"size"                          ; string offset=387
	.asciz	"size_t"                        ; string offset=392
	.asciz	"__darwin_size_t"               ; string offset=399
	.asciz	"long unsigned int"             ; string offset=415
	.asciz	"pixel_r"                       ; string offset=433
	.asciz	"pixel_g"                       ; string offset=441
	.asciz	"pixel_b"                       ; string offset=449
	.asciz	"i"                             ; string offset=457
	.asciz	"uint_fast16_t"                 ; string offset=459
	.asciz	"f32x4_mono_r"                  ; string offset=473
	.asciz	"f32x4_mono_g"                  ; string offset=486
	.asciz	"f32x4_mono_b"                  ; string offset=499
	.asciz	"u8x16_pixel_r"                 ; string offset=512
	.asciz	"__ret"                         ; string offset=526
	.asciz	"u8x16_pixel_g"                 ; string offset=532
	.asciz	"u16x8_pixel_r_low"             ; string offset=546
	.asciz	"u16x8_pixel_r_high"            ; string offset=564
	.asciz	"u16x8_pixel_g_low"             ; string offset=583
	.asciz	"u32x4_pixel_g_low_high"        ; string offset=601
	.asciz	"u32x4_pixel_g_low_low"         ; string offset=624
	.asciz	"u32x4_pixel_r_low_high"        ; string offset=646
	.asciz	"u32x4_pixel_r_low_low"         ; string offset=669
	.asciz	"u16x8_pixel_g_high"            ; string offset=691
	.asciz	"u8x16_pixel_b"                 ; string offset=710
	.asciz	"f32x4_pixel_r_low_low"         ; string offset=724
	.asciz	"f32x4_pixel_g_low_low"         ; string offset=746
	.asciz	"f32x4_pixel_m_low_low"         ; string offset=768
	.asciz	"u16x8_pixel_b_low"             ; string offset=790
	.asciz	"u16x8_pixel_b_high"            ; string offset=808
	.asciz	"u32x4_pixel_b_low_high"        ; string offset=827
	.asciz	"u32x4_pixel_b_low_low"         ; string offset=850
	.asciz	"f32x4_pixel_b_low_low"         ; string offset=872
	.asciz	"f32x4_pixel_r_low_high"        ; string offset=894
	.asciz	"f32x4_pixel_g_low_high"        ; string offset=917
	.asciz	"f32x4_pixel_m_low_high"        ; string offset=940
	.asciz	"f32x4_pixel_b_low_high"        ; string offset=963
	.asciz	"u32x4_pixel_g_high_high"       ; string offset=986
	.asciz	"u32x4_pixel_g_high_low"        ; string offset=1010
	.asciz	"u32x4_pixel_r_high_high"       ; string offset=1033
	.asciz	"u32x4_pixel_r_high_low"        ; string offset=1057
	.asciz	"u16x8_pixel_m_low"             ; string offset=1080
	.asciz	"f32x4_pixel_r_high_low"        ; string offset=1098
	.asciz	"f32x4_pixel_g_high_low"        ; string offset=1121
	.asciz	"f32x4_pixel_m_high_low"        ; string offset=1144
	.asciz	"u32x4_pixel_b_high_high"       ; string offset=1167
	.asciz	"u32x4_pixel_b_high_low"        ; string offset=1191
	.asciz	"f32x4_pixel_b_high_low"        ; string offset=1214
	.asciz	"f32x4_pixel_r_high_high"       ; string offset=1237
	.asciz	"f32x4_pixel_g_high_high"       ; string offset=1261
	.asciz	"f32x4_pixel_m_high_high"       ; string offset=1285
	.asciz	"f32x4_pixel_b_high_high"       ; string offset=1309
	.asciz	"u16x8_pixel_m_high"            ; string offset=1333
	.asciz	"__s1"                          ; string offset=1352
	.asciz	"u8x16_pixel_m"                 ; string offset=1357
	.section	__DWARF,__apple_names,regular,debug
Lnames_begin:
	.long	1212240712                      ; Header Magic
	.short	1                               ; Header Version
	.short	0                               ; Header Hash Function
	.long	2                               ; Header Bucket Count
	.long	2                               ; Header Hash Count
	.long	12                              ; Header Data Length
	.long	0                               ; HeaderData Die Offset Base
	.long	1                               ; HeaderData Atom Count
	.short	1                               ; DW_ATOM_die_offset
	.short	6                               ; DW_FORM_data4
	.long	0                               ; Bucket 0
	.long	1                               ; Bucket 1
	.long	-821812956                      ; Hash in Bucket 0
	.long	1030421585                      ; Hash in Bucket 1
.set Lset76, LNames1-Lnames_begin       ; Offset in Bucket 0
	.long	Lset76
.set Lset77, LNames0-Lnames_begin       ; Offset in Bucket 1
	.long	Lset77
LNames1:
	.long	362                             ; init_monochrome_filter_1
	.long	1                               ; Num DIEs
	.long	1205
	.long	0
LNames0:
	.long	342                             ; monochrome_filter_1
	.long	1                               ; Num DIEs
	.long	380
	.long	0
	.section	__DWARF,__apple_objc,regular,debug
Lobjc_begin:
	.long	1212240712                      ; Header Magic
	.short	1                               ; Header Version
	.short	0                               ; Header Hash Function
	.long	1                               ; Header Bucket Count
	.long	0                               ; Header Hash Count
	.long	12                              ; Header Data Length
	.long	0                               ; HeaderData Die Offset Base
	.long	1                               ; HeaderData Atom Count
	.short	1                               ; DW_ATOM_die_offset
	.short	6                               ; DW_FORM_data4
	.long	-1                              ; Bucket 0
	.section	__DWARF,__apple_namespac,regular,debug
Lnamespac_begin:
	.long	1212240712                      ; Header Magic
	.short	1                               ; Header Version
	.short	0                               ; Header Hash Function
	.long	1                               ; Header Bucket Count
	.long	0                               ; Header Hash Count
	.long	12                              ; Header Data Length
	.long	0                               ; HeaderData Die Offset Base
	.long	1                               ; HeaderData Atom Count
	.short	1                               ; DW_ATOM_die_offset
	.short	6                               ; DW_FORM_data4
	.long	-1                              ; Bucket 0
	.section	__DWARF,__apple_types,regular,debug
Ltypes_begin:
	.long	1212240712                      ; Header Magic
	.short	1                               ; Header Version
	.short	0                               ; Header Hash Function
	.long	11                              ; Header Bucket Count
	.long	23                              ; Header Hash Count
	.long	20                              ; Header Data Length
	.long	0                               ; HeaderData Die Offset Base
	.long	3                               ; HeaderData Atom Count
	.short	1                               ; DW_ATOM_die_offset
	.short	6                               ; DW_FORM_data4
	.short	3                               ; DW_ATOM_die_tag
	.short	5                               ; DW_FORM_data2
	.short	4                               ; DW_ATOM_type_flags
	.short	11                              ; DW_FORM_data1
	.long	0                               ; Bucket 0
	.long	4                               ; Bucket 1
	.long	6                               ; Bucket 2
	.long	7                               ; Bucket 3
	.long	9                               ; Bucket 4
	.long	14                              ; Bucket 5
	.long	-1                              ; Bucket 6
	.long	-1                              ; Bucket 7
	.long	15                              ; Bucket 8
	.long	17                              ; Bucket 9
	.long	21                              ; Bucket 10
	.long	-1315293621                     ; Hash in Bucket 0
	.long	-1315289265                     ; Hash in Bucket 0
	.long	-1241766519                     ; Hash in Bucket 0
	.long	-965624433                      ; Hash in Bucket 0
	.long	789719536                       ; Hash in Bucket 1
	.long	1384910803                      ; Hash in Bucket 1
	.long	-594775205                      ; Hash in Bucket 2
	.long	-1995947317                     ; Hash in Bucket 3
	.long	-282664779                      ; Hash in Bucket 3
	.long	290644127                       ; Hash in Bucket 4
	.long	290711645                       ; Hash in Bucket 4
	.long	-2052747092                     ; Hash in Bucket 4
	.long	-1442048806                     ; Hash in Bucket 4
	.long	-104093792                      ; Hash in Bucket 4
	.long	-80380739                       ; Hash in Bucket 5
	.long	259121563                       ; Hash in Bucket 8
	.long	-1304652851                     ; Hash in Bucket 8
	.long	80989467                        ; Hash in Bucket 9
	.long	466678419                       ; Hash in Bucket 9
	.long	691577533                       ; Hash in Bucket 9
	.long	1011951840                      ; Hash in Bucket 9
	.long	635175551                       ; Hash in Bucket 10
	.long	878862258                       ; Hash in Bucket 10
.set Lset78, Ltypes4-Ltypes_begin       ; Offset in Bucket 0
	.long	Lset78
.set Lset79, Ltypes11-Ltypes_begin      ; Offset in Bucket 0
	.long	Lset79
.set Lset80, Ltypes2-Ltypes_begin       ; Offset in Bucket 0
	.long	Lset80
.set Lset81, Ltypes6-Ltypes_begin       ; Offset in Bucket 0
	.long	Lset81
.set Lset82, Ltypes7-Ltypes_begin       ; Offset in Bucket 1
	.long	Lset82
.set Lset83, Ltypes9-Ltypes_begin       ; Offset in Bucket 1
	.long	Lset83
.set Lset84, Ltypes15-Ltypes_begin      ; Offset in Bucket 2
	.long	Lset84
.set Lset85, Ltypes3-Ltypes_begin       ; Offset in Bucket 3
	.long	Lset85
.set Lset86, Ltypes12-Ltypes_begin      ; Offset in Bucket 3
	.long	Lset86
.set Lset87, Ltypes18-Ltypes_begin      ; Offset in Bucket 4
	.long	Lset87
.set Lset88, Ltypes22-Ltypes_begin      ; Offset in Bucket 4
	.long	Lset88
.set Lset89, Ltypes1-Ltypes_begin       ; Offset in Bucket 4
	.long	Lset89
.set Lset90, Ltypes13-Ltypes_begin      ; Offset in Bucket 4
	.long	Lset90
.set Lset91, Ltypes19-Ltypes_begin      ; Offset in Bucket 4
	.long	Lset91
.set Lset92, Ltypes0-Ltypes_begin       ; Offset in Bucket 5
	.long	Lset92
.set Lset93, Ltypes14-Ltypes_begin      ; Offset in Bucket 8
	.long	Lset93
.set Lset94, Ltypes5-Ltypes_begin       ; Offset in Bucket 8
	.long	Lset94
.set Lset95, Ltypes17-Ltypes_begin      ; Offset in Bucket 9
	.long	Lset95
.set Lset96, Ltypes10-Ltypes_begin      ; Offset in Bucket 9
	.long	Lset96
.set Lset97, Ltypes16-Ltypes_begin      ; Offset in Bucket 9
	.long	Lset97
.set Lset98, Ltypes20-Ltypes_begin      ; Offset in Bucket 9
	.long	Lset98
.set Lset99, Ltypes21-Ltypes_begin      ; Offset in Bucket 10
	.long	Lset99
.set Lset100, Ltypes8-Ltypes_begin      ; Offset in Bucket 10
	.long	Lset100
Ltypes4:
	.long	321                             ; uint16x4_t
	.long	1                               ; Num DIEs
	.long	332
	.short	22
	.byte	0
	.long	0
Ltypes11:
	.long	244                             ; uint16x8_t
	.long	1                               ; Num DIEs
	.long	224
	.short	22
	.byte	0
	.long	0
Ltypes2:
	.long	288                             ; uint32x4_t
	.long	1                               ; Num DIEs
	.long	290
	.short	22
	.byte	0
	.long	0
Ltypes6:
	.long	182                             ; uint8x16_t
	.long	1                               ; Num DIEs
	.long	140
	.short	22
	.byte	0
	.long	0
Ltypes7:
	.long	193                             ; uint8_t
	.long	1                               ; Num DIEs
	.long	164
	.short	22
	.byte	0
	.long	0
Ltypes9:
	.long	172                             ; float32_t
	.long	1                               ; Num DIEs
	.long	129
	.short	22
	.byte	0
	.long	0
Ltypes15:
	.long	120                             ; __ARRAY_SIZE_TYPE__
	.long	1                               ; Num DIEs
	.long	76
	.short	36
	.byte	0
	.long	0
Ltypes3:
	.long	279                             ; int8x8_t
	.long	1                               ; Num DIEs
	.long	266
	.short	22
	.byte	0
	.long	0
Ltypes12:
	.long	399                             ; __darwin_size_t
	.long	1                               ; Num DIEs
	.long	1237
	.short	22
	.byte	0
	.long	0
Ltypes18:
	.long	255                             ; uint16_t
	.long	1                               ; Num DIEs
	.long	248
	.short	22
	.byte	0
	.long	0
Ltypes22:
	.long	299                             ; uint32_t
	.long	1                               ; Num DIEs
	.long	314
	.short	22
	.byte	0
	.long	0
Ltypes1:
	.long	459                             ; uint_fast16_t
	.long	1                               ; Num DIEs
	.long	1260
	.short	22
	.byte	0
	.long	0
Ltypes13:
	.long	215                             ; int8x16_t
	.long	1                               ; Num DIEs
	.long	182
	.short	22
	.byte	0
	.long	0
Ltypes19:
	.long	201                             ; unsigned char
	.long	1                               ; Num DIEs
	.long	175
	.short	36
	.byte	0
	.long	0
Ltypes0:
	.long	415                             ; long unsigned int
	.long	1                               ; Num DIEs
	.long	1248
	.short	36
	.byte	0
	.long	0
Ltypes14:
	.long	114                             ; float
	.long	1                               ; Num DIEs
	.long	69
	.short	36
	.byte	0
	.long	0
Ltypes5:
	.long	308                             ; unsigned int
	.long	1                               ; Num DIEs
	.long	325
	.short	36
	.byte	0
	.long	0
Ltypes17:
	.long	225                             ; int8_t
	.long	1                               ; Num DIEs
	.long	206
	.short	22
	.byte	0
	.long	0
Ltypes10:
	.long	392                             ; size_t
	.long	1                               ; Num DIEs
	.long	1226
	.short	22
	.byte	0
	.long	0
Ltypes16:
	.long	232                             ; signed char
	.long	1                               ; Num DIEs
	.long	217
	.short	36
	.byte	0
	.long	0
Ltypes20:
	.long	332                             ; uint8x8_t
	.long	1                               ; Num DIEs
	.long	356
	.short	22
	.byte	0
	.long	0
Ltypes21:
	.long	160                             ; float32x4_t
	.long	1                               ; Num DIEs
	.long	105
	.short	22
	.byte	0
	.long	0
Ltypes8:
	.long	264                             ; unsigned short
	.long	1                               ; Num DIEs
	.long	259
	.short	36
	.byte	0
	.long	0
.subsections_via_symbols
	.section	__DWARF,__debug_line,regular,debug
Lsection_line:
Lline_table_start0:
