import 'dart:typed_data';

import 'hex.dart';
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/ecc/api.dart';

class Sec1Der extends BytesFormat {
  Sec1Der(super.bytes);

  factory Sec1Der.fromECSignature(ECSignature signature) {
    var outer = ASN1Sequence();
    outer.add(ASN1Integer(signature.r));
    outer.add(ASN1Integer(signature.s));
    var bytes = outer.encode();
    return Sec1Der(bytes);
  }

  static Uint8List encode(ECSignature signature) {
    var outer = ASN1Sequence();
    outer.add(ASN1Integer(signature.r));
    outer.add(ASN1Integer(signature.s));
    return outer.encode();
  }

  static ECSignature decode(Uint8List bytes) {
    var parser = ASN1Sequence.fromBytes(bytes).elements!;
    var el1 = parser.elementAt(0) as ASN1Integer;
    var el2 = parser.elementAt(1) as ASN1Integer;

    return ECSignature(el1.integer!, el2.integer!);
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

  Hex get hex => Hex.fromBytes(bytes);
}

extension DerExtension on ECSignature {
  Sec1Der toSec1Der() => Sec1Der.fromECSignature(this);
}

extension DerHexExtension on Hex {
  Sec1Der toSec1Der() => Sec1Der(toBytes());
}