library particle.create;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart';
import '../physics/particle.dart';

import 'canvas.tool.dart' ;

import 'dart:html';

class CreateParticle extends CanvasTool
{
  double _alpha = 1.0 ;
  List _path = null ;
  final List _particles ;
  Particle _particle = null ;
  final _velocityFactor ;
  MouseEvent _mouseEvent = null ;
  
  CreateParticle(CanvasElement canvas, particles, velocityFactor)
      : super(canvas)
      , _velocityFactor = velocityFactor
      , _particles = particles 
  {
  }
  
  void OnMouseDown(MouseEvent e)
  {
    Vec2 point = ConvertToWorldCoords(e) ;
    
    createParticle(point.x, point.y, (e.ctrlKey) ? double.INFINITY : 1.0) ;
  }

  void OnMouseMove(MouseEvent e)
  {
    Vec2 point = ConvertToWorldCoords(e) ;
    
    changeVelocity(point, (e.ctrlKey) ? double.INFINITY : 1.0) ;
  }

  void OnMouseUp(MouseEvent e)
  {
    addParticle((e.ctrlKey) ? double.INFINITY : 1.0) ;
  }
  
  bool get IsActive => _particle != null ; 
  
  List GetParticlePath() { return _path ; }
  
  SetParticlePath(List path) { _path = path ;}
  
  void Draw(Renderer renderer)
  {
    super.Draw(renderer) ;
    
    if (IsActive)
    {
      if (_particle == null) return ;
      
      // copy particles
      var particles = new List<Particle>() ;
      
      for (Particle p in _particles)
      {
        particles.add(new Particle.fromParticle(p)) ;
      }   
      particles.add(new Particle.fromParticle(_particle))  ;      

      _path = new List<Vec2>() ;
      _path.add(particles[particles.length-1].Position);
      
      /*var simulation = new Simulation() ;
      
      for (int i=0; i<1000; i++)
      {
        simulation.Simulate(particles) ;
        
        // last particle is our NEW particle
        _path.add(particles[particles.length-1].Position);
      }
      */
      _alpha = 0.75 ;
      
      renderer.drawCircle(_particle.Position, _particle.Radius, "rgba(255, 128, 128, ${_alpha})") ;
      renderer.drawVector(_particle.Velocity * 10.0, _particle.Position, "rgba(255, 128, 0, 1.0)") ;

      renderer.drawPath(_path, false, "rgba(0, 0, 0, ${_alpha})", "rgba(192, 192, 192, ${_alpha})");
      renderer.drawCircle(_path[_path.length-1], _particle.Radius, "rgba(128, 128, 128, ${_alpha/2.0})") ;
    }
    else
    {
      if (_path != null)
      {
        if (_alpha > 0.0)
        {
          renderer.drawCircle(_path[_path.length-1], 10.0, "rgba(128, 128, 128, ${_alpha})") ;
          renderer.drawPath(_path, false, "rgba(0, 0, 0, ${_alpha})", "rgba(192, 192, 192, ${_alpha})");
        }
        _alpha -= 0.05 ;
        if (_alpha <= 0.0)
          _alpha = 0.0 ;
      }
    }
  }
  
  String get Name => "click and hold mouse button to create particle and set its velocity, user CTRL + click to create fixed particle " ;

  void createParticle(double x, double y, double mass)
  {
    _particle = new Particle(x, y) ;
    _particle.Mass = mass ;
    _particle.Velocity.Zero() ;
  }
  
  void changeVelocity(Vec2 point, double mass)
  {
    if (_particle != null)
    {
      _particle.Mass = mass ;
      
      if (mass != double.INFINITY)
        _particle.Velocity = (point - _particle.Position) * (_velocityFactor) ;
      else
        _particle.Velocity.Zero() ;
    }
  }
  
  void addParticle(double mass)
  {
    if (_particle != null)
    {
      _particle.Mass = mass ;
      _particles.add(_particle) ;
    }
    
    _particle = null ;
  }
}