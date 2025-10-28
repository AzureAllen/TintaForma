function start_stretch()
{
	xscale = 1;
	yscale = 1;
}

function stretch_effect(_xscale = 1, _yscale = 1 )
{
	xscale = _xscale;
	yscale = _yscale;
}

function end_stretch_effect(_qtd = 0.1)
{
	xscale = lerp(xscale, 1, _qtd);
	yscale = lerp(yscale, 1, _qtd);
}

function draw_stretch_effect()
{
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}
