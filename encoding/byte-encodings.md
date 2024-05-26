---
type: article
status: draft
---

## Structure

- [ ] Introduction: Starting from the 101
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