if (!target) exit;
    


//esticar com base na velocidade

image_xscale = lerp(image_xscale, speed * 4, 0.1);
image_angle = direction;
//se NÂO estou voltando, diminuo a velocidade
if (!go_back)
{
    speed -= 0.1;
}
//se estou voltando
if (speed <= 0)
{
    go_back = true;
    
    var  _x = target.x + random_range(-2,2);
    var  _y = target.y - 8 + random_range(-2, 2);
    var _dir = point_direction(x , y + 8, _x , _y)
    direction = _dir;
    
}

if (go_back)
{
    speed += 0.1;
    
    var _player = instance_place(x , y, obj_player)
    if (_player) || (y > ystart + 200) || (x > ystart + 200)
    {
        with (_player)
        {
            var  _x_scale = random_range(0.1, 0.4);
            var  _y_scale = random_range(0.1, 0.4);
            stretch_effect(1 + _x_scale, 1 + _y_scale)
        }
        
        instance_destroy();
        screenshake(5);
        
    }
}



