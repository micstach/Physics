library toolinterface;

abstract class Tool
{
  void Activate() ;
  void Deactivate() ;
  bool get IsActive ;
  void Render(var drawSeed, var drawPath) ;
  String get Name ;
}