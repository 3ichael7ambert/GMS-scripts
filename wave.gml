function wave(from, to, time, offset){
	// Returns a value that will wave back and forth between [from-to] over [duration] seconds
	// Examples
	//      image_angle = scr_wave(-45,45,1,0)  -> rock back and forth 90 degrees in a second
	//      x = scr_wave(-10,10,0.25,0)         -> move left and right quickly

	// Or here is a fun one! Make an object be all squishy!! ^u^
	//      image_xscale = Wave(0.5, 2.0, 1.0, 0.0)
	//      image_yscale = Wave(2.0, 0.5, 1.0, 0.0)

	var a4 = (to - from) * 0.5;
	return from + a4 + sin((((current_time * 0.001) + time * offset) / time) * (pi*2)) * a4;
}
