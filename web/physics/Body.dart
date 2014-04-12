library body;

import '../../renderer/renderer.dart' ;
import '../../math/vec2.dart' ;
import '../../math/box2.dart';

abstract class Body
{
  bool _isCollidable ;
  bool get IsCollidable => _isCollidable ;
  set IsCollidable(bool value) => _isCollidable = value ;
  
  Vec2 get Velocity ;
  set Velocity(Vec2 value) ;

  Vec2 get Position ;
  set Position(Vec2 value) ;
  
  void Render(Renderer renderer) ;
  
  void Integrate(double dt, [bool propagate = false]) ;
  
  Box2 get Box ;
  
  bool get IsFixed ;
  
  double get Mass ;
  double get MassInv ;
  
  void AddForce(Vec2 force, [bool propagate = false]) ;
  
  bool IsRelatedTo(Body body) ;
  
  double get Radius ;
  
  void PositionMove(Vec2 delta) ;
  void VelocityMove(Vec2 delta) ;
  
  toJSON() ;
}