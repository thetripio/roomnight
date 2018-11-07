
# The signature and verification of Token

The token can be used in two ways:
* You can transfer the Token to the vendor directly, but this will consume a certain amount of Gas.
* The token itself has the nature of natural failure, so we can use the simple signature and verification method to complete the useage of the token.
The owner of the token sign the token with private key and show it to the vendor. The vendor can recover the owner address of the token from the signature, so if the owner of token we got from the blockchain is equal to the owner we recovered from the signature, the token is verified.

## Signature of Token
* You can get the token by ordering on blockchain or get the token from other people.
* Connect multiple tokens to get a string if you got more than one 
* Hash the string by [keccak256](https://en.wikipedia.org/wiki/SHA-3) and you will get the Token Hash.
* Sign the Token Hash by [secp256k1](https://en.bitcoin.it/wiki/Secp256k1) with your private key and you will get the signature.
* Connect the signature with the original tokens string and get the new string.
* Finally, encode the string with a QR code of 15% fault tolerance.

![](https://metaimg.baichanghui.com/METADATA/e700e06c-925e-4041-9c3c-a45d7d6e6654)

## Verification of Token
* The vendor get the QR code from the customer.
* Decode the QR code and get the signature data of customer Toknes.
* Split the signature data: 32 bytes + 32 bytes + 1 byte + x byte. Let we name them as: r,s,v,Token Hash
* Recover the r,s,v data by [secp256k1](https://en.bitcoin.it/wiki/Secp256k1) and get the public key of the tokens owner.
* If the public key begin with hex(0x04), remove the first byte hex(0x04).
* Hash the public key by [keccak256](https://en.wikipedia.org/wiki/SHA-3) and get the last 20 bytes as the owner address of tokens.
* Compare decoded owner of tokens with the owner got from the blockchain. 
![](https://metaimg.baichanghui.com/METADATA/feb2439f-2582-41f0-8c0d-369051579762)