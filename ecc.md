---
type: article
status: playground
---

# Bitcoin Cryptography beyond blockchain.

Section Title: WTF is Assymetric encryption and why should I care?
SectionTitle: WTF is ECDSA and why should I care?

## Ellipic What?

Number n is how many times we do a certain manipulation with the Generator Point.

Math-guys will tell you that the "manipulation" called "addition". That has nothing to do with the addition you did in school. Unfortunately, in math that's common to make confusing naming, that's just something in the nature of mathematician I guess. To make it even funnier

In technical terms that manipulation will be addition to itself. By that terms n is actually a multiplicator of G (since addtion to itself is called multiplication). BUT don't be illusioned by the name. It is **absolutely** not an addition you may expect. If you want to understand what it actually, I'll attach an explanation in the appendix



## secp2561k

Here's an example value I get 

Okay, so where does all those numbers came from? Did Satoshi just picked them out of the thin air?

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
    - [ ] Point out that other important aspect of finite field is "Finite field", which means coordinates satisfying the equation in which both X and Y are non-negative integers less then the finite field "size"
    - [ ] Move to https://andrea.corbellini.name/ecc/interactive/modk-mul.html to represent the finite field
    - [ ] Suggest adjusting a and b to 0 and 7 as in bitcoin equation, noting that we get completely different set of points.
    - [ ] Propose a question of what is P and is it a private key
    - [ ] Answer that this is our starting point and that it's a single point from where we start the magic and all
    - [ ] Propose a question on what is n.
    - [ ] Answer the question with the fact is that it's number of times we "manipulate" P
    - [ ] Propose moving n from 0 (ensuring Q match P) up to 8 and noting how random the move of Q seems.
    - [ ] Propose setting n (d) to 8 + 79 = 87 (number of points a.k.a order of the curve) - note that it got exactly same result as 8. Tease to more on that later.
    - [ ] Announce that n (or usually called d) is the private key.
    - [ ] Summarize then if someone sign a message with private key (8) anyone with public key (57; 30) will be able to verify it.
- [ ] secp256k1
    - [ ] Highlight that our private key is easy to guess and that it's not really suitable for real cryptography
    - [ ] Explain that to make cryptographically suitable we need to have really big number for p (Field) and certain values for generator point
    - [ ] Remind the case of using 87 public key equals to 9. Explain that with a cyclic nature of the curve. Point out that this means the range of private key is in range of [1; n - 1].
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