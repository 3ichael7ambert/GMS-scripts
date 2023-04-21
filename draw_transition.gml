/// @description Draw transition
function draw_transition(player_list, object_list, tree_list, wall_list, dist_threshold, y_threshold, horizon_line) {

// Get the input arguments
var _player_list = argument0;
var _object_list = argument1;
var _tree_list = argument2;
var _wall_list = argument3;
var _dist_threshold = argument4;
var _y_threshold = argument5;
var _horizon_line = argument6;

// Calculate the median point (camera) of all players
var _camera_x = 0;
var _camera_y = 0;

for (var i = 0; i < array_length(_player_list); ++i) {
    _camera_x += _player_list[i].x;
    _camera_y += _player_list[i].y;
}

_camera_x /= array_length(_player_list);
_camera_y /= array_length(_player_list);

// Calculate the maximum distance between any two players
var _max_dist = 0;

for (var i = 0; i < array_length(_player_list); ++i) {
    for (var j = i + 1; j < array_length(_player_list); ++j) {
        var _dist = point_distance(_player_list[i].x, _player_list[i].y, _player_list[j].x, _player_list[j].y);
        _max_dist = max(_max_dist, _dist);
    }
}

// Calculate the interpolation factor based on the maximum distance
var _interp = clamp((_max_dist - _dist_threshold) / _y_threshold, 0, 1);

// Draw objects with the adjusted y-axis based on the interpolation factor
function draw_adjusted_y(obj_list) {
    for (var i = 0; i < array_length(obj_list); ++i) {
        var _obj = obj_list[i];
        var _angle = point_direction(_camera_x, _camera_y, _obj.x, _obj.y);
        var _dist = point_distance(_camera_x, _camera_y, _obj.x, _obj.y);
        var _y_offset = lerp(0, _horizon_line - _obj.y, _interp * (1 - clamp(_angle / 90, 0, 1)));
        draw_sprite(_obj.sprite_index, _obj.image_index, _obj.x, _obj.y + _y_offset);
    }
}

// Draw players, objects, trees, and walls with the adjusted y-axis
draw_adjusted_y(_player_list);
draw_adjusted_y(_object_list);
draw_adjusted_y(_tree_list);
draw_adjusted_y(_wall_list);


}