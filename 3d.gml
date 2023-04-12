// create the 3D camera
camera_set_view_mat(camera, matrix_build_lookat(x, y, z, x + lengthdir_x(1, pitch) * lengthdir_x(1, yaw), y + lengthdir_y(1, pitch) * lengthdir_x(1, yaw), z + lengthdir_z(1, pitch), lengthdir_x(1, roll), lengthdir_y(1, roll), lengthdir_z(1, roll)));

// set the camera's perspective
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(60, room_width/room_height, 1, 1000));

// draw the game objects
draw_set_depth(-1000);
draw_model(model_ground, matrix_build_identity(), true);
draw_set_depth(-900);
draw_model(model_building, matrix_build_translation(64, 0, 0), true);
draw_set_depth(-800);
draw_model(model_tree, matrix_build_translation(128, 0, 0), true);

// update the camera's position and orientation based on player input
var input_direction = point_direction(0, 0, gamepad_axis_value(0, gp_axislh), gamepad_axis_value(0, gp_axislv));
var input_speed = gamepad_axis_value(0, gp_axisry) * -10;
pitch -= input_speed;
yaw -= input_direction;
roll = input_direction * 0.5;
var camera_matrix = matrix_build_lookat(x, y, z, x + lengthdir_x(1, pitch) * lengthdir_x(1, yaw), y + lengthdir_y(1, pitch) * lengthdir_x(1, yaw), z + lengthdir_z(1, pitch), lengthdir_x(1, roll), lengthdir_y(1, roll), lengthdir_z(1, roll));
camera_set_view_mat(camera, camera_matrix);
