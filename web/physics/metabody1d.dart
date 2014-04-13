library metabody1d;

import '../../renderer/renderer.dart';
import '../../math/vec2.dart';
import '../../math/box2.dart';

import 'body.dart';

class MetaBody1D extends Body {
  Body _a = null, _b = null;

  double _f = 0.0;
  double _one_minus_f = 0.0;
  double _radius = 0.0;

  MetaBody1D(this._a, this._b, this._f): super() {
    _one_minus_f = (1.0 - _f);
    _radius = (_a.Radius * _f + _b.Radius * _one_minus_f);
  }

  void Render(Renderer renderer) {
//    renderer.drawCircle(Position, Radius, "rgba(0, 0, 128, 0.5)");
    int massColor = (255.0 * MassInv).toInt() ;
    var color = "rgba(${massColor}, 0, 0, 0.5)" ;
    renderer.drawCircle(Position, Radius, color);
  }

  @override
  double get Mass => 1.0;

  @override
  bool get IsFixed => false;

  @override
  Vec2 get Velocity => (_a.Velocity * _f + _b.Velocity * _one_minus_f);

  @override
  Vec2 get Position => (_a.Position * _f + _b.Position * _one_minus_f);

  @override
  double get Radius => _radius;

  @override
  void Integrate(double dt, [bool propagate = false]) {
    if (propagate) {
      _a.Integrate(dt, propagate);
      _b.Integrate(dt, propagate);
    }
  }

  @override
  void AddForce(Vec2 force, [bool propagate = false]) {
    if (propagate) {
      _a.AddForce(force * _f, propagate);
      _b.AddForce(force * _one_minus_f, propagate);
    }
  }

  @override
  Box2 get Box => new Box2(Position - Velocity, Velocity).Extend(Radius);

  toJSON() {
    return {
      'type': 'metabody1d',
      'a': _a.hashCode,
      'b': _b.hashCode,
      'f': _f,
      'hash-code': hashCode
    };
  }

  @override
  bool IsRelatedTo(Body body) {
    if (body is MetaBody1D) {
      // (?) same parents
      return (((body._a == _a) && (body._b == _b)) || ((body._b == _a) &&
          (body._a == _b)));
    } else {
      // (?) this is child of body
      return (body == _a || body == _b);
    }
  }

  @override
  double get MassInv => (_a.MassInv * _f + _b.MassInv * _one_minus_f);

  @override
  set Position(Vec2 value) {
    if (!_a.IsFixed) _a.Position = value * _f;
    if (!_b.IsFixed) _b.Position = value * _one_minus_f;
  }

  @override
  set Velocity(Vec2 value) {
    if (!_a.IsFixed) _a.Velocity = value * _f;
    if (!_b.IsFixed) _b.Velocity = value * _one_minus_f;
  }

  @override
  void PositionMove(Vec2 delta) {
    if (!_a.IsFixed) _a.PositionMove(delta * _f);
    if (!_b.IsFixed) _b.PositionMove(delta * _one_minus_f);
  }

  @override
  void ResetToCollisionTimePosition(double dt) {
    if (!_a.IsFixed) _a.ResetToCollisionTimePosition(dt);
    if (!_b.IsFixed) _b.ResetToCollisionTimePosition(dt);
  }

  @override
  void VelocityMove(Vec2 delta) {
    if (!_a.IsFixed) _a.VelocityMove(delta * _f);
    if (!_b.IsFixed) _b.VelocityMove(delta * _one_minus_f);
  }
}
