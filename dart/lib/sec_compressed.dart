import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:dart/der.dart';
import 'package:dart/hex.dart';
import 'package:dart/secp256k1.dart';

class SecCompressed extends BytesFormat {
  SecCompressed(Uint8List bytes) : super(bytes);

  factory SecCompressed.fromECPoint(ECPoint ecPoint) {
    var bytes = ecPoint.getEncoded(true);
    return SecCompressed(bytes);
  }

  ECPoint toECPoint(ECCurve curve) {
    return Secp256k1.curve.decodePoint(bytes)!;
  }
}

extension HexExtensions on Hex {
  SecCompressed toSecCompressed() {
    return SecCompressed(toBytes());
  }
}