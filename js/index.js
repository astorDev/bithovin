const EC = require('elliptic').ec;
const sha256 = require('crypto').createHash('sha256');
const secp256k1 = new EC('secp256k1');

const message = "{ 'hey' : 'you' }";
const messageHash = sha256.update(message).digest('hex');

const key = secp256k1.genKeyPair();

const signature = key.sign(messageHash);

const derSign = signature.toDER('hex');

var verified = key.verify(messageHash, derSign);

console.log("Message:", message);
console.log("Message Hash:", messageHash);
console.log("Signature:", derSign);
console.log("Public Key:", key.getPublic('hex'));
console.log("Verified:", verified);