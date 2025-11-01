
var _escala = random_range(-0.02, 0.02);

gpu_set_blendmode(bm_add);

draw_sprite_ext(spr_torch_shine, 1, x, y, 0.4 + _escala, 0.4 + _escala, 1, c_orange, 0.2);

gpu_set_blendmode(bm_normal);