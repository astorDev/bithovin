import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';
import 'package:pointycastle/ecc/ecc_fp.dart' as ecc_fp;

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
  ECPrivateKey generatePrivateKey(ECDomainParameters ec) {
    var n = ec.n;
    var nBitLength = n.bitLength;
    BigInt? d;

    do {
      d = nextBigInteger(nBitLength);
    } while (d == BigInt.zero || (d >= n));

    return ECPrivateKey(d, ec);
  }
}

class EllipticCurve {
  static ECSignature sign(Uint8List data,  ECPrivateKey value, String algorithm) {
    var signer = Signer(algorithm) as ECDSASigner;
    var signerPrivateKey = PrivateKeyParameter<ECPrivateKey>(value);
    var signerRandom = SecureRandoms.fortunaSeededWithDartSecureRandom();
    var signerParams = ParametersWithRandom(signerPrivateKey, signerRandom);
    signer.init(true, signerParams);

    return signer.generateSignature(data) as ECSignature;
  }

  static ECPublicKey constructPublicKey(BigInt x, BigInt y, ECDomainParameters params) {
    var Q = ecc_fp.ECPoint(
      params.curve as ecc_fp.ECCurve,
      params.curve.fromBigInteger(x) as ecc_fp.ECFieldElement?,
      params.curve.fromBigInteger(y) as ecc_fp.ECFieldElement?,
      true
    );

    return ECPublicKey(Q, params);
  }

  static bool verify(Uint8List data, ECSignature signature, ECPublicKey publicKey, {String algorithm = 'SHA-256/ECDSA'}) {
    final verifier = Signer(algorithm) as ECDSASigner;

    verifier.init(false, PublicKeyParameter<ECPublicKey>(publicKey));

    try {
      return verifier.verifySignature(data, signature);
    } on ArgumentError {
      return false;
    }
  }
}

extension Hex on Uint8List {
  static Uint8List decode(String hex) {
    var str = hex.replaceAll(" ", "");
    str = str.toLowerCase();
    if (str.length % 2 != 0) {
      str = "0$str";
    }
    var l = str.length ~/ 2;
    var result = Uint8List(l);
    for (var i = 0; i < l; ++i) {
      var x = int.parse(str.substring(i * 2, (2 * (i + 1))), radix: 16);
      if (x.isNaN) {
        throw ArgumentError('Expected hex string');
      }
      result[i] = x;
    }
    return result;
  }

  String hex() {
    var sb = StringBuffer();
    for (var b in this) {
      var s = b.toRadixString(16).toUpperCase();
      if (s.length == 1) {
        s = '0$s';
      }
      sb.write(s);
    }
    return sb.toString();
  }
}