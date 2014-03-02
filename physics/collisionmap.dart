library phx_collisions ;

import 'particle.dart';

class CollisionPair
{
  Particle _a ;
  Particle _b ;
  double _dt ;
  
  CollisionPair(this._a, this._b)
  {
    _dt = 1.0 ;
  }
  
  void AccumulateDt(double dt)
  {
    if (dt < _dt)
    {
      _dt = dt ;
    }
  }
  
  double get Dt => _dt ;
  
  Particle get A => _a ;
  Particle get B => _b ;
}

class CollisionMap
{
  int _particlesCount = 0;
  Map<Particle, int> _index = null ;
  Map<int, CollisionPair> _pairs = null ;
  
  CollisionMap(int n)
  {
    _particlesCount = n ;
    _index = new Map<Particle, int>() ;
    _pairs = new Map<int, CollisionPair>() ;
  }
  
  int _getParticleIndex(Particle p)
  {
    if (!_index.containsKey(p))
      _index[p] = _index.values.length ;
    
    return _index[p] ;
  }
  
  CollisionPair Get(Particle a, Particle b)
  {
    var idxA = _getParticleIndex(a) ;
    var idxB = _getParticleIndex(b) ;
    
    if (idxB > idxA)
    {
      var tmp = idxB ;
      idxB = idxA ;
      idxA = tmp ;
      
      var c = b ;
      b = a ;
      a = c ;
    }

    // unique index
    int index = (idxB * _particlesCount + idxA) ;
    
    if (!_pairs.containsKey(index))
      _pairs[index] = new CollisionPair(a, b) ;
    
    return _pairs[index] ;
  }
  
  List<CollisionPair> get Pairs => _pairs.values.toList(growable: false) ;
}