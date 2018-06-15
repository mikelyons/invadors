vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  if(screen_coords.x > 400){
    return vec4(1.0,0.0,0.0,1.0);//red
  }
  else
  {
    return vec4(0.0,0.0,1.0,1.0);//blue
  }
}

vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    vpos = vertex_position;
    return transform_projection * vertex_position;
}
