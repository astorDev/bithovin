# Structure

- [ ] Point to the previous article and that in it we've generated a bitcoin private and public key
- [ ] Highlight the dissonance in look between what we saw in previous point and standard bitcoin private key and address
- [ ] Explain WIF and it's benefits over a number
- [ ] Remind that public key is not a single number, but a coordinates (two numbers). Propose a question how do we decode that?
- [ ] Highlight that PEM is a popular decision and then highlight it's ridiculous size.
- [ ] Explain uncompressed keys, highlight how shorter are they and note that they are supported in bitcoin and was the only thing suported before 0.6.0
- [ ] Explain clever math behind compressed key
- [ ] Highlight that public key is not the same as address and how it increases security
- [ ] Explain steps of converting public key to address and their importance
- [ ] Finish by highlighting that with all the cryptography one can easily share his address to the internet share mine and joke that you would be happy receiving.

# Possible Topics 

- WIF, probably checksums
- PEM as an example of popular, but redundant encoding
- Base58
- Compressed Key
- Addresses and double hashing, probably checksums

# Parts Prototypes

So with all that cryptography I can easily share my bitcoin address: 13WkPuWEYaCTEJwGMW7fYUiYdazF5SR75H on the internet, knowing no one will be able to still my bitcoin. I don't mind if someone send me some, though. 😉
