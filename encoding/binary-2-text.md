---
type: article
status: draft
---

## Binary to text: Hex, Base64, Base58

## Who said Bitcoin?

# Structure

- [ ] Introduction: Starting from the 101
    - [ ] Reference 101 article noting that we talked about how computers convert text to binary
    - [ ] Highlight, that computers exchange much more than text
    - [ ] Propose learning about how computers see images
- [ ] Hex and colors
    - [ ] Note that the reader may heard about RGB and give its quick overview.
    - [ ] Note that each number is 16 * 16
    - [ ] Tease that it will be cool if we have more than 10 digits (especially 16).
    - [ ] Explain that we have such a system and it is hex.
    - [ ] Try to get ochre with hex: dd8833. Check it out at https://whatthehex.app/
    - [ ] Play around with white (ffffff), grey, etc.
    - [ ] Convert hex to binary ("Told you it's 0s and 1s after all").
    - [ ] Convert binary to hex - Note that hex and binary are essentially different representations of the same thing
- [ ] Base64
    - [ ] Propose the question if hex is not that different from the binary can we get hex from a file
    - [ ] Answer that we can and convert `small-ferret.jpeg` into hex, using https://emn178.github.io/online-tools/hex_encode_file.html. 
    - [ ] Count chars: 26588 and note that it's a very long string. Propose a question of whether can we use more symbols and move from 16-radix to more
    - [ ] Answer that we can and introduce Base64.
    - [ ] Convert small ferret into base64 using https://emn178.github.io/online-tools/base64_encode_file.html. Count characters: 17728
    - [ ] Challenge moving back from base64 to image. Prove it using https://diewland.github.io/base64toImage/
- [ ] Base58
    - [ ] Reference Bitcoin article, highlighting private key being a big number
    - [ ] ...
