library constraint.distance;

import "../renderer/renderer.dart" ;
import '../math/vec2.dart' ;

import "body.dart" ; 
import "constraint.dart" ;

class ConstraintDistance extends Constraint
{
  double _distance = 0.0 ;
  
  ConstraintDistance(Body a, Body b) : super(a, b)
  {
    _distance = (B.Position - A.Position).Length ;
  }
  
  void Resolve()
  {
    Vec2 dp = B.Position - A.Position ;
    double len = dp.Length ;
    double diff = (_distance - len) ;
    
    Vec2 delta = dp * ((diff / len)) ;
    
    if (!A.IsFixed)
    {
      double s = A.MassInv / (A.MassInv + B.MassInv) ;
      A.PositionMove(delta * (-s));
      A.VelocityMove(delta * (-s));
    }
    
    if (!B.IsFixed)
    {
      double s = B.MassInv / (A.MassInv + B.MassInv) ;
      B.PositionMove(delta * (s));
      B.VelocityMove(delta * (s));
    }
  }
  
  void Render(Renderer renderer)
  {
    renderer.drawPath([A.Position, B.Position], false, "rgba(128, 128, 128, 0.1)", "rgba(128, 128, 128, 0.1)") ;
  }
  
  void RenderStopped(Renderer renderer)
  {
    renderer.drawPath([A.Position, B.Position], false, "rgba(128, 128, 128, 0.75)", "rgba(128, 128, 128, 0.75)") ;
  }
  
  toJSON()
  {
    return {"type": "distance", "a": A.hashCode, "b" : B.hashCode} ;
  }
}