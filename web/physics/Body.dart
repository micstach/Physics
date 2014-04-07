library phxbody;

import '../../renderer/renderer.dart' ;
import '../../math/vec2.dart' ;

abstract class Body
{
  Vec2 get Velocity ;
  Vec2 get Position ;
  
  void Render(Renderer renderer) ;
}