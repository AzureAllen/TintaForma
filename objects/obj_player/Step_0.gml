input_set();
change_scale();
check_ground();
ativa_debug();
state();

if (keyboard_check_pressed(vk_up))
{
    state = start_dive;
}
if (keyboard_check_pressed(vk_down))
{
    state = end_dive;
}