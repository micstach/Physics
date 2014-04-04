
import "../../renderer/renderer.dart" ;
import "../../math/vec2.dart" ;

import 'tool.dart' ;
import 'dart:html' ;

abstract class CanvasTool extends Tool
{
  CanvasElement _canvas ;
  
  MouseEvent _mouseEvent = null ;
  
  var _onMouseUpStream = null ;
  var _onMouseDownStream = null ;
  var _onMouseMoveStream = null ;
  var _onMouseLeaveStream = null ;
  var _onClickStream = null ;
  
  CanvasTool(this._canvas) ;
  
  void Activate()
  {
    _onMouseUpStream = Canvas.onMouseUp.listen((e) => _onMouseUp(e)) ;
    _onMouseDownStream = Canvas.onMouseDown.listen((e) => _onMouseDown(e)) ;
    _onMouseMoveStream = _canvas.onMouseMove.listen((e) => _onMouseMove(e)) ;
    _onMouseLeaveStream = _canvas.onMouseLeave.listen((e) => _onMouseLeave(e)) ;
    _onClickStream = Canvas.onClick.listen((e) => _onClick(e)) ;
    
    OnActivate() ;
  }
  
  void Deactivate()
  {
    _onMouseMoveStream.cancel() ;
    _onMouseLeaveStream.cancel() ;
    _onMouseDownStream.cancel() ;
    _onMouseUpStream.cancel() ;
    _onClickStream.cancel() ;
    
    OnDeactivate() ;
  }
  
  void OnActivate() {} 
  void OnDeactivate() {} 
  
  void _onClick(MouseEvent e)
  {
    OnClick(e) ;
  }
  
  void _onMouseUp(MouseEvent e)
  {
    OnMouseUp(e) ;
  }
  
  void _onMouseMove(MouseEvent e)
  {
    _mouseEvent = e ;
    
    OnMouseMove(e) ;
  }
  
  void _onMouseDown(MouseEvent e)
  {
    OnMouseDown(e) ;
  }
  
  void _onMouseLeave(MouseEvent e)
  {
    _mouseEvent = null ;
    
    OnMouseLeave() ;
  }
  
  void OnClick(MouseEvent e) {}
  
  void OnMouseMove(MouseEvent e) {}
  
  void OnMouseLeave() {}
  
  void OnMouseDown(MouseEvent e) {}
  
  void OnMouseUp(MouseEvent e) {}

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