// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

//!DESC RAVU-Zoom-AR (luma, r2)
//!HOOK LUMA
//!BIND HOOKED
//!BIND ravu_zoom_lut2
//!BIND ravu_zoom_lut2_ar
//!WIDTH OUTPUT.w
//!HEIGHT OUTPUT.h
//!OFFSET ALIGN
//!WHEN HOOKED.w OUTPUT.w < HOOKED.h OUTPUT.h < *
#define LUTPOS(x, lut_size) mix(0.5 / (lut_size), 1.0 - 0.5 / (lut_size), (x))
vec4 hook() {
vec2 pos = HOOKED_pos * HOOKED_size;
vec2 subpix = fract(pos - 0.5);
pos -= subpix;
subpix = LUTPOS(subpix, vec2(9.0));
vec2 subpix_inv = 1.0 - subpix;
subpix /= vec2(2.0, 288.0);
subpix_inv /= vec2(2.0, 288.0);
float sample0 = HOOKED_tex((pos + vec2(-1.0,-1.0)) * HOOKED_pt).x;
float sample1 = HOOKED_tex((pos + vec2(-1.0,0.0)) * HOOKED_pt).x;
float sample2 = HOOKED_tex((pos + vec2(-1.0,1.0)) * HOOKED_pt).x;
float sample3 = HOOKED_tex((pos + vec2(-1.0,2.0)) * HOOKED_pt).x;
float sample4 = HOOKED_tex((pos + vec2(0.0,-1.0)) * HOOKED_pt).x;
float sample5 = HOOKED_tex((pos + vec2(0.0,0.0)) * HOOKED_pt).x;
float sample6 = HOOKED_tex((pos + vec2(0.0,1.0)) * HOOKED_pt).x;
float sample7 = HOOKED_tex((pos + vec2(0.0,2.0)) * HOOKED_pt).x;
float sample8 = HOOKED_tex((pos + vec2(1.0,-1.0)) * HOOKED_pt).x;
float sample9 = HOOKED_tex((pos + vec2(1.0,0.0)) * HOOKED_pt).x;
float sample10 = HOOKED_tex((pos + vec2(1.0,1.0)) * HOOKED_pt).x;
float sample11 = HOOKED_tex((pos + vec2(1.0,2.0)) * HOOKED_pt).x;
float sample12 = HOOKED_tex((pos + vec2(2.0,-1.0)) * HOOKED_pt).x;
float sample13 = HOOKED_tex((pos + vec2(2.0,0.0)) * HOOKED_pt).x;
float sample14 = HOOKED_tex((pos + vec2(2.0,1.0)) * HOOKED_pt).x;
float sample15 = HOOKED_tex((pos + vec2(2.0,2.0)) * HOOKED_pt).x;
vec3 abd = vec3(0.0);
float gx, gy;
gx = (sample4-sample0);
gy = (sample1-sample0);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample5-sample1);
gy = (sample2-sample0)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample6-sample2);
gy = (sample3-sample1)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample7-sample3);
gy = (sample3-sample2);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample8-sample0)/2.0;
gy = (sample5-sample4);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample9-sample1)/2.0;
gy = (sample6-sample4)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (sample10-sample2)/2.0;
gy = (sample7-sample5)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (sample11-sample3)/2.0;
gy = (sample7-sample6);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample12-sample4)/2.0;
gy = (sample9-sample8);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample13-sample5)/2.0;
gy = (sample10-sample8)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (sample14-sample6)/2.0;
gy = (sample11-sample9)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (sample15-sample7)/2.0;
gy = (sample11-sample10);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample12-sample8);
gy = (sample13-sample12);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample13-sample9);
gy = (sample14-sample12)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample14-sample10);
gy = (sample15-sample13)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample15-sample11);
gy = (sample15-sample14);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
float a = abd.x, b = abd.y, d = abd.z;
float T = a + d, D = a * d - b * b;
float delta = sqrt(max(T * T / 4.0 - D, 0.0));
float L1 = T / 2.0 + delta, L2 = T / 2.0 - delta;
float sqrtL1 = sqrt(L1), sqrtL2 = sqrt(L2);
float theta = mix(mod(atan(L1 - a, b) + 3.141592653589793, 3.141592653589793), 0.0, abs(b) < 1.192092896e-7);
float lambda = sqrtL1;
float mu = mix((sqrtL1 - sqrtL2) / (sqrtL1 + sqrtL2), 0.0, sqrtL1 + sqrtL2 < 1.192092896e-7);
float angle = floor(theta * 24.0 / 3.141592653589793);
float strength = mix(mix(0.0, 1.0, lambda >= 0.004), mix(2.0, 3.0, lambda >= 0.05), lambda >= 0.016);
float coherence = mix(mix(0.0, 1.0, mu >= 0.25), 2.0, mu >= 0.5);
float coord_y = ((angle * 4.0 + strength) * 3.0 + coherence) / 288.0;
float res = 0.0;
vec4 w;
vec4 cg, cg1;
float lo = 0.0, hi = 0.0;
float lo2 = 0.0, hi2 = 0.0;
w = texture(ravu_zoom_lut2, vec2(0.0, coord_y) + subpix);
res += sample0 * w[0];
res += sample1 * w[1];
res += sample2 * w[2];
res += sample3 * w[3];
w = texture(ravu_zoom_lut2, vec2(0.5, coord_y) + subpix);
res += sample4 * w[0];
res += sample5 * w[1];
res += sample6 * w[2];
res += sample7 * w[3];
w = texture(ravu_zoom_lut2, vec2(0.0, coord_y) + subpix_inv);
res += sample15 * w[0];
res += sample14 * w[1];
res += sample13 * w[2];
res += sample12 * w[3];
w = texture(ravu_zoom_lut2, vec2(0.5, coord_y) + subpix_inv);
res += sample11 * w[0];
res += sample10 * w[1];
res += sample9 * w[2];
res += sample8 * w[3];
w = texture(ravu_zoom_lut2_ar, vec2(0.0, coord_y) + subpix);
cg = vec4(0.1 + sample0, 1.1 - sample0, 0.1 + sample1, 1.1 - sample1);
cg1 = cg;
cg *= cg;cg *= cg;cg *= cg;cg *= cg;cg *= cg;
hi += cg[0] * w[0] + cg[2] * w[1];
lo += cg[1] * w[0] + cg[3] * w[1];
cg *= cg1;
hi2 += cg[0] * w[0] + cg[2] * w[1];
lo2 += cg[1] * w[0] + cg[3] * w[1];
cg = vec4(0.1 + sample2, 1.1 - sample2, 0.1 + sample3, 1.1 - sample3);
cg1 = cg;
cg *= cg;cg *= cg;cg *= cg;cg *= cg;cg *= cg;
hi += cg[0] * w[2] + cg[2] * w[3];
lo += cg[1] * w[2] + cg[3] * w[3];
cg *= cg1;
hi2 += cg[0] * w[2] + cg[2] * w[3];
lo2 += cg[1] * w[2] + cg[3] * w[3];
w = texture(ravu_zoom_lut2_ar, vec2(0.5, coord_y) + subpix);
cg = vec4(0.1 + sample4, 1.1 - sample4, 0.1 + sample5, 1.1 - sample5);
cg1 = cg;
cg *= cg;cg *= cg;cg *= cg;cg *= cg;cg *= cg;
hi += cg[0] * w[0] + cg[2] * w[1];
lo += cg[1] * w[0] + cg[3] * w[1];
cg *= cg1;
hi2 += cg[0] * w[0] + cg[2] * w[1];
lo2 += cg[1] * w[0] + cg[3] * w[1];
cg = vec4(0.1 + sample6, 1.1 - sample6, 0.1 + sample7, 1.1 - sample7);
cg1 = cg;
cg *= cg;cg *= cg;cg *= cg;cg *= cg;cg *= cg;
hi += cg[0] * w[2] + cg[2] * w[3];
lo += cg[1] * w[2] + cg[3] * w[3];
cg *= cg1;
hi2 += cg[0] * w[2] + cg[2] * w[3];
lo2 += cg[1] * w[2] + cg[3] * w[3];
w = texture(ravu_zoom_lut2_ar, vec2(0.0, coord_y) + subpix_inv);
cg = vec4(0.1 + sample15, 1.1 - sample15, 0.1 + sample14, 1.1 - sample14);
cg1 = cg;
cg *= cg;cg *= cg;cg *= cg;cg *= cg;cg *= cg;
hi += cg[0] * w[0] + cg[2] * w[1];
lo += cg[1] * w[0] + cg[3] * w[1];
cg *= cg1;
hi2 += cg[0] * w[0] + cg[2] * w[1];
lo2 += cg[1] * w[0] + cg[3] * w[1];
cg = vec4(0.1 + sample13, 1.1 - sample13, 0.1 + sample12, 1.1 - sample12);
cg1 = cg;
cg *= cg;cg *= cg;cg *= cg;cg *= cg;cg *= cg;
hi += cg[0] * w[2] + cg[2] * w[3];
lo += cg[1] * w[2] + cg[3] * w[3];
cg *= cg1;
hi2 += cg[0] * w[2] + cg[2] * w[3];
lo2 += cg[1] * w[2] + cg[3] * w[3];
w = texture(ravu_zoom_lut2_ar, vec2(0.5, coord_y) + subpix_inv);
cg = vec4(0.1 + sample11, 1.1 - sample11, 0.1 + sample10, 1.1 - sample10);
cg1 = cg;
cg *= cg;cg *= cg;cg *= cg;cg *= cg;cg *= cg;
hi += cg[0] * w[0] + cg[2] * w[1];
lo += cg[1] * w[0] + cg[3] * w[1];
cg *= cg1;
hi2 += cg[0] * w[0] + cg[2] * w[1];
lo2 += cg[1] * w[0] + cg[3] * w[1];
cg = vec4(0.1 + sample9, 1.1 - sample9, 0.1 + sample8, 1.1 - sample8);
cg1 = cg;
cg *= cg;cg *= cg;cg *= cg;cg *= cg;cg *= cg;
hi += cg[0] * w[2] + cg[2] * w[3];
lo += cg[1] * w[2] + cg[3] * w[3];
cg *= cg1;
hi2 += cg[0] * w[2] + cg[2] * w[3];
lo2 += cg[1] * w[2] + cg[3] * w[3];
hi = hi2 / hi - 0.1;
lo = 1.1 - lo2 / lo;
res = mix(res, clamp(res, lo, hi), 0.800000);
return vec4(res, 0.0, 0.0, 0.0);
}
//!TEXTURE ravu_zoom_lut2
//!SIZE 18 2592
//!FORMAT rgba16f
//!FILTER LINEAR
//!TEXTURE ravu_zoom_lut2_ar
//!SIZE 18 2592
//!FORMAT rgba16f
//!FILTER LINEAR