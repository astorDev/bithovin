import 'dart:typed_data';

import 'hex.dart';
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/ecc/api.dart';

class Der extends BytesFormat {
  Der(super.bytes);

  factory Der.fromECSignature(ECSignature signature) {
    var outer = ASN1Sequence();
    outer.add(ASN1Integer(signature.r));
    outer.add(ASN1Integer(signature.s));
    var bytes = outer.encode();
    return Der(bytes);
  }

  ECSignature toECSignature() {
    var parser = ASN1Sequence.fromBytes(bytes).elements!;
    var el1 = parser.elementAt(0) as ASN1Integer;
    var el2 = parser.elementAt(1) as ASN1Integer;

    return ECSignature(el1.integer!, el2.integer!);
  }
}

class BytesFormat {
  Uint8List bytes;

  BytesFormat(this.bytes);

  Hex toHex() => Hex.fromBytes(bytes);
}

extension DerExtension on ECSignature {
  Der toDer() => Der.fromECSignature(this);
}

extension DerHexExtension on Hex {
  Der toDer() => Der(toBytes());
}