//draw_stretch_effect();
draw_sprite_ext(sprite_index, image_index, x, y, xscale * dir, yscale, image_angle, image_blend, image_alpha);
//draw_text(x , y - 32, string(state));
//draw_text(x , y + 16, nameof(state));

if (global.debug) draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

