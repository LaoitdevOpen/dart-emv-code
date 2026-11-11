## Unreleased

+ require Dart SDK `^3.8.0`
+ fix `postalCode` being serialised as `Instance of 'TLVModel'` in `toJson`
+ fix `toJson` crash on merchant account information without payment network items
+ fix MPM lengths: count characters, and reject values longer than 99
+ fix `verifyEmvQr` and `tlvToString` on incomplete input
+ `setTransactionCurrency` now reports the right field name in its error
+ add unit tests for MPM, CPM, CRC16, models and errors
+ document field rules, error handling and decode/verify results in the README


## 1.0.5

+ fix issue [invalid length value #3](https://github.com/LaoitdevOpen/dart-emv-code/pull/3)
+ update document
+ update example
+ update test
+ refactor code


## 1.0.4

+ Fix decode and crc QR codes including multi-byte chars like Japanese or chinese.

## 1.0.3

+ support cpm
+ add verifyQRcode function for check qrcode check sum

## 1.0.2
update license
## 1.0.1
update to using dart sdk and docs

## 1.0.0
decode and generate emv-mpm qrcode
