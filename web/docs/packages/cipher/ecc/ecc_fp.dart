// Copyright (c) 2013, Iván Zaera Avellón - izaera@gmail.com
// Use of this source code is governed by a LGPL v3 license.
// See the LICENSE file for more information.

library cipher.ecc.ecc_fp;

import "dart:typed_data";

import 'package:bignum/bignum.dart';
import "package:cipher/api.dart";
import "package:cipher/ecc/ecc_base.dart" hide ECFieldElementBase, ECPointBase, ECCurveBase;
import "package:cipher/ecc/ecc_base.dart" as ecc;

class ECFieldElement extends ecc.ECFieldElementBase {

  final BigInteger q;
  final BigInteger x;

  ECFieldElement( this.q, this.x ) {
    if( x >= q ) {
      throw new ArgumentError("Value x must be smaller than q");
    }
  }

  String get fieldName => "Fp";
  int get fieldSize => q.bitLength();

  BigInteger toBigInteger() => x;

  ECFieldElement operator +( ECFieldElement b ) => new ECFieldElement( q, (x + b.toBigInteger()) % q );
  ECFieldElement operator -( ECFieldElement b ) => new ECFieldElement( q, (x - b.toBigInteger()) % q );
  ECFieldElement operator *( ECFieldElement b ) => new ECFieldElement( q, (x * b.toBigInteger()) % q );
  ECFieldElement operator /( ECFieldElement b ) => new ECFieldElement( q, (x * b.toBigInteger().modInverse(q)) % q );

  ECFieldElement operator -() => new ECFieldElement( q, -x % q );

  ECFieldElement invert() => new ECFieldElement( q, x.modInverse(q) );
  ECFieldElement square() => new ECFieldElement( q, x.modPow(BigInteger.TWO,q) );

  // D.1.4 91
  /**
   * return a sqrt root - the routine verifies that the calculation
   * returns the right value - if none exists it returns null.
   */
  ECFieldElement sqrt() {

     if( !q.testBit(0) ) {
       throw new UnimplementedError("Not implemented yet");
     }

     // p % 4 == 3
     if( q.testBit(1) ) {
       // z = g^(u+1) + p, p = 4u + 3
       var z = new ECFieldElement( q, x.modPow( (q>>2) + BigInteger.ONE, q ) );
       return z.square() == this ? z : null;
     }

     // p % 4 == 1
     var qMinusOne = q - BigInteger.ONE;

     var legendreExponent = qMinusOne >> 1;
     if( x.modPow( legendreExponent, q )!= BigInteger.ONE ) {
       return null;
     }

     var u = qMinusOne >> 2;
     var k = (u << 1) + BigInteger.ONE;

     var Q = x;
     var fourQ = (Q >> 2) % q;

     var U, V;
     var rand = new SecureRandom();
     do
     {
       BigInteger P;
       do {
         P = rand.nextBigInteger( q.bitLength() );
       } while( (P >= q)  || ( ( (P*P) - fourQ ).modPow( legendreExponent, q ) != qMinusOne ) );

       List<BigInteger> result = _lucasSequence( q, P, Q, k );
       U = result[0];
       V = result[1];

       if( ( (V*V) % q ) == fourQ ) {
         // Integer division by 2, mod q
         if( V.testBit(0) ) {
           V = V + q;
         }

         V = ( V >> 1 );

         //assert V.multiply(V).mod(q).equals(x);

         return new ECFieldElement( q, V );
       }
     } while( (U == BigInteger.ONE) || (U == qMinusOne) );

     return null;
  }

  List<BigInteger> _lucasSequence( BigInteger p, BigInteger P, BigInteger Q, BigInteger k ) {

    var n = k.bitLength();
    var s = k.lowestSetBit;

    BigInteger Uh = BigInteger.ONE;
    BigInteger Vl = BigInteger.TWO;
    BigInteger Vh = P;
    BigInteger Ql = BigInteger.ONE;
    BigInteger Qh = BigInteger.ONE;

    for( var j=n-1 ; j>=(s+1) ; j-- ) {
      Ql = (Ql*Qh) % p;

      if( k.testBit(j) ) {
        Qh = (Ql*Q) % p;
        Uh = (Uh*Vh) % p;
        Vl = ((Vh*Vl)-(P*Ql)) % p;
        Vh = ((Vh*Vh)-(Qh<<1)) % p;
      } else {
        Qh = Ql;
        Uh = ((Uh*Vl)-Ql) % p;
        Vh = ((Vh*Vl)-(P*Ql)) % p;
        Vl = ((Vl*Vl)-(Ql<<1)) % p;
      }
    }

    Ql = (Ql*Qh) % p;
    Qh = (Ql*Q) % p;
    Uh = ((Uh*Vl)-Ql) % p;
    Vl = ((Vh*Vl)-(P*Ql)) % p;
    Ql = (Ql*Qh) % p;

    for( var j=1 ; j<=s ; j++ ) {
      Uh = (Uh*Vl) % p;
      Vl = ((Vl*Vl)-(Ql<<1)) % p;
      Ql = (Ql*Ql) % p;
    }

    return [ Uh, Vl ];
  }

  bool operator ==(other) {
    if( other is ECFieldElement ) {
      return (q == other.q) && (x == other.x);
    }
    return false;
  }

  int get hashCode => q.hashCode ^ x.hashCode;

}

/// Elliptic curve points over Fp
class ECPoint extends ecc.ECPointBase {

  /**
   * Create a point that encodes with or without point compresion.
   *
   * @param curve the curve to use
   * @param x affine x co-ordinate
   * @param y affine y co-ordinate
   * @param withCompression if true encode with point compression
   */
  ECPoint(ECCurve curve, ECFieldElement x, ECFieldElement y, [bool withCompression=false] ) :
      super( curve, x, y, withCompression, _WNafMultiplier ) {
    if( (x != null && y == null) || (x == null && y != null) ) {
      throw new ArgumentError("Exactly one of the field elements is null");
    }
  }

  /// return the field element encoded with point compression. (S 4.3.6)
  Uint8List getEncoded([bool compressed = true]) {
    if( isInfinity ) {
      return new Uint8List.fromList([1]);
    }

    var qLength = x.byteLength;
    if( compressed ) {

      int PC;

      if( y.toBigInteger().testBit(0) ) {
        PC = 0x03;
      } else {
        PC = 0x02;
      }

      Uint8List X = _x9IntegerToBytes( x.toBigInteger(), qLength );
      Uint8List PO = new Uint8List( X.length + 1 );

      PO[0] = PC.toInt();
      PO.setAll( 1, X );

      return PO;

    } else {

      Uint8List X = _x9IntegerToBytes( x.toBigInteger(), qLength );
      Uint8List Y = _x9IntegerToBytes( y.toBigInteger(), qLength );
      Uint8List PO = new Uint8List( X.length + Y.length + 1 );

      PO[0] = 0x04;
      PO.setAll( 1, X );
      PO.setAll( X.length+1, Y );

      return PO;
    }
  }

  // B.3 pg 62
  ECPoint operator +(ECPoint b) {
    if( isInfinity ) {
      return b;
    }

    if( b.isInfinity ) {
      return this;
    }

    // Check if b = this or b = -this
    if( x==b.x ) {
      if( y==b.y ) {
        // this = b, i.e. this must be doubled
        return twice();
      }

      // this = -b, i.e. the result is the point at infinity
      return curve.infinity;
    }

    var gamma = (b.y-y)/(b.x-x);

    var x3 = (gamma.square()-x)-b.x;
    var y3 = (gamma*( x-x3 )) - y;

    return new ECPoint(curve, x3, y3, isCompressed);
  }

  // B.3 pg 62
  ECPoint twice() {

    if( isInfinity ) {
      // Twice identity element (point at infinity) is identity
      return this;
    }

    if( y.toBigInteger() == 0 ) {
      // if y1 == 0, then (x1, y1) == (x1, -y1)
      // and hence this = -this and thus 2(x1, y1) == infinity
      return this.curve.infinity;
    }

    var TWO = curve.fromBigInteger(BigInteger.TWO);
    var THREE = curve.fromBigInteger(BigInteger.THREE);
    var gamma = ((x.square()*THREE)+curve.a)/(y*TWO);

    var x3 = gamma.square()-(x*TWO);
    var y3 = (gamma*(x-x3))-y;

    return new ECPoint(curve, x3, y3, isCompressed);
  }

  // D.3.2 pg 102 (see Note:)
  ECPoint operator -(ECPoint b)
  {
    if( b.isInfinity ) {
      return this;
    }

    // Add -b
    return this + (-b);
  }

  ECPoint operator -()
  {
    return new ECPoint(curve, x, -y, isCompressed );
  }

}

/// Elliptic curve over Fp
class ECCurve extends ecc.ECCurveBase {

  final BigInteger q;
  ECPoint _infinity;

  ECCurve( this.q, BigInteger a, BigInteger b ) : super(a,b) {
    _infinity = new ECPoint(this, null, null);
  }

  int get fieldSize => q.bitLength();
  ECPoint get infinity => _infinity;

  ECFieldElement fromBigInteger( BigInteger x ) => new ECFieldElement(this.q, x);
  ECPoint createPoint(BigInteger x, BigInteger y, [bool withCompression=false] )
    => new ECPoint(this, fromBigInteger(x), fromBigInteger(y), withCompression);

  ECPoint decompressPoint(int yTilde, BigInteger X1) {
    var x = fromBigInteger(X1);
    var alpha = (x*((x*x)+a)) + b;
    ECFieldElement beta = alpha.sqrt();

    //
    // if we can't find a sqrt we haven't got a point on the
    // curve - run!
    //
    if( beta == null ) {
      throw new ArgumentError("Invalid point compression");
    }

    var betaValue = beta.toBigInteger();
    var bit0 = betaValue.testBit(0) ? 1 : 0;

    if (bit0 != yTilde) {
      // Use the other root
      beta = fromBigInteger(q-betaValue);
    }

    return new ECPoint( this, x, beta, true );
  }

  bool operator ==(other) {
    if( other is ECCurve ) {
      return q==other.q && a==other.a && b==other.b;
    }
    return false;
  }

  int get hashCode => a.hashCode ^ b.hashCode ^ q.hashCode;
}

/**
 * Class holding precomputation data for the WNAF (Window Non-Adjacent Form)
 * algorithm.
 */
class _WNafPreCompInfo implements PreCompInfo {

  /// Array holding the precomputed [ECPoint]s used for the Window NAF multiplication.
  List<ECPoint> preComp;

  /// Holds an [ECPoint] representing twice(this). Used for the Window NAF multiplication.
  ECPoint twiceP;

}

/**
 * Function implementing the WNAF (Window Non-Adjacent Form) multiplication algorithm. Multiplies [p]] by an integer [k] using
 * the Window NAF method.
 */
ECPoint _WNafMultiplier(ECPoint p, BigInteger k, PreCompInfo preCompInfo) {

  // Ignore empty PreCompInfo or PreCompInfo of incorrect type
  _WNafPreCompInfo wnafPreCompInfo = preCompInfo;
  if( (preCompInfo == null) && (preCompInfo is! _WNafPreCompInfo) ) {
    wnafPreCompInfo = new _WNafPreCompInfo();
  }

  // floor(log2(k))
  var m = k.bitLength();

  // width of the Window NAF
  var width;

  // Required length of precomputation array
  var reqPreCompLen;

  // Determine optimal width and corresponding length of precomputation
  // array based on literature values
  if (m < 13) {
    width = 2;
    reqPreCompLen = 1;
  } else {
    if (m < 41) {
      width = 3;
      reqPreCompLen = 2;
    } else {
      if (m < 121) {
        width = 4;
        reqPreCompLen = 4;
      } else {
        if (m < 337) {
          width = 5;
          reqPreCompLen = 8;
        } else {
          if (m < 897) {
            width = 6;
            reqPreCompLen = 16;
          } else {
            if (m < 2305) {
              width = 7;
              reqPreCompLen = 32;
            } else {
              width = 8;
              reqPreCompLen = 127;
            }
          }
        }
      }
    }
  }

  // The length of the precomputation array
  var preCompLen = 1;

  var preComp = wnafPreCompInfo.preComp;
  var twiceP = wnafPreCompInfo.twiceP;

  // Check if the precomputed ECPoints already exist
  if (preComp == null) {
    // Precomputation must be performed from scratch, create an empty
    // precomputation array of desired length
    preComp = new List<ECPoint>.filled( 1, p );
  } else {
    // Take the already precomputed ECPoints to start with
    preCompLen = preComp.length;
  }

  if (twiceP == null) {
    // Compute twice(p)
    twiceP = p.twice();
  }

  if (preCompLen < reqPreCompLen) {
    // Precomputation array must be made bigger, copy existing preComp
    // array into the larger new preComp array
    List<ECPoint> oldPreComp = preComp;
    preComp = new List<ECPoint>(reqPreCompLen);
    preComp.setAll(0, oldPreComp);

    for (int i = preCompLen; i < reqPreCompLen; i++) {
      // Compute the new ECPoints for the precomputation array.
      // The values 1, 3, 5, ..., 2^(width-1)-1 times p are
      // computed
      preComp[i] = twiceP + (preComp[i - 1]);
    }
  }

  // Compute the Window NAF of the desired width
  var wnaf = _windowNaf(width, k);
  var l = wnaf.length;

  // Apply the Window NAF to p using the precomputed ECPoint values.
  var q = p.curve.infinity;
  for (int i = l - 1; i >= 0; i--) {
    q = q.twice();

    if (wnaf[i] != 0) {
      if (wnaf[i] > 0) {
        q += preComp[(wnaf[i] - 1)~/2];
      } else {
        // wnaf[i] < 0
        q -= preComp[(-wnaf[i] - 1)~/2];
      }
    }
  }

  // Set PreCompInfo in ECPoint, such that it is available for next
  // multiplication.
  wnafPreCompInfo.preComp = preComp;
  wnafPreCompInfo.twiceP = twiceP;
  p.preCompInfo = wnafPreCompInfo;
  return q;
}

/**
 * Computes the Window NAF (non-adjacent Form) of an integer.
 * @param width The width <code>w</code> of the Window NAF. The width is
 * defined as the minimal number <code>w</code>, such that for any
 * <code>w</code> consecutive digits in the resulting representation, at
 * most one is non-zero.
 * @param k The integer of which the Window NAF is computed.
 * @return The Window NAF of the given width, such that the following holds:
 * <code>k = &sum;<sub>i=0</sub><sup>l-1</sup> k<sub>i</sub>2<sup>i</sup>
 * </code>, where the <code>k<sub>i</sub></code> denote the elements of the
 * returned <code>byte[]</code>.
 */
List<int> _windowNaf(int width, BigInteger k) {

  // The window NAF is at most 1 element longer than the binary
  // representation of the integer k. byte can be used instead of short or
  // int unless the window width is larger than 8. For larger width use
  // short or int. However, a width of more than 8 is not efficient for
  // m = log2(q) smaller than 2305 Bits. Note: Values for m larger than
  // 1000 Bits are currently not used in practice.
  List<int> wnaf = new List<int>(k.bitLength() + 1);

  // 2^width as short and BigInteger
  int pow2wB = (1 << width);
  BigInteger pow2wBI = new BigInteger(pow2wB);

  int i = 0;

  // The actual length of the WNAF
  int length = 0;

  // while k >= 1
  while (k.signum() > 0) {
    // if k is odd
    if (k.testBit(0) ) {
      // k mod 2^width
      BigInteger remainder = k.mod(pow2wBI);

      // if remainder > 2^(width - 1) - 1
      if (remainder.testBit(width - 1)) {
        wnaf[i] = remainder.intValue() - pow2wB;
      } else {
        wnaf[i] = remainder.intValue();
      }

      // convert to "Java byte"
      wnaf[i] %= 0x100;
      if( (wnaf[i]&0x80)!=0 ) {
        wnaf[i] = wnaf[i]-256;
      }

      // wnaf[i] is now in [-2^(width-1), 2^(width-1)-1]

      k = k-new BigInteger(wnaf[i]);
      length = i;
    } else {
      wnaf[i] = 0;
    }

    // k = k/2
    k = k.shiftRight(1);
    i++;
  }

  length++;

  // Reduce the WNAF array to its actual length
  List<int> wnafShort = new List<int>(length);
  wnafShort.setAll(0, wnaf.sublist(0, length));
  return wnafShort;
}

Uint8List _x9IntegerToBytes( BigInteger s, int qLength ) {
  Uint8List bytes = new Uint8List.fromList(s.toByteArray());

  if( qLength < bytes.length ) {
    return bytes.sublist( bytes.length-qLength );
  } else if (qLength > bytes.length) {
    return new Uint8List(qLength)..setAll( qLength-bytes.length, bytes );
  }

  return bytes;
}






