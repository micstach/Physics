library particle.create;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart';
import '../physics/scene.dart';
import '../physics/particle.dart';

import 'canvas.tool.dart' ;

import 'dart:html';

class CreateParticle extends CanvasTool
{
  double _alpha = 1.0 ;
  List _path = null ;
  final Scene _scene ;
  Particle _particle = null ;
  final _velocityFactor ;
  MouseEvent _mouseEvent = null ;
  
  CreateParticle(CanvasElement canvas, this._scene, this._velocityFactor) : super(canvas)
  {
  }
  
  void OnMouseDown(MouseEvent e)
  {
    Vec2 point = Position ;
    
    createParticle(point.x, point.y, (e.ctrlKey) ? double.INFINITY : 1.0) ;
  }

  void OnMouseMove(MouseEvent e)
  {
    Vec2 point = Position ;
    
    changeVelocity(point, (e.ctrlKey) ? double.INFINITY : 1.0) ;
  }

  void OnMouseUp(MouseEvent e)
  {
    addParticle((e.ctrlKey) ? double.INFINITY : 1.0) ;
  }
  
  bool get IsActive => _particle != null ; 
 
  void Draw(Renderer renderer)
  {
    super.Draw(renderer) ;
    
    if (IsActive)
    {
      if (_particle == null) return ;

      renderer.drawCircle(_particle.Position, _particle.Radius, "rgba(255, 128, 128, 0.75)") ;
      renderer.drawVector(_particle.Velocity * 10.0, _particle.Position, "rgba(255, 128, 0, 1.0)") ;
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
      _scene.bodies.add(_particle) ;
    }
    
    _particle = null ;
  }
}