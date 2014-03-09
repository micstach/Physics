library toolinterface;

import "../../math/vec2.dart";
import "../../renderer/renderer.dart" ;

abstract class Tool
{
  void Activate() ;
  void Deactivate() ;
  bool get IsActive ;
  void Draw(Renderer renderer) ;
  String get Name ;
  Vec2 get Position ;
}