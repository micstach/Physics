
import "../../renderer/renderer.dart" ;
import "../../math/vec2.dart" ;

import 'tool.dart' ;
import 'dart:html' ;

abstract class CanvasTool extends Tool
{
  CanvasElement _canvas ;
  
  MouseEvent _mouseEvent = null ;
  
  var _onMouseMoveStream = null ;
  var _onMouseLeaveStream = null ;
  
  CanvasTool(this._canvas) ;
  
  void Activate()
  {
    _onMouseMoveStream = _canvas.onMouseMove.listen((e) => onMouseMove(e)) ;
    _onMouseLeaveStream = _canvas.onMouseLeave.listen((e) => onMouseLeave(e)) ;
  }
  
  void Deactivate()
  {
    _onMouseMoveStream.cancel() ;
    _onMouseLeaveStream.cancel() ;
  }
  
  void onMouseMove(MouseEvent e)
  {
    _mouseEvent = e ;
  }
  
  void onMouseLeave(MouseEvent e)
  {
    _mouseEvent = null ;
  }
  
  void Draw(Renderer renderer)
  {
    // render cursor
    if (_mouseEvent != null)
    {
      Vec2 point = ConvertToWorldCoords(_mouseEvent) ;
      
      String color = "rgba(0, 0, 255, 0.05)" ;
      
      renderer.drawVector(new Vec2(0.0, -point.y), point, color) ;
      renderer.drawVector(new Vec2(0.0, _canvas.clientHeight - point.y), point, color) ;
      renderer.drawVector(new Vec2(-point.x, 0.0), point, color) ;
      renderer.drawVector(new Vec2(_canvas.clientWidth - point.x, 0.0), point, color) ;
    }
  }
  
  Vec2 ConvertToWorldCoords(MouseEvent e)
  {
    return new Vec2(e.layer.x.toDouble(), _canvas.clientHeight - e.layer.y.toDouble()) ;
  }
  
  CanvasElement get Canvas => _canvas ; 

  Vec2 get Position => _mouseEvent == null ? null : ConvertToWorldCoords(_mouseEvent) ;
}