library body;

import '../../renderer/renderer.dart' ;
import '../../math/vec2.dart' ;
import '../../math/box2.dart';

abstract class Body
{
  Vec2 get Velocity ;
  Vec2 get Position ;
  set Position(Vec2 value) ;
  set Velocity(Vec2 value) ;
  
  void Render(Renderer renderer) ;
  void Integrate(double dt) ;
  
  Box2 get Box ;
  
  bool get IsFixed ;
  
  double get Mass ;
  double get MassInv ;
  
  void AddForce(Vec2 force) ;
  
  bool IsRelatedTo(Body body) ;
  
  double get Radius ;
  
  void PositionMove(Vec2 delta) ;
  void VelocityMove(Vec2 delta) ;
  
  toJSON() ;
}