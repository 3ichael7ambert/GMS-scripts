///keymap_unset(key)
/***************************************************
  USEAGE:
    unmaps any keys that are mapped to te given key.
    (Currently, this does not support unmapping a key
    that's mapped to another key, use keymap_unset_child
    until further notice).
    
  NOTE:
    Unfortunately, there currently is no native way to 
    simply remove mappings under a single key.
    
    To work around this, this checks ALL of the keys for mappings,
    stores them in a temporary array, unmaps all keys, and then
    remaps all of the other keys that were stored.
    
    if you want to unmap all keys, use keymap_unset_all().
***************************************************/
var array, i, count;
count = 0;
for (i = 0; i < 256; i += 1)
{
    if (keyboard_get_map(i) != i)
    {
        array[count, 0] = i;
        array[count, 1] = keyboard_get_map(i);
        if i == argument0
        {
            keyboard_set_map(argument0, argument0);
            exit;
        }
        count += 1;
    }
}
keyboard_unset_map();
for (i = 0; i < count; i += 1)
{
    if (array[i, 1] != argument0)
        keyboard_set_map(array[i, 0], array[i, 1]);
}
