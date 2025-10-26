function play_sfx(_sound, _min_pitch, _max_pitch, _gain)
{
	var _pitch = random_range(_min_pitch, _max_pitch);
	audio_play_sound(_sound,0 , 0, _gain, 0, _pitch);
}
