import 'dart:convert';

import 'package:bithovin/bithovin.dart';
import 'package:test/test.dart';

import 'printed_extensions.dart';

void main() {
  var dataFromCSharp = utf8.encode('Hello, secp256k1 with C#');
  var signatureFromCSharp = ECSignature(
    BigInt.parse("36019585936424807702067775695488245732523976579610140319465179840471756082127"),
    BigInt.parse("41226921866506014482256410953376195772128906272442926381814048747893010526424")
  );

  var publicKeyFromCsharp = Secp256k1PublicKey.fromRawBigIntegers(
    BigInt.parse("8795278746697027836736556376014590967812476665167364650216503281309786723044"),
    BigInt.parse("107748829798493369459082063025509742122394492767277437517191482000758999454504")
  );

  test('sign and verify signature using generated keys', () {
    var data = utf8.encode('Hello from dart secp256k1!');
    var privateKey = Secp256k1PrivateKey.generateNew().printed(name: "privateKey");
    var signature = privateKey.sign(data).printed(name: "signature");
    var publicKey = privateKey.getPublicKey().printed(name: "publicKey");
    var verified = publicKey.verify(data, signature).printed(name: "verified");
    
    expect(verified, true);
  });

  test('verify from C#', () {
    var verified = publicKeyFromCsharp.verify(dataFromCSharp, signatureFromCSharp).printed(name: "verified");
    
    expect(verified, true);
  });

  test('export and import public key', () {
    var exported = publicKeyFromCsharp.Q.getEncoded(true).toHex().printed(name: "exported");
    var imported = Secp256k1.curve.decodePoint(exported.toBytes()).printed(name: "imported");

    expect(imported, publicKeyFromCsharp);
  });

  test('export and import signature', () {
    var exported = signatureFromCSharp.toSec1Der().hex.printed(name: "exported");
    var imported = exported.toSec1Der().toECSignature().printed(name: "imported");

    expect(signatureFromCSharp, imported);
  });

  test('import and verify from javascript', () {
    var message = utf8.encode('{ \'hey\' : \'you\' }');
    var importedPublicKey = '04df394d77ee3b401e8ebe666bb5bec51aa3f714a03977c82b61879265a17ea83b6fcecbbcc200341a0e55b9ffac5ee71ea521e47bbbfe8d9a073f0691b9161fba';
    var importedSignature = '304402206db1e59a246c86c8c6f78101561362e98c3fa821653c72b69c8c6fd4efcf428502203f52f3ad842ec29c1daba409f9375e615d6d189f924ac51dd48b83649f29a7e2';

    var publicKeyPoint = Secp256k1.curve.decodePoint(Hex(importedPublicKey).toBytes()).printed(name: "publicKey");
    var signature = Hex(importedSignature).toSec1Der().toECSignature().printed(name: "signature");

    var publicKey = Secp256k1PublicKey.fromPoint(publicKeyPoint!);

    var verified = publicKey.verify(message, signature).printed(name: "verified");
    expect(verified, true);
  });
}