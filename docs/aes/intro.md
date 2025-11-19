---
sidebar_title: Intoduction
sidebar_position: 1
---

# Section 1 - Introduction to AES

## What is the diff between block and block chiper?

what is block? a sequence of bits of a given length.

Block adalah sekumpulan bit yang memiliki ukuran tetap.

contoh :

- AES memakai 128-bit (16 bytes) block atau state 4x4

| 8-bit | 8-bit | 8-bit | 8-bit |\
| 8-bit | 8-bit | 8-bit | 8-bit |\
| 8-bit | 8-bit | 8-bit | 8-bit |\
| 8-bit | 8-bit | 8-bit | 8-bit |

8-bit x 16 = 128-bit (16 bytes) block atau state 4x4

what is block chiper? a family of permutations of block that is parameterized by a sequence of bits called the key.

Gampangnya block chiper adalah yang mengelola potongan bit tersebut atau algoritma yang _mengubah (mengacak) block tersebut secara terstruktur_ (**permutations**) menggunakan key.

## Why does AES use 128-bit block?

1. Security

Block yang terlalu kecil akan mudah diserang dengan teknik seperti birthday attack, pattern repetition, codebook attack. Karena itulah block 128-bit digunakan, hal tersebut akan memberikan pattern yang kompleksitas pola block chiper sehingga aman untuk digunakan.

2. Efisiensi

Alasan lainya adalah efisiensi, karena AES memiliki goals supaya cepat di hardware dan software, dan bisa di implementasikan di banyak perangkat (dari CPU besar ataupun smartcard kecil).

Block 128-bit adalah ukuran optimal, tidak terlalu kecil dan tidak mudah untuk dibobol, juga tidak terlalu besar sehingga tidak boros CPU/memory.