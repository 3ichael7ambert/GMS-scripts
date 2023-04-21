// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function  apply_fish_eye2(obj, player, curve_factor, min_scale) {

/*var obj = argument0;
var player = argument1;
var curve_factor = argument2;
var min_scale = argument3;*/

var dist_x = obj.x - player.x;
var dist_y = obj.y - player.y;
var dist = sqrt(dist_x * dist_x + dist_y * dist_y);
var max_dist = max(room_width, room_height) / 2;

var scale = 1 - (curve_factor * pow(dist / max_dist, 2));
scale = max(min_scale, scale);
var offset_x = dist_x * (1 - scale);
var offset_y = dist_y * (1 - scale);

return [scale, offset_x, offset_y];


}