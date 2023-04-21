// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function apply_fish_eye(obj, player, curve_factor){

/*var obj = argument0;
var player = argument1;
var curve_factor = argument2;*/

var dist_x = obj.x - player.x;
var dist_y = obj.y - player.y;
var dist = sqrt(dist_x * dist_x + dist_y * dist_y);

var scale = 1 / (1 + curve_factor * dist);
var offset_x = dist_x * (1 - scale);
var offset_y = dist_y * (1 - scale);

return [scale, offset_x, offset_y];
}