varying vec4 vpos;
 
#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    vpos = vertex_position;
    return transform_projection * vertex_position;
}
#endif
 
#ifdef PIXEL
extern number screenWidth;
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
    number average = (pixel.r+pixel.b+pixel.g)/3.0;
    number factor = texture_coords.x / screenWidth;
    pixel.r = pixel.r + (average-pixel.r) * factor;
    pixel.g = pixel.g + (average-pixel.g) * factor;
    pixel.b = pixel.b + (average-pixel.b) * factor;
    return pixel;
}
#endif
