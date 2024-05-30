---
type: article
status: draft
---

## Binary to text encodings: Hex, Base64, Base58

![-Would you like some #ffa500? -Yes, I love oranges!](thumbnail.png)

If computers talk in 1s and 0s how do they exchange something meaningful? That was the question  I tried to answer in the [previous article]() about text encoding. Based on the information from that article let's formulate a list of steps we need to create an encoding:

1. Decide **how** to create the **thing** we want. 

Sounds simple right. But there's a catch! The creation process _must_ create our "thing" from numerical values (our input). For example for text we one by one read character codes (which are numerical), find they respective characters and output them.

2. Decide **how** to put the input values in bits so that a reader can understand where each input value is.

There's a few solutions for how to do this with text, which I described in the [text encodings article](). Long story short, in ASCII you always read exactly 7 bits, in UTF-8 you read first bits to understand how many to read after.

3. **Optional**. Decide how to represent the bits so that __human__ could share them.

And this step is the main topic we are going to discuss. Although, this is somewhat useless for text (since humana are good at the text itself) it becomes useful when we want to exchange something more fancy, like color, for example.

## How the hex do I pass a color?

Of course, we can use the good old words. However, understanding of color words is very subjective and contextual. What if we want to pass an exact color? This is where RGB color model steps in. This is "how to create the thing we want" (which is color in this case):

1. Prepares 3 paint bins each 255 ~cm~ high.
2. Prepares an absolutely black canvas.
3. Put red paint in the first bin. (R)
4. Put green paint in the second bin. (G)
5. Put blue paint in the third bin. (B)
6. Mix the paints from each bin.
7. Put the mix on the black canvas.

Essentially the only thing we **choose** is how many paint to put in each bin. How do I get the white from each? Fill every bin to it's fullest a.k.a `rgb(255, 255, 255)`. What about black? Put nothing in the bin a.k.a `rgb(0, 0, 0)`. 

Note that we __must__ have a black canvas, so it's not an input value. That leaves us with just 3 values: how many red paint we put, how many green paint we put, how many blue paint we put. Note that each value is numerical and ranges from 0 to 255, which is 256 possible values. 

Let's move to the next question of an encoding: **How** to put the input values in bits so that a reader can understand where each input value is? Since each input value has the same "capacity" the solution is very simple:

> To represent a 256 possible values we need exactly 8 bit (2 ^ 8 = 256)

1. 1st to 8th bit for amount of red paint (R)
2. 9th to 16th bit for amount of green paint (G)
3. 17th to 24th bit for amount fo blue paint (B)

Great! Now, to the last step - let human exchange bits for colors. Note, that 256 = 16 * 16. Okay, how is it relevant? Well, imagine if we have 16 digits instead of our good old 10 (0, 1, 2, 3, 4, 5, 6, 7, 8, 9). Then we could represent amount of each paint by just 2 symbols, which would be cool, isn't it? Turns out a "system" with 16 digits exists and it's called **hex**, short for hexadecimal. It just uses a for 10 in decimal, b for 11, c - 12, c - 13, e - 14, f - 15 (giving total of 16 symbols).

Okay, what do we do with it? Let's encode ochre, using [this tool](https://whatthehex.app/):

![Ochre step by step](finding-ochre-code.gif)

Here's how it goes:

1. We'll start from `Yellow`. Which as you may know mix of red and green. So full for red (ff), full for green (ff) and none for blue (00)
2. Of course ochre is not that bright color. Let's roll down colors down, so `cc` for red, `cc` for green and still nothing for blue `00`
3. Ochre is also rather redish then greenish. Let's decrease green to `77`.
4. Okay, a deep color probably wouldn't completely ignore a primary color. So, as the last touch, let's put just a little of blue: `22`.

## Passing more: Base64



## Who said Bitcoin?


## Recap

```
+-----------+-------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| Encoding  | Summary                                                                 | Use-Cases                                                                                 |
+-----------+-------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| Hex       | Represents binary data as hexadecimal (base-16) digits. Each byte is    | - Debugging and analyzing binary data                                                     |
|           | converted to two hexadecimal characters.                                | - Displaying binary data in a human-readable format                                       |
|           |                                                                         | - Cryptographic operations (e.g., checksums, hashes)                                      |
+-----------+-------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| Base64    | Encodes binary data into an ASCII string format using 64 characters (A-Z,| - Encoding binary data for XML and JSON                                                   |
|           | a-z, 0-9, +, /).                                                        | - Embedding images or files in HTML or CSS                                                 |
|           |                                                                         | - Data transmission over media that are designed to handle text                           |
+-----------+-------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| Base58    | Encodes binary data into an alphanumeric string using 58 characters,     | - Bitcoin and other cryptocurrency addresses                                               |
|           | excluding similar-looking ones (e.g., 0, O, I, l).                      | - URL shortening and safe transmission                                                     |
|           |                                                                         | - User-friendly representations of binary data                                             |
+-----------+-------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
```


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
    - [ ] Propose the question if the hex is not that different from the binary can we get hex from a file
    - [ ] Answer that we can and convert `small-ferret.jpeg` into hex, using https://emn178.github.io/online-tools/hex_encode_file.html. 
    - [ ] Count chars: 26588 and note that it's a very long string. Propose a question of whether can we use more symbols and move from 16-radix to more
    - [ ] Answer that we can and introduce Base64 (with it's character set)
    - [ ] Convert small ferret into base64 using https://emn178.github.io/online-tools/base64_encode_file.html. Count characters: 17728
    - [ ] Challenge moving back from base64 to image. Prove it using https://diewland.github.io/base64toImage/
- [ ] Base58
    - [ ] Reference Bitcoin article, highlighting a private key is a big number
    - [ ] Propose using a smaller number, e.g. 3885384 (that number is specially used since it uses base58 removed symbols)
    - [ ] Convert it to binary https://math.tools/calculator/base/10-2, then to base64 https://math.tools/calculator/base/2-64
        - Note that it can also be done faster via https://math.tools/calculator/base/10-64
    - [ ] Highlight the problem with similarly looking chars in the base64 (O0lI)
    - [ ] Highlight that this is the problem that Base58 solves + mention there's also Version Byte and Checksum, but they are out of the scope of the article.
    - [ ] Convert the same number to base58 (get not conflicting LuzP)
- [ ] Final
    - [ ] Recap with the list of encodings accompanied by a short description and use cases.

# Tools And Calculations


`Decimal to Hex`:

https://www.binaryhexconverter.com/decimal-to-hex-converter: 3885384 -> 3B4948
https://simplewebtool.firebaseapp.com/converters/number/decimaltohex/decimaltohex.html: 3885384 -> 3B4948
https://www.rapidtables.com/convert/number/decimal-to-hex.html: 3885384 -> 3B4948

`Decimal to binary`:

https://math.tools/calculator/base/10-2: 3885384 -> 1110110100100101001000

`Hex to binary`:

https://www.binaryhexconverter.com/hex-to-binary-converter: 3B4948 -> 1110110100100101001000

`Binary to base64`

https://math.tools/calculator/base/2-64: 1110110100100101001000 -> O0lI
https://www.goodconverters.com/binary-to-base64: 1110110100100101001000 -> O0lI

`Hex to base64`:

https://emn178.github.io/online-tools/base64_encode.html: 3B4948 -> O0lI
https://cryptii.com/pipes/hex-to-base64: 3b4948 -> O0lI
https://www.atatus.com/tools/hex-to-base64: 3b4948 -> O0lI

`Hex to base58`

https://emn178.github.io/online-tools/base58_encode.html: 3b4948 -> LuzP

`Decimal to base58`:

https://www.dcode.fr/base-58-cipher: 3885384 -> LuzP
