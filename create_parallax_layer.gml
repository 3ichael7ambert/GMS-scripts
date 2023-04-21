/// @description create_parallax_layer(image, x_follow, y_follow, x_speed, y_speed, depth, colour, alpha);
/// @param image
/// @param  x_follow
/// @param  y_follow
/// @param  x_speed
/// @param  y_speed
/// @param  depth
/// @param  colour
/// @param  alpha
function create_parallax_layer(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7) {
	var a = instance_create(0, 0, objParallaxLayer);
	a.image = argument0;
	a.x_follow = argument1;
	a.y_follow = argument2;
	a.x_speed = argument3;
	a.y_speed = argument4;
	a.depth = argument5;
	a.colour = argument6;
	a.alpha = argument7;
	return a;



}
