function set_white_shader()
{	
	tomei_dano = false;	
}

function timer_white_shader(_tempo = 1)
{
	tomei_dano = _tempo	
}

function count_down_shader()
{
	if (tomei_dano > 0)
	{
		tomei_dano--;	
	}
}

function draw_white_shader(_function_draw = draw_self)
{
	if (tomei_dano)
	{
		shader_set(sh_branco)
		_function_draw();
		shader_reset();
	}else
	{
		_function_draw();
	}
}
