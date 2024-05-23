# How to talk in 1s and 0s?

## Creating an encoding

`Initial Encoding table`: 

| Char | Code In Decimal | Code in binary |
|------|-----------------|----------------|
| A    | 0               | 0              |   
| B    | 1               | 1              |
| C    | 2               | 10             |
| D    | 3               | 11             |
| E    | 4               | 100            |
| F    | 5               | 101            |
| G    | 6               | 110            |
| H    | 7               | 111            |

`H A C -> 111 0 10`

`111010`

`11 10 1 0 -> D C B A`

`Redefined Encoding Table`

| Char | Code In Decimal | Code in binary |
|------|-----------------|----------------|
| A    | 0               | 000            |   
| B    | 1               | 001            |
| C    | 2               | 010            |
| D    | 3               | 011            |
| E    | 4               | 100            |
| F    | 5               | 101            |
| G    | 6               | 110            |
| H    | 7               | 111            |

`H A C -> 111 000 010`

`111000010`

`111 000 010 -> HAC`

This encoding logic is the exactly the logic used in the encoding dominant from the mid-1960s to the early 1990s, called ASCII. The II in the abbreviation stands for what we just did: Information Interchange (although I probably wouldn't come up with the word "Interchange").

## Introducing clever rules. UTF-8

## What the hex?

## Who said bitcoin?

## TLDR

# Proposed Structure

- [ ] Introduction
    - [ ] Mention the thesis of computer talking in 1s and 0s
    - [ ] Propose asking how would we pass a message like "Hello" (pick something illustrative for padding problem). 
- [ ] ASCII
    - [ ] Assign code to few letters (use real ASCII codes).
    - [ ] Encode the message (naive way).
    - [ ] Decode the message incorrectly (highlighting the problem).
    - [ ] Propose padding
        - [ ] Use 7 bits. Highlight that it will give 128 symbols.
    - [ ] Encode and decode correctly
    - [ ] Note that we just created/reproduced ASCII.
- [ ] UTF-8
    - [ ] Highlight that assumption of 128 symbols being enough turns out to be false. (specifically because of other languages)
    - [ ] Highlight that if we use fixed size encoding it will probably be too redundant
    - [ ] Explain what UTF did instead
    - [ ] Add non-ASCII character to the encoding
    - [ ] Decode the message.
- [ ] Hex
    - [ ] Highlight that if you study UTF-8 you may find the odd "codes".
    - [ ] Propose a question of why didn't they just use 0s and 1s.
    - [ ] Propose an answer that math and computer guys (and back there they were the same) are ~paranodically~ afraid of long symbols
    - [ ] Joke about the fact that even decimal notation wasn't short enough for the guys.
    - [ ] Joke that fortunately they stopped at 16 symbols.
        - [ ] Mention that again ironically they don't like write much, but sometimes write "0x" to mention talking in hex. (Which basically means "The thing I'm saying next is HEX").
    - [ ] Map character from UTF-8 (with length bytes) to the HEX representation.
    - [ ] Note that irony in the fact that in this case we used "text" to represent data/"bits"
- [ ] Base58
    - [ ] Note that although that's somewhat comical it doesn't stop there.
    - [ ] Reference the bitcoin article pointing the "conclusion" that private key is just a very a big number.
    - [ ] Point out that it just doesn't fit in a view
    - [ ] Highlight that HEX doesn't help much there
    - [ ] Highlight that hex is radix-16 and that's not surpisingly we just increase radix and popular radix 64 (also called Base64).
    - [ ] Highlight the problem with
    - [ ] Take a private key number from bitcoin article and convert to base58 using https://www.dcode.fr/base-58-cipher
    - [ ] Warn that the process of creating bitcoin key is slightly more complicated so you don't get actual private key by just converting to base58.
- [ ] Recap
    - [ ] Here's how you talk in bytes: You map 7 0s and 1s to our "real" symbols and send chuncks of 7 bits instead of the actual symbols
    - [ ] If you want to get fancy before sending the actual "code" send information about how long the code will be.
    - [ ] But if you want to talk in 0s and 1s but more like a human use encode map sequences of 0s and 1s to sixteen symbols - that way you talk hex
    - [ ] Or if you want to do crypto encode sequences of 0s and 1s to 58 symbols
    - [ ] "So now for the AI takeover you know the basics of computers "language" 😄."