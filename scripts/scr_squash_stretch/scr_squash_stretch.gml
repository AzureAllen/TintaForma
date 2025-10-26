function start_strech()
{
	xscale = 1;
	yscale = 1;
}

function strech_effect(_xscale = 1, _yscale = 1 )
{
	xscale = _xscale;
	yscale = _yscale;
}

function end_strech_effect(_qtd)
{
	xscale = lerp(xscale, 1, _qtd);
	yscale = lerp(yscale, 1, _qtd);
}

function draw_strech_effect()
{
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}
