# Bithovin

## Secp256k1

```dart
var data = utf8.encode('Hello from dart secp256k1!');
var privateKey = Secp256k1PrivateKey.generateNew().printed(name: "privateKey");
var signature = privateKey.sign(data).printed(name: "signature");
var publicKey = privateKey.getPublicKey().printed(name: "publicKey");
var verified = publicKey.verify(data, signature).printed(name: "verified");
    
expect(verified, true);
```
