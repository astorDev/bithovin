---
status: playground
---

# Random phrases

WTF is Assymetric encryption and why should I care?

Some smart people are able to get an algebraitic formula for that. I'll attach the formula in case you want to understand it. Anyway, the important thing is that the calculation can be done with algebra, hence can be relatively easily coded.

What would happen if Elliptic curves cryptography will be hacked? Gladly we will still be protected once more.. (public key -> address)

So with all that cryptography I can easily share my bitcoin address: 13WkPuWEYaCTEJwGMW7fYUiYdazF5SR75H on the internet, knowing no one will be able to still my bitcoin. I don't mind if someone send me some, though. 😉

# Structure

- Introduction
    - Note that there's a lot of article about chains of blocks. Specify that a reader should be already aware that each blockchain transaction is public.
- Assymetric Encryption
    - Propose a question of how can people know this is you who executed transaction but not be able to execute transaction on your behalf.
    - Answer to that the answer is assymetric encryption. Provide an explanation, trying to do it in simple terms.
    - Move to the history of assymetric encryption and from that to the RSA and it's popularity.
    - Point to problems with RSA (long keys)
        - Optionally scare with the fact that bitcoin key length is smaller then the hacked 768 symbol RSA
    - Create a bridge to Elliptic curves via a history reference.
- Elliptic Curves
    - Explain how 
    - Explain that the private key is the number of times we add the point to itself.
    - Note how big of a numbers we operate in this context.
- Picking a Curve
    - Explain curve constants.
    - Talk about NIST and that they were compromised by Snowden documents
    - Note that Satoshi picked non-nist curve.
- Compressed Keys, Base58 and Addresses (Checksums and what else we have)
- Coda: Secure about sharing a bitcoin address.

# References

[Elliptic curves](https://habr.com/ru/articles/188958/)
[Old Forum discussing the curve choice](https://bitcointalk.org/index.php?topic=2699.20)
[Bitcoin and NIST curves are not considered safe](https://safecurves.cr.yp.to/)
[Elliptic Curve Cryptography Overview](https://www.youtube.com/watch?v=dCvB-mhkT0w)