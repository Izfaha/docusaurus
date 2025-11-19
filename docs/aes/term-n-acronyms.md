---
sidebar_title: Definitions
sidebar_position: 2
---

# Section 2 - Definitions

## Terms and Acronyms

1. AES (Advanced Encryption Standard)

AES adalah implementasi khusus dari chiper Rijndael.

2. Block

Bagian data tetap, terkadang di representasikan dengan array bit atau words.
AES block size = 128 bit (16 byte)

3. Block chiper

Mesin yang memproses block data menggunakan key. contohnya AES

4. Byte

Unit data 8-bit.
contoh :

```sh
0x53 -> 01010011
```

5. State

State adalah matrix 4x4 byte, tempat data diproses.

contoh :
```sh
s[4][4]
```

6. Word

Word = 4 byte (32-bit). AES memakai banyak word di key schedule dan AddRoundKey.

7. Round

Round atau lap, transformasi dalam AES, 
    1. SubBytes
    2. ShiftRows
    3. MixColumns
    4. AddRoundKey

AES 128-bit = 10 Round
AES 192-bit = 12 Round
AES 256-bit = 14 Round

8. Round Key

Kunci per-round hasil dari KEYEXPANSION()

9. S-box

Table substitusi nonlinear 256 byte -> 256 byte, terpakai di SubBytes dan KeyExpansion (SubWord)

:::note[Question]
Why does AES need 4x4 state?

Basically, AES is processed by rows and cols so it should be palced in a state in order to more structured.

Technically, AES has a sequece of ways to encrypt and decrypt, such as 
> ShiftRows
> - Menggeser baris
>
>  

::: 