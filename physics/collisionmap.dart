library phx_collisions ;

import 'particle.dart';
import 'contact.dart';


class CollisionPair
{
  Particle _a ;
  Particle _b ;
  
  Contact _contact = null ;
  
  CollisionPair(this._a, this._b)
  {
    _contact = null ;
  }
  
  void SetContact(Contact contact)
  {
    if (contact == null) return ;
    
    _contact = contact ;
  }
  
  Contact get Details => _contact ;
  
  Particle get A => _a ;
  Particle get B => _b ;
  
  void Discard()
  {
    _contact = null ;
  }
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
  
  int get ParticlesCount => _particlesCount ;
  
  int _getParticleIndex(Particle p)
  {
    if (!_index.containsKey(p))
      _index[p] = _index.values.length ;
    
    return _index[p] ;
  }
  
  List<CollisionPair> GetPairs(Particle a)
  {
    List<CollisionPair> result = new List<CollisionPair>() ;
    
    if (_pairs != null)
    {
      for (CollisionPair pair in _pairs.values)
      {
        if (pair.A == a || pair.B == a)
        {
          result.add(pair) ;
        }
      }
    }
    return result ;
  }

  int _getPairIndex(Particle a, Particle b)
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
    return (idxB * _particlesCount + idxA) ;    
  }
  
  CollisionPair Get(Particle a, Particle b)
  {
    if (a.IsFixed && b.IsFixed)
      return null ;
    
    int index = _getPairIndex(a, b);
    
    if (!_pairs.containsKey(index))
      _pairs[index] = new CollisionPair(a, b) ;
    
    return _pairs[index] ;
  }
  
  List<CollisionPair> get Pairs => _pairs.values.toList(growable: false) ;
  
  int get DynamicCollisionsCount 
  {
    int result = 0 ;
    for (CollisionPair pair in Pairs)
    {
      result += (pair.Details != null) ? 1 : 0 ;
    }
    return result ;
  }
}