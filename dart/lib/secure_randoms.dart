import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class SecureRandoms {
  static FortunaRandom fortunaSeededWithDartSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    var seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255 + 1));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }
}

extension FortunaRandomOnEllipticCurve on FortunaRandom {
  ECPrivateKey generateECPrivateKey(ECDomainParameters ec) {
    var n = ec.n;
    var nBitLength = n.bitLength;
    BigInt? d;

    do {
      d = nextBigInteger(nBitLength);
    } while (d == BigInt.zero || (d >= n));

    return ECPrivateKey(d, ec);
  }
}