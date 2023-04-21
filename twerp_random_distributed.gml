/// @param median
/// @param range
/// @param twerp_type
/// @param [invert=false]
///@func twerp_random_distributed(median, range, TwerpType, *invert?)
function twerp_random_distributed(_med, _range, _type, _invert) {
  var _val = twerp_random(_range,_type,argument_count > 3 ? argument[3] : false);
  return _med + choose(1,-1)*_val;
}