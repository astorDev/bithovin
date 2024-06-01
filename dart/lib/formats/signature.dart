import 'dart:typed_data';

import 'der.dart';
import 'hex.dart';
import 'package:pointycastle/ecc/api.dart';

class ECSignatureBytesStringFormat {
  String Function(Uint8List) bytesToString;
  Uint8List Function(String) stringToBytes;
  Uint8List Function(ECSignature) signatureToBytes;
  ECSignature Function(Uint8List) bytesToSignature;

  ECSignatureBytesStringFormat({
    required this.bytesToString,
    required this.stringToBytes,
    required this.signatureToBytes,
    required this.bytesToSignature,
  });

  String export(ECSignature signature) => bytesToString(signatureToBytes(signature));
  ECSignature import(String bytes) => bytesToSignature(stringToBytes(bytes));
}

class ECSignatureFormatRegistry {
  static final ECSignatureBytesStringFormat sec1DerHex = ECSignatureBytesStringFormat(
    bytesToString: Hex.encode,
    stringToBytes: Hex.decode,
    signatureToBytes: Sec1Der.encode,
    bytesToSignature: Sec1Der.decode,
  );
}