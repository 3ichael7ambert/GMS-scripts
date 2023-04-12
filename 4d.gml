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

// update the game objects based on time
var current_time = global.game_time;
model_building = model_build_copy(model_building_base);
model_tree = model_build_copy(model_tree_base);
if (current_time > 1) {
    model_building = model_build_copy(model_building_old);
    model_tree = model_build_copy(model_tree_old);
}
if (current_time > 2) {
    model_building = model_build_copy(model_building_older);
    model_tree = model_build_copy(model_tree_older);
}

// update the game time
global.game_time += 1;
if (global.game_time > 3) {
    global.game_time = 0;
}
