// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more/// @description Draw perspective
function draw_perspective(player1, player2, side_scroll_dist, top_down_dist) {

// Get the input arguments
var _player1 = argument0;
var _player2 = argument1;
var _side_scroll_dist = argument2;
var _top_down_dist = argument3;

// Calculate the distance between the players
var _dist = point_distance(_player1.x, _player1.y, _player2.x, _player2.y);

// Calculate the interpolation factor based on the distance
var _interp = clamp((_dist - _side_scroll_dist) / (_top_down_dist - _side_scroll_dist), 0, 1);

// Calculate the scaling factor and rotation angle based on the interpolation factor
var _scale = lerp(1, 0.5, _interp);
var _rotation = lerp(0, 90, _interp);

// Save the current transformation matrix
draw_primitive_begin(pr_pointlist);
draw_primitive_end();
var _old_matrix = matrix_get(matrix_world);

// Create a new transformation matrix and apply the scale, rotation, and translation
var _matrix = matrix_build(_player1.x, _player1.y, 0, _rotation, _scale, _scale, 1);

// Set the new transformation matrix
matrix_set(matrix_world, _matrix);

// Draw the objects using the new transformation matrix
// Replace "sprite1" and "sprite2" with the actual sprite names
draw_sprite(sprite1, 0, 0, 0);
draw_sprite(sprite2, 0, _player2.x - _player1.x, _player2.y - _player1.y);

// Restore the original transformation matrix
matrix_set(matrix_world, _old_matrix);

}