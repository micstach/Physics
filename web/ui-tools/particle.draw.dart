library particle.drawfixed;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart';
import '../physics/scene.dart';
import '../physics/particle.dart';
import '../physics/constraint.distance.dart';

import 'canvas.tool.dart' ;

import 'package:uuid/uuid_client.dart' ;
import 'dart:html';

class DrawParticles extends CanvasTool
{
  double _alpha = 1.0 ;
  List _path = null ;
  
  Particle _particle = null ;
  Particle _currentParticle = null ;
  Particle _previousParticle = null ;
  
  final Scene _scene ; 
  
  DrawParticles(CanvasElement canvas, this._scene) : super(canvas)
  {
  }
  
  void OnActivate()
  {
  }
  
  void OnDeactivate() 
  {
  }
  
  void createParticle(double x, double y, double mass)
  {
    _particle = new Particle(x, y, 10.0) ;
    _particle.Mass = mass ;
    _particle.Velocity.Zero() ;
  }
  
  void addParticle(double mass)
  {
    if (_particle != null)
    {
      
      _particle.Mass = mass ;
      _particle.GroupName = (new Uuid()).v1().toString() ;
      _scene.bodies.add(_particle) ;
      
      _previousParticle = _currentParticle ;
      _currentParticle = _particle ;
    }
    
    _particle = null ;
  }
  
  Vec2 _last = null ;
  void OnMouseUp(MouseEvent e)
  {
    _last = null ;
  }
  
  void OnMouseDown(MouseEvent e)
  {
    Vec2 mouse = Position ;
    
    createParticle(mouse.x, mouse.y, (e.ctrlKey) ? double.INFINITY : 1.0) ;
    addParticle((e.ctrlKey) ? double.INFINITY : 1.0) ;
    _last = mouse ;    
  }

  void OnKeyDown(KeyboardEvent e)
  {
    if (e.ctrlKey)
    {
      if (_particle != null)
      {
        _particle.Mass = (e.ctrlKey) ? double.INFINITY : 1.0 ;
      }
    }
  }
  
  void OnKeyUp(KeyboardEvent e)
  {
    if (_particle != null)
    {
      _particle.Mass = 5.0 ;
    }
  }
  
  void OnMouseMove(MouseEvent e)
  {
    Vec2 point = Position ;
    
    if (_last != null)
    {
      if ((_last-point).Length >= 20.0)
      {
        _last = point ;
        createParticle(point.x, point.y, (e.ctrlKey) ? double.INFINITY : 1.0) ;
        addParticle((e.ctrlKey) ? double.INFINITY : 1.0) ;
        
        if (e.shiftKey)
        {
          if (_previousParticle != null && _currentParticle != null)
            _scene.constraints.add(new ConstraintDistance(_previousParticle, _currentParticle)) ;
        }
      }
    }
  }

  bool get IsActive => _particle != null ; 
  
  List GetParticlePath() { return _path ; }
  
  SetParticlePath(List path) { _path = path ;}
  
  void Draw(Renderer renderer)
  {
    super.Draw(renderer) ;
  }
  
  String get Name => "draw particles, press CTRL to draw fixed particles" ;
}