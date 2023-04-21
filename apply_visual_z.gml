// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function apply_visual_z(obj, player, curve_factor) {

/*var obj = argument0;
var player = argument1;
var curve_factor = argument2;*/

var dist_x = obj.x - player.x;
var dist_y = obj.y - player.y;
var dist = sqrt(dist_x * dist_x + dist_y * dist_y);
var max_dist = max(room_width, room_height) / 2;

var z_offset = curve_factor * pow(dist / max_dist, 2);

return z_offset;

}