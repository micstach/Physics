library phx.collision.pair;

import 'particle.dart' ;
import 'contact.dart' ;
import 'pair.dart' ;

class CollisionPair extends Pair
{
  Contact _contact = null ;
  
  CollisionPair(Particle a, Particle b) : super(a, b)
  {
    _contact = null ;
  }
  
  void SetContact(Contact contact)
  {
    if (contact == null) return ;
    
    _contact = contact ;
  }
  
  Contact GetContact()
  {
    return _contact ;
  }
  
  void Discard()
  {
    _contact = null ;
  }
}

