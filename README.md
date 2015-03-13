# sco (String COdec)

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

Encode and Decode using pipes:

    $ sco -e base64 "hello world" | sco -d base64
    $ hello world

## Options

-h, --help

* output usage information

-v, --version

* output the version number

-e, --encode [algo]

* encode input string by specified algorithm

-d, --decode [algo]

* decode input string by specified algorithm

## Supported specifications

### encoder

|algorithm|input|output|
|:--|:--|:--|
|hex|string|hex string|
|ascii|hex string|string|
|base64|string|base64|
|ascii85 (base85)|string|ascii85|
|base91|hex string|string|
|rot5/rot13/rot18/rot47|string|string|
|rev (reverse string)|string|string|
|z85|string|z85|
|rfc1924 (base85 IPv6)|IPv6 address|base85 IPv6 string|
|crc1/crc8/crc16<br>crc24/crc32|string|crc checksum|
|adler32|string|adler32|
|url (url encoding)|string|url encode|
|unixtime|date string|unix timestamp|
|md4|string|md4|
|md5|string|md5|
|sha|string|sha|
|sha1|string|sha1|
|sha224|string|sha224|
|sha256|string|sha256|
|sha384|string|sha384|
|sha512|string|sha512|
|rmd160|string|rmd160|
|whirlpool|string|whirlpool|

### decoder

|algorithm|input|output|
|:--|:--|:--|
|hex|hex string|string|
|ascii|string|hex string|
|base64|base64|string|
|ascii85|ascii85|string|
|base91|base91|hex string|
|rot5/rot13/rot18/rot47|string|string|
|rev|string|string|
|z85|z85|string|
|rfc1924|base85 IPv6 string|IPv6 address|
|url|url encode|string|
|unixtime|unix timestamp|date string|
|md5|md5|string|

### Input hex string

Accept hex string prefixed with '0x' or separated by a colon (:)

    codec.decoder('616263','hex');
    // => abc
    codec.decoder('0x616263','hex');
    // => abc
    codec.decoder('61:62:63','hex');
    // => abc
    codec.decoder('0x61:62:63','hex');
    // => abc

[string-codec]: https://github.com/knjcode/string-codec
[npm-url]: https://npmjs.org/package/sco
[npm-image]: https://badge.fury.io/js/sco.svg
[travis-url]: https://travis-ci.org/knjcode/sco
[travis-image]: https://travis-ci.org/knjcode/sco.svg?branch=master
