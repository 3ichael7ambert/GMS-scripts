// set the camera's position and orientation
var camera_x = player.x;
var camera_y = player.y;
var camera_z = -200;
var camera_pitch = 45;
var camera_yaw = 0;
var camera_roll = 0;
camera_set_view_mat(camera, matrix_build_lookat(camera_x, camera_y, camera_z, camera_x, camera_y, 0, 0, 1, 0));

// set the camera's perspective
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(60, room_width/room_height, 1, 1000));

// draw the game objects with depth sorting
draw_set_depth(-1000);
draw_sprite(sprite_ground, 0, 0, 0);
draw_set_depth(-900);
draw_sprite(sprite_building, 0, 64, 64);
draw_set_depth(-800);
draw_sprite(sprite_tree, 0, 128, 128);

// update the camera's position and orientation based on the player's position and input
var input_direction = point_direction(0, 0, gamepad_axis_value(0, gp_axislh), gamepad_axis_value(0, gp_axislv));
var input_speed = gamepad_axis_value(0, gp_axisry) * -10;
camera_pitch -= input_speed;
camera_yaw -= input_direction;
camera_roll = input_direction * 0.5;
var camera_matrix = matrix_build_lookat(camera_x, camera_y, camera_z, camera_x + lengthdir_x(1, camera_pitch) * lengthdir_x(1, camera_yaw), camera_y + lengthdir_y(1, camera_pitch) * lengthdir_x(1, camera_yaw), camera_z + lengthdir_z(1, camera_pitch), lengthdir_x(1, camera_roll), lengthdir_y(1, camera_roll), lengthdir_z(1, camera_roll));
camera_set_view_mat(camera, camera_matrix);
