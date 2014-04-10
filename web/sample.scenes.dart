library scene.samples ;

import 'physics/constraint.dart' ;
import 'physics/constraint.distance.dart' ;

import 'physics/particle.dart' ;
import 'physics/super.particle.dart' ;
import 'physics/scene.dart' ;

void scene4(Scene scene)
{
  scene.Clear() ;
  
  double x = 400.0 ; 
  double y = 500.0 ; 

  Particle p1 = new Particle(x, y) ;
  p1.Mass = 1.0 ;
  p1.Velocity.Zero();
  scene.bodies.add(p1) ;
  
  Particle p2 = new Particle(x+200, y) ;
  p2.Mass = 1.0 ;
  p2.Velocity.Zero();
  scene.bodies.add(p2) ;

  for (double d=0.10; d<0.95; d+=0.10)
  {
    scene.bodies.add(new SuperParticle(p1, d, p2, 1.0 - d)) ;
  }

  scene.constraints.add(new ConstraintDistance(p1, p2)) ;

  p1 = new Particle(x, y - 150) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  scene.bodies.add(p1) ;
}

void scene3(List<Particle> particles, List<Constraint> constraints)
{
  particles.clear() ;
  constraints.clear() ;
  
  double x = 400.0 ; 
  double y = 500.0 ; 

  Particle p1 = new Particle(x, y) ;
  p1.Mass = 1.0 ;
  p1.Velocity.Zero();
  particles.add(p1) ;
  
  p1 = new Particle(x, y-200) ;
  p1.Mass = 1.0 ;
  p1.Velocity.Zero();
  particles.add(p1) ;
}

void scene2(List<Particle> particles, List<Constraint> constraints)
{
  particles.clear() ;
  constraints.clear() ;

  double x = 400.0 ; 
  double y = 500.0 ; 

  Particle p1 = new Particle(x-50, y+30) ;
  p1.Mass = 1.0 ;
  p1.Velocity.Zero();
  particles.add(p1) ;

  p1 = new Particle(x-120, y+20) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

  p1 = new Particle(x+20, y+20) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

  p1 = new Particle(x, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  Particle p2 = new Particle(x+100, y) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;
  
  p1 = new Particle(x-20, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  p2 = new Particle(x-20, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;

  p1 = new Particle(x-40, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  p2 = new Particle(x-40, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;

  p1 = new Particle(x-60, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  p2 = new Particle(x-60, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;

  p1 = new Particle(x-80, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  p2 = new Particle(x-80, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;

  p1 = new Particle(x-100, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;
  
//  p2 = new Particle(x-100, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//  
//  constraints.add(new Distance(p1, p2)) ;
}

void scene1(List<Particle> particles, List<Constraint> constraints)
{
  particles.clear() ;
  constraints.clear() ;
  
  double s = 15.0 ;
  double x = 400.0 ; 
  double y = 500.0 ; 
  int count = 25 ;

  Particle p1 = new Particle(x, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;
  
  Particle p0 = p1 ;
  
  for (int i=1; i<=count; i++)
  {
    Particle p2 = new Particle(x + i * s, y, 5.0 + (i*2.0)/count) ;
    p2.Mass = 1.0 + i * 0.25 ; //(i==count) ? 100.0 : 1.0 ;
      
    p2.Velocity.Zero();
    particles.add(p2) ;
  
    constraints.add(new ConstraintDistance(p1, p2)) ;
    p1 = p2 ;
  }
  
  p1 = new Particle(30.0, 30.0, 15.0) ;
  p1.Mass = 5.0 ;
  p1.Velocity.Zero();
  particles.add(p1) ;
  
  var p2 = new Particle(70.0, 30.0, 15.0) ;
  p2.Mass = 5.0 ;
  p2.Velocity.Zero();
  particles.add(p2) ;
  
  var p3 = new Particle(70.0, 70.0) ;
  p3.Mass = 5.0 ;
  p3.Velocity.Zero();
  particles.add(p3) ;

  var p4 = new Particle(30.0, 70.0) ;
  p4.Mass = 5.0 ;
  p4.Velocity.Zero();
  particles.add(p4) ;
  
  constraints.add(new ConstraintDistance(p1, p2)) ;
  constraints.add(new ConstraintDistance(p2, p3)) ;
  constraints.add(new ConstraintDistance(p3, p4)) ;
  constraints.add(new ConstraintDistance(p4, p1)) ;
  constraints.add(new ConstraintDistance(p1, p3)) ;
  constraints.add(new ConstraintDistance(p2, p4)) ;
}
