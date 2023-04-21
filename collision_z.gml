// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function collision_z(obj, x_offset, y_offset, z_offset) {

/*var obj = argument0;
var x_offset = argument1;
var y_offset = argument2;
var z_offset = argument3;*/

var hit = instance_place(x + x_offset, y + y_offset, obj);

if (hit != noone && hit.z >= z + z_offset) {
    return hit;
}

return noone;
}