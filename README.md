# sco (String COdec)

[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url]

Command line interface of [string-codec]

## Installation

via [npm (node package manager)](http://github.com/npm/npm)

    $ npm install -g sco

## Usage Example

Encode to Base64:

    $ sco -e base64 hello
    $ aGVsbG8=

Decode from Base64:

    $ sco -d base64 aGVsbG8=
    $ hello

Encode to hex:

    $ sco -e hex abc
    $ 616263

Decode from hex:

    $ sco -d hex 616263
    $ abc
    $ sco -d hex 0x616263
    $ abc

Encode and Decode using pipes:

    $ echo "hello world" | sco -e base64 | sco -d base64
    $ hello world

## Options

__-h, --help__

output usage information

__-v, --version__

output the version number

__-e [algo], --encode [algo]__

encode input with specified algorithm

__-d [algo], --decode [algo]__

decode input with specified algorithm

## Supported specifications

For further details, see [knjcode/string-codec](https://github.com/knjcode/string-codec)

### encoder

hex, ascii, base64, base85 (z85), ascii85, base91, rot5/rot13/rot18/rot47,  
rev (reverse string), crc1/crc8/crc16/crc24/crc32, adler32, url (url encoding),  
unixtime, lower, upper, md4, md5, sha, sha1, sha224, sha256, sha384, sha512,  
rmd160, whirlpool

### decoder

hex, ascii, base64, base85 (z85), ascii85, base91,  
rot5/rot13/rot18/rot47, rev, url, unixtime, md5

## Running tests

    $ git clone https://github.com/knjcode/sco.git
    $ cd sco
    $ npm install
    $ npm test

[string-codec]: https://github.com/knjcode/string-codec
[npm-url]: https://npmjs.org/package/sco
[npm-image]: https://badge.fury.io/js/sco.svg
[travis-url]: https://travis-ci.org/knjcode/sco
[travis-image]: https://travis-ci.org/knjcode/sco.svg?branch=master
