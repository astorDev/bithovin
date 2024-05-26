import 'dart:convert';

import 'package:bithovin/bithovin.dart';
import 'package:test/test.dart';

import 'printed_extensions.dart';

void main() {
  test('sign and verify signature using generated keys', () {
    var data = utf8.encode('Hello from dart secp256k1!');
    var privateKey = Secp256k1PrivateKey.generateNew().printed(name: "privateKey");
    var signature = privateKey.sign(data).printed(name: "signature");
    var publicKey = privateKey.getPublicKey().printed(name: "publicKey");
    var verified = publicKey.verify(data, signature).printed(name: "verified");
    
    expect(verified, true);
  });

  test('verify from outside', () {
    var data = utf8.encode('Hello, secp256k1 with C#');
    var signature = ECSignature(
      BigInt.parse("37829834893185790287574494787777878239722765556565340353647073721545626782852"),
      BigInt.parse("37718798264420829667432443467910095951370051737768320660808821983783470666371")
    );

    var publicKey = Secp256k1PublicKey.fromRawBigIntegers(
      BigInt.parse("102912990918854309762114792265177763359550703853273295079676447005108089998417"),
      BigInt.parse("95647718952404373085123510831705086175988003528985051513075979776598068537431")
    );

    var verified = publicKey.verify(data, signature).printed(name: "verified");
    
    expect(verified, true);
  });

  test('verify invalid from outside', () {
    var data = utf8.encode('Hello, secp256k1 with C#');
    var signature = ECSignature(
      BigInt.parse("37829834893185790287574494787777878239722765556565340353647073721545626782851"), // invalidly ends with 1
      BigInt.parse("37718798264420829667432443467910095951370051737768320660808821983783470666371")
    );

    var publicKey = Secp256k1PublicKey.fromRawBigIntegers(
      BigInt.parse("102912990918854309762114792265177763359550703853273295079676447005108089998417"),
      BigInt.parse("95647718952404373085123510831705086175988003528985051513075979776598068537431")
    );

    var verified = publicKey.verify(data, signature).printed(name: "verified");
    
    expect(verified, false);
  });

  test('export and import public key', () {
    var publicKey = Secp256k1PublicKey.fromRawBigIntegers(
      BigInt.parse("102912990918854309762114792265177763359550703853273295079676447005108089998417"),
      BigInt.parse("95647718952404373085123510831705086175988003528985051513075979776598068537431")
    );

    var publicKeyHex = publicKey.toSecCompressed().toHex().printed(name: "hex");
    var imported = publicKeyHex.toSecCompressed().toSecp256k1PublicKey().printed(name: "imported");

    expect(imported, publicKey);
  });

  test('export and import signature', () {
    var exported = ECSignature(
      BigInt.parse("37829834893185790287574494787777878239722765556565340353647073721545626782852"),
      BigInt.parse("37718798264420829667432443467910095951370051737768320660808821983783470666371")
    );

    var signatureHex = exported.toDer().toHex().printed(name: "signature hex");
    var imported = signatureHex.toDer().toECSignature().printed(name: "imported signature");

    expect(exported, imported);
  });
}