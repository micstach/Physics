library phx_collisions ;

import 'particle.dart';
import 'contact.dart';


class CollisionPair
{
  Contact _contact = null ;
  
  CollisionPair()
  {
    _contact = null ;
  }
  
  void SetContact(Contact contact)
  {
    if (contact == null) return ;
    
    _contact = contact ;
  }
  
  Contact get Details => _contact ;
  
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
  Map<Particle, List<CollisionPair>> _particlePairs = null ;
  
  CollisionMap(int n)
  {
    _particlesCount = n ;
    _index = new Map<Particle, int>() ;
    _pairs = new Map<int, CollisionPair>() ;
    _particlePairs = new Map<Particle, List<CollisionPair>>() ;
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
        if (pair.Details != null)
        {
          if (pair.Details.A == a || pair.Details.B == a)
          {
            result.add(pair) ;
          }
        }
      }
    }
    
    if (!_particlePairs.containsKey(a))
      _particlePairs[a] = result ;
    
    return _particlePairs[a] ;
  }
  
  void Reset()
  {
    for (CollisionPair pair in _pairs.values)
    {
      pair.Discard() ;
    }
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
      _pairs[index] = new CollisionPair() ;
    
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