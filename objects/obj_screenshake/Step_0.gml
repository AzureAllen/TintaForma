//usando o 0.1 para o lerp não demorar resetar
if (shake > 0.1)
{
	//alterar o valor de shake entre o intervalo de negativo e positivo
	var _x = random_range(-shake, shake);
	var _y = random_range(-shake, shake);
	//pegar o X da viewport
	view_set_xport(view_current, _x);
	//pegar o Y da viewport
	view_set_yport(view_current, _y);
	
}else //garantindo que o shake resetou e a camera resetou
{
	shake = 0;
	view_set_xport(view_current, 0);
	view_set_yport(view_current, 0);	
}
//parando o shake
shake = lerp(shake, 0, 0.1);