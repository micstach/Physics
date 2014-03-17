library phx_collision_pair;

import 'particle.dart' ;
import 'contact.dart' ;

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
  
  Contact GetContact()
  {
    return _contact ;
  }
  
  void Discard()
  {
    _contact = null ;
  }
  
  Particle get A => _a ;
  Particle get B => _b ;
}
