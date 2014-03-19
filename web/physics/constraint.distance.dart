library phx_constraint_distance;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart' ;
import 'particle.dart' ;
import 'constraint.dart' ;

class Distance extends Constraint
{
  double _distance = 0.0 ;
  
  Vec2 _ia = null ;
  Vec2 _ib = null ;
  
  Distance(Particle a, Particle b) : super(a, b)
  {
    _distance = (A.Position - B.Position).Length ;
  }
  
  void Resolve(int nsteps)
  {
    Vec2 dp = B.Position - A.Position ;
    double len = dp.Length ;
    double diff = (_distance - len) ;
    
    Vec2 delta = dp * ((diff / len)) ;
    
    if (!A.IsFixed)
    {
      double s = A.MassInv / (A.MassInv + B.MassInv) ;
      A.Position -= delta * s;
      A.Velocity -= delta * s;
    }
    
    if (!B.IsFixed)
    {
      double s = B.MassInv / (A.MassInv + B.MassInv) ;
      B.Position += delta * s ;
      B.Velocity += delta * s;
    }
    
    //int step = nsteps ;
    //nsteps = 1 ;
    //double j = Distance.Impulse(0.1 / nsteps, 0.0, (diff/len) * 0.5, A.MassInv, B.MassInv) ;
    
//    if (!A.IsFixed)
//      A.AddForce(dp * (-j)) ;
//
//    if (!B.IsFixed)
//      B.AddForce(dp * ( j)) ;
//    
//    A.Integrate(0.1 / nsteps) ;
//    B.Integrate(0.1 / nsteps) ;
    
    
  }
  
  void ResolveForces() 
  {
//    Vec2 dp = B.Position - A.Position ;
//    dp.Normalize() ;
//
//    double avl = A.Velocity.Length ;
//    
//    A.Velocity = Vec2.Project(A.Velocity, dp) ;
//
//    double bvl = B.Velocity.Length ;
//    
//    B.Velocity = Vec2.Project(B.Velocity, dp) ;
//    
//    double rv_dot_cn = (B.Velocity - A.Velocity) | dp ;
//    double j = Distance.Impulse(0.1, 0.0, rv_dot_cn, A.MassInv, B.MassInv) ;
//    
//    A.AddForce(dp * (-j) ) ; 
//    B.AddForce(dp * ( j) ) ;
  }
  
  void Render(Renderer renderer)
  {
    renderer.drawPath([A.Position, B.Position], false, "rgb(128, 128, 128)", "rgb(128, 128, 128)") ;
  }
  
  static double Impulse(double dt, double e, double relVel, double invMassA, double invMassB) 
  {
    return ((1.0 + e) / (dt * dt * 0.5)) * (relVel / (invMassA + invMassB)) ; 
  }   
}