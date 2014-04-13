// Copyright (c) 2013, Iván Zaera Avellón - izaera@gmail.com
// Use of this source code is governed by a LGPL v3 license.
// See the LICENSE file for more information.

library cipher.modes.cbc;

import "dart:typed_data";

import "package:cipher/api.dart";
import "package:cipher/params/parameters_with_iv.dart";
import "package:cipher/block/base_block_cipher.dart";

/// Implementation of Cipher-Block-Chaining (CBC) mode on top of a [BlockCipher].
class CBCBlockCipher extends BaseBlockCipher {

  final BlockCipher _underlyingCipher;

  Uint8List _IV;
  Uint8List _cbcV;
  Uint8List _cbcNextV;

  bool _encrypting;

  CBCBlockCipher(this._underlyingCipher) {
    this._IV = new Uint8List(blockSize);
    this._cbcV = new Uint8List(blockSize);
    this._cbcNextV = new Uint8List(blockSize);
  }

  String get algorithmName => "${_underlyingCipher.algorithmName}/CBC";
  int get blockSize => _underlyingCipher.blockSize;

  void reset() {
    _cbcV.setAll( 0, _IV );
    _cbcNextV.fillRange( 0, _cbcNextV.length, 0 );

    _underlyingCipher.reset();
  }

  void init(bool forEncryption, ParametersWithIV params) {
    if( params.iv.length != blockSize ) {
      throw new ArgumentError("Initialization vector must be the same length as block size");
    }

    this._encrypting = forEncryption;
    _IV.setAll( 0, params.iv );
    _underlyingCipher.init( forEncryption, params.parameters );

    reset();
  }

  int processBlock(Uint8List inp, int inpOff, Uint8List out, int outOff)
    => _encrypting
          ? _encryptBlock( inp, inpOff, out, outOff )
          : _decryptBlock( inp, inpOff, out, outOff );

  int _encryptBlock( Uint8List inp, int inpOff, Uint8List out, int outOff ) {
    if( (inpOff + blockSize) > inp.length ) {
      throw new ArgumentError("Input buffer too short");
    }

    // XOR the cbcV and the input, then encrypt the cbcV
    for( int i=0 ; i<blockSize ; i++ ) {
        _cbcV[i] ^= inp[inpOff + i];
    }

    int length = _underlyingCipher.processBlock(_cbcV, 0, out, outOff);

    // copy ciphertext to cbcV
    _cbcV.setRange( 0, blockSize, out.sublist(outOff) );

    return length;
  }

  int _decryptBlock( Uint8List inp, int inpOff, Uint8List out, int outOff ) {

    if( (inpOff + blockSize) > inp.length ) {
      throw new ArgumentError("Input buffer too short");
    }

    _cbcNextV.setRange( 0, blockSize, inp.sublist(inpOff) );

    int length = _underlyingCipher.processBlock( inp, inpOff, out, outOff );

    // XOR the cbcV and the output
    for( int i=0 ; i<blockSize ; i++ ) {
      out[outOff + i] ^= _cbcV[i];
    }

    // swap the back up buffer into next position
    Uint8List tmp;

    tmp = _cbcV;
    _cbcV = _cbcNextV;
    _cbcNextV = tmp;

    return length;
  }

}
