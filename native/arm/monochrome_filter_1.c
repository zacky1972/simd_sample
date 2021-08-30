#ifndef __arm__
#error
#endif

#include "../monochrome_filter_1.h"
#include "../intrinsics.h"
#include "../basic_intrinsics.h"
#include "../basic.h"

static float mono_r_f32x16[] = {
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
};
static float mono_g_f32x16[] = {
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
};
static float mono_b_f32x16[] = {
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
};

static __fp16 mono_r_f16x32[] = {
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
    0.299,
};
static __fp16 mono_g_f16x32[] = {
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
    0.587,
};
static __fp16 mono_b_f16x32[] = {
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
    0.114,
};

void monochrome_filter_1(size_t size, uint8_t *pixel_r, uint8_t *pixel_g, uint8_t *pixel_b)
{
    float32x4_t f32x4_mono_r = vld1q_f32(mono_r_f32x16);
    float32x4_t f32x4_mono_g = vld1q_f32(mono_g_f32x16);
    float32x4_t f32x4_mono_b = vld1q_f32(mono_b_f32x16);

    for (uint_fast16_t i = 0; i < size; i += 16)
    {
        /*
            uint8_t p = (uint8_t)round(0.299 * pixel_r[i] + 0.587 * pixel_g[i] + 0.114 * pixel_b[i]);
            pixel_r[i] = p;
            pixel_g[i] = p;
            pixel_b[i] = p;
            */

        uint8x16_t u8x16_pixel_r = vld1q_u8(&pixel_r[i]);
        uint8x16_t u8x16_pixel_g = vld1q_u8(&pixel_g[i]);

        uint16x8_t u16x8_pixel_r_low = vmovl_u8(vget_low_u8(u8x16_pixel_r));
        uint16x8_t u16x8_pixel_r_high = vmovl_high_u8(u8x16_pixel_r);

        uint16x8_t u16x8_pixel_g_low = vmovl_u8(vget_low_u8(u8x16_pixel_g));
        uint16x8_t u16x8_pixel_g_high = vmovl_high_u8(u8x16_pixel_g);

        uint32x4_t u32x4_pixel_r_low_low = vmovl_u16(vget_low_u16(u16x8_pixel_r_low));
        uint32x4_t u32x4_pixel_r_low_high = vmovl_high_u16(u16x8_pixel_r_low);

        uint32x4_t u32x4_pixel_g_low_low = vmovl_u16(vget_low_u16(u16x8_pixel_g_low));
        uint32x4_t u32x4_pixel_g_low_high = vmovl_high_u16(u16x8_pixel_g_low);

        uint8x16_t u8x16_pixel_b = vld1q_u8(&pixel_b[i]);

        float32x4_t f32x4_pixel_r_low_low = vcvtq_f32_u32(u32x4_pixel_r_low_low);
        float32x4_t f32x4_pixel_g_low_low = vcvtq_f32_u32(u32x4_pixel_g_low_low);
        float32x4_t f32x4_pixel_m_low_low = vmulq_f32(f32x4_pixel_r_low_low, f32x4_mono_r);

        uint16x8_t u16x8_pixel_b_low = vmovl_u8(vget_low_u8(u8x16_pixel_b));
        uint16x8_t u16x8_pixel_b_high = vmovl_high_u8(u8x16_pixel_b);

        f32x4_pixel_m_low_low = vmlaq_f32(f32x4_pixel_m_low_low, f32x4_pixel_g_low_low, f32x4_mono_g);

        uint32x4_t u32x4_pixel_b_low_low = vmovl_u16(vget_low_u16(u16x8_pixel_b_low));
        uint32x4_t u32x4_pixel_b_low_high = vmovl_high_u16(u16x8_pixel_b_low);
        float32x4_t f32x4_pixel_b_low_low = vcvtq_f32_u32(u32x4_pixel_b_low_low);

        f32x4_pixel_m_low_low = vmlaq_f32(f32x4_pixel_m_low_low, f32x4_pixel_b_low_low, f32x4_mono_b);

        float32x4_t f32x4_pixel_r_low_high = vcvtq_f32_u32(u32x4_pixel_r_low_high);
        float32x4_t f32x4_pixel_g_low_high = vcvtq_f32_u32(u32x4_pixel_g_low_high);
        float32x4_t f32x4_pixel_m_low_high = vmulq_f32(f32x4_pixel_r_low_high, f32x4_mono_r);

        f32x4_pixel_m_low_high = vmlaq_f32(f32x4_pixel_m_low_high, f32x4_pixel_g_low_high, f32x4_mono_g);
        float32x4_t f32x4_pixel_b_low_high = vcvtq_f32_u32(u32x4_pixel_b_low_high);
        f32x4_pixel_m_low_high = vmlaq_f32(f32x4_pixel_m_low_high, f32x4_pixel_b_low_high, f32x4_mono_b);

        uint16x8_t u16x8_pixel_m_low = vcombine_u16(
            vmovn_u32(vcvtnq_u32_f32(f32x4_pixel_m_low_low)),
            vmovn_u32(vcvtnq_u32_f32(f32x4_pixel_m_low_high)));

        uint32x4_t u32x4_pixel_r_high_low = vmovl_u16(vget_low_u16(u16x8_pixel_r_high));
        uint32x4_t u32x4_pixel_r_high_high = vmovl_high_u16(u16x8_pixel_r_high);

        uint32x4_t u32x4_pixel_g_high_low = vmovl_u16(vget_low_u16(u16x8_pixel_g_high));
        uint32x4_t u32x4_pixel_g_high_high = vmovl_high_u16(u16x8_pixel_g_high);

        float32x4_t f32x4_pixel_r_high_low = vcvtq_f32_u32(u32x4_pixel_r_high_low);
        float32x4_t f32x4_pixel_g_high_low = vcvtq_f32_u32(u32x4_pixel_g_high_low);
        float32x4_t f32x4_pixel_m_high_low = vmulq_f32(f32x4_pixel_r_high_low, f32x4_mono_r);

        f32x4_pixel_m_high_low = vmlaq_f32(f32x4_pixel_m_high_low, f32x4_pixel_g_high_low, f32x4_mono_g);

        uint32x4_t u32x4_pixel_b_high_low = vmovl_u16(vget_low_u16(u16x8_pixel_b_high));
        uint32x4_t u32x4_pixel_b_high_high = vmovl_high_u16(u16x8_pixel_b_high);
        float32x4_t f32x4_pixel_b_high_low = vcvtq_f32_u32(u32x4_pixel_b_high_low);

        f32x4_pixel_m_high_low = vmlaq_f32(f32x4_pixel_m_high_low, f32x4_pixel_b_high_low, f32x4_mono_b);

        float32x4_t f32x4_pixel_r_high_high = vcvtq_f32_u32(u32x4_pixel_r_high_high);
        float32x4_t f32x4_pixel_g_high_high = vcvtq_f32_u32(u32x4_pixel_g_high_high);
        float32x4_t f32x4_pixel_m_high_high = vmulq_f32(f32x4_pixel_r_high_high, f32x4_mono_r);

        f32x4_pixel_m_high_high = vmlaq_f32(f32x4_pixel_m_high_high, f32x4_pixel_g_high_high, f32x4_mono_g);
        float32x4_t f32x4_pixel_b_high_high = vcvtq_f32_u32(u32x4_pixel_b_high_high);
        f32x4_pixel_m_high_high = vmlaq_f32(f32x4_pixel_m_high_high, f32x4_pixel_b_high_high, f32x4_mono_b);

        uint16x8_t u16x8_pixel_m_high = vcombine_u16(
            vmovn_u32(vcvtnq_u32_f32(f32x4_pixel_m_high_low)),
            vmovn_u32(vcvtnq_u32_f32(f32x4_pixel_m_high_high)));

        uint8x16_t u8x16_pixel_m = vcombine_u8(
            vmovn_u16(u16x8_pixel_m_low),
            vmovn_u16(u16x8_pixel_m_high));

        vst1q_u8(&pixel_r[i], u8x16_pixel_m);
        vst1q_u8(&pixel_g[i], u8x16_pixel_m);
        vst1q_u8(&pixel_b[i], u8x16_pixel_m);
    }
}

void monochrome_filter_1_16(size_t size, uint8_t *pixel_r, uint8_t *pixel_g, uint8_t *pixel_b)
{
    float16x8_t f16x8_mono_r = vld1q_f16(mono_r_f16x32);
    float16x8_t f16x8_mono_g = vld1q_f16(mono_g_f16x32);
    float16x8_t f16x8_mono_b = vld1q_f16(mono_b_f16x32);

    for (uint_fast16_t i = 0; i < size; i += 16)
    {
        /*
            uint8_t p = (uint8_t)round(0.299 * pixel_r[i] + 0.587 * pixel_g[i] + 0.114 * pixel_b[i]);
            pixel_r[i] = p;
            pixel_g[i] = p;
            pixel_b[i] = p;
            */

        uint8x16_t u8x16_pixel_r = vld1q_u8(&pixel_r[i]);
        uint8x16_t u8x16_pixel_g = vld1q_u8(&pixel_g[i]);

        uint16x8_t u16x8_pixel_r_low = vmovl_u8(vget_low_u8(u8x16_pixel_r));
        uint16x8_t u16x8_pixel_r_high = vmovl_high_u8(u8x16_pixel_r);

        uint16x8_t u16x8_pixel_g_low = vmovl_u8(vget_low_u8(u8x16_pixel_g));
        uint16x8_t u16x8_pixel_g_high = vmovl_high_u8(u8x16_pixel_g);

        uint8x16_t u8x16_pixel_b = vld1q_u8(&pixel_b[i]);

        float16x8_t f16x8_pixel_r_low = vcvtq_f16_u16(u16x8_pixel_r_low);
        float16x8_t f16x8_pixel_g_low = vcvtq_f16_u16(u16x8_pixel_g_low);
        float16x8_t f16x8_pixel_m_low = vmulq_f16(f16x8_pixel_r_low, f16x8_mono_r);

        uint16x8_t u16x8_pixel_b_low = vmovl_u8(vget_low_u8(u8x16_pixel_b));
        uint16x8_t u16x8_pixel_b_high = vmovl_high_u8(u8x16_pixel_b);

        f16x8_pixel_m_low = vaddq_f16(f16x8_pixel_m_low, vmulq_f16(f16x8_pixel_g_low, f16x8_mono_g));

        float16x8_t f16x8_pixel_b_low = vcvtq_f16_u16(u16x8_pixel_b_low);

        f16x8_pixel_m_low = vaddq_f16(f16x8_pixel_m_low, vmulq_f16(f16x8_pixel_b_low, f16x8_mono_b));

        uint16x8_t u16x8_pixel_m_low = vcvtnq_u16_f16(f16x8_pixel_m_low);

        float16x8_t f16x8_pixel_r_high = vcvtq_f16_u16(u16x8_pixel_r_high);
        float16x8_t f16x8_pixel_g_high = vcvtq_f16_u16(u16x8_pixel_g_high);
        float16x8_t f16x8_pixel_m_high = vmulq_f16(f16x8_pixel_r_high, f16x8_mono_r);

        f16x8_pixel_m_high = vaddq_f16(f16x8_pixel_m_high, vmulq_f16(f16x8_pixel_g_high, f16x8_mono_g));

        float16x8_t f16x8_pixel_b_high = vcvtq_f16_u16(u16x8_pixel_b_high);
        f16x8_pixel_m_high = vaddq_f16(f16x8_pixel_m_high, vmulq_f16(f16x8_pixel_b_high, f16x8_mono_b));

        uint16x8_t u16x8_pixel_m_high = vcvtnq_u16_f16(f16x8_pixel_m_high);

        uint8x16_t u8x16_pixel_m = vcombine_u8(
            vmovn_u16(u16x8_pixel_m_low),
            vmovn_u16(u16x8_pixel_m_high));

        vst1q_u8(&pixel_r[i], u8x16_pixel_m);
        vst1q_u8(&pixel_g[i], u8x16_pixel_m);
        vst1q_u8(&pixel_b[i], u8x16_pixel_m);
    }
}

void init_monochrome_filter_1()
{

}