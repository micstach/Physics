library phx_collisions ;

import 'particle.dart';
import 'collision.pair.dart' ;

class CollisionMap
{
  List<Particle> Particles = null ;
  
  int _particlesCount = 0 ;
  
  Map<Particle, int> _index = null ;
  Map<int, CollisionPair> _pairs = null ;
  Map<Particle, List<CollisionPair>> _particlePairs = null ;
  
  CollisionMap(List<Particle> particles)
  {
    Particles = particles ;

    _initialize() ;
  }
  
  void Update(List<Particle> particles)
  {
    if (particles.length != _particlesCount)
    {
      _initialize() ;
    }
  }
  
  void _initialize()
  {
    _particlesCount = Particles.length ;

    _index = new Map<Particle, int>() ;
    _pairs = new Map<int, CollisionPair>() ;
    _particlePairs = new Map<Particle, List<CollisionPair>>() ;
    
    // initialize collision pairs
    for (int i=0; i<Particles.length; i++)
    {
      Particle a = Particles[i] ;
      
      for (int j=i+1; j<Particles.length; j++)
      {
        Particle b = Particles[j] ;
        
        if (a.IsFixed && b.IsFixed) continue ;
        
        int index = _getPairIndex(a, b);
        
        if (!_pairs.containsKey(index))
          _pairs[index] = new CollisionPair(a, b) ;
      }
    }
    
    // initialize particle pairs
    for (int i=0; i<Particles.length; i++)
    {
      GetPairs(Particles[i]) ;
    }
  }
  
  int _getParticleIndex(Particle p)
  {
    if (!_index.containsKey(p))
      _index[p] = _index.values.length ;
    
    return _index[p] ;
  }
  
  List<CollisionPair> GetPairs(Particle a)
  {
    if (_particlePairs.containsKey(a))
      return _particlePairs[a] ;
    else
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
      
      _particlePairs[a] = result ;
    
      return _particlePairs[a] ;
    }
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
    return (idxB * Particles.length + idxA) ;    
  }
  
//  CollisionPair Get(Particle a, Particle b)
//  {
//    if (a.IsFixed && b.IsFixed)
//      return null ;
//    
//    int index = _getPairIndex(a, b);
//    
//    if (!_pairs.containsKey(index))
//      _pairs[index] = new CollisionPair(a, b) ;
//    
//    return _pairs[index] ;
//  }
  
  List<CollisionPair> get Pairs => _pairs.values.toList(growable: false) ;
  
  int get DynamicCollisionsCount 
  {
    int result = 0 ;
    for (CollisionPair pair in Pairs)
    {
      result += (pair.GetContact() != null) ? 1 : 0 ;
    }
    return result ;
  }
}