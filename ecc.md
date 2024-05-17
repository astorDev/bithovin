---
type: article
status: playground
---

# Bitcoin Cryptography beyond blockchain.

Section Title: WTF is Assymetric encryption and why should I care?
SectionTitle: WTF is ECDSA and why should I care?

Some smart people are able to get an algebraitic formula for that. I'll attach the formula in case you want to understand it. Anyway, the important thing is that the calculation can be done with algebra, hence can be relatively easily coded.

What would happen if Elliptic curves cryptography will be hacked? Gladly we will still be protected once more.. (public key -> address)

## secp2561k

Here's an example value I get 

Okay, so where does all those numbers came from? Did Satoshi just picked them out of the thin air?

So with all that cryptography I can easily share my bitcoin address: 13WkPuWEYaCTEJwGMW7fYUiYdazF5SR75H on the internet, knowing no one will be able to still my bitcoin. I don't mind if someone send me some, though. 😉

# Structure

- [ ] Introduction
    - [ ] Note that there's a lot of article about chains of blocks. 
    - [ ] Specify that a reader should be already aware of certain properties of blockchain:
        - [ ] Public. Everyone can read any transaction and verify that transaction it was authorized by the sender.
        - [ ] Permissionless. Everyone can receive and spend their money without asking
- [ ] Asymmetric Encryption
    - [ ] Propose a question of how can people know this is you who executed transaction but not be able to execute transaction on your behalf. (without knowing your "password"?)
    - [ ] Explain that the answer is assymetric encryption, in particular digital signatures
    - [ ] Explain what digital signatures with assymetric encryption
    - [ ] Move to the history of assymetric encryption and from that to the RSA and it's popularity.
    - [ ] Create a bridge to Elliptic curves via a history reference.
- [ ] Elliptic Curve Digital Signatures
    - [ ] Show the Bitcoin base equasion and it's graph (https://www.desmos.com/calculator/ktur7ntzhh)
    - [ ] Performed carefully explained multiplication (a.k.a public key calculation) via https://andrea.corbellini.name/ecc/interactive/modk-mul.html
    - [ ] Perform carefully explained signing
        - [ ] Propose signed message as number 8. Mention that a message can be hashed to a number.
        - [ ] 
    - [ ] Perform carefully explained verification from previously explained public key
- [ ] secp256k1
    - [ ] Highlight that our private key is easy to guess and that it's not really suitable for real cryptography
    - [ ] Explain that to make cryptographically suitable we need to have really big number for p (Field) and certain values for generator point
    - [ ] Also note that range on n is [1; p -1]. Illustrate how big it is (show a real generated key as a number).
    - [ ] Propose a question of where those parameters come from?
    - [ ] Explain that they are created by smart people in the certain organizations.
    - [ ] Propose a question that if a goal is security why don't they pick even greater number if it will increase security?
    - [ ] Answer that different algorithms developed so that we can choose a balance between security and computational efforts (speed).
    - [ ] Highlight that the most popular 256 elliptic curve is NIST P-256.
    - [ ] Highlight that NIST reputation were discredited by Snowden documents.
    - [ ] Release the tention noting that satoshi did not pick the algorithm for whetever reason. Instead he picked secp256k1
    - [ ] Give brief info that Canadian company Certicom developed secp256k1
- [ ] Finalize with bridge to next information (about WIF and co)
    - [ ] Propose a question why when we generate bitcoin private key we don't get a number
    - [ ] Tease that this is a topic for the next time