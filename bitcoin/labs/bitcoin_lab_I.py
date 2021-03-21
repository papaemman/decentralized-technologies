####################################################
#                                                  #
# Python scripting (bitcoin lab I - python part)   #
#                                                  #
####################################################

# // DOCUMENTATION //
# python bitcoin-utils:  https://github.com/karask/python-bitcoin-utils

# Import modules
from bitcoinutils.setup import setup
from bitcoinutils.keys import PrivateKey

# 1. Setup the network.You can use either the mainnet or the testnet.
setup('testnet')

# 2. Create a private key. Do you all have the same private key?
#     private keys are from definition random numbers
priv = PrivateKey(secret_exponent=1)

# 3. What is the WIF (wallet import format) format (uncompressed) of the private key?
print("\nPrivate key WIF:", priv.to_wif(compressed=False))

# 4. What is the WIF format (compressed) of the private key?
print("\nPrivate key WIF:", priv.to_wif(compressed=True))

# 5. What is the corresponding public key? In uncompressed and compressed forms.
#    public keys are generated from private keys using ECDSA cryptographic function
pub = priv.get_public_key()

print("Public key:", pub.to_hex(compressed=False))
print("Public key:", pub.to_hex(compressed=True))

# 6. What is the corresponding address? Get address from public key
address = pub.get_address()
print("Address:", address.to_string())

# Q: What does the address start with? Why?
# The address starts with m (Base58 result prefix) because it is a Bitcoin testnet address

# 7. What is the hash160 representation of the address?
print("Hash160:", address.to_hash160())

# 8. What is the scriptPubKey (locking script) of the address?
print("scriptPubKey of the address:", address.to_script_pub_key().to_hex())

# 9. Create a segwit (bech32) address using the same private/public keys:
# Segwit stands for Segregated Witness (separated).
# In short, Segwit separates the transaction signatures so that the transaction uses less data on the Bitcoin network.
address_segwit = pub.get_segwit_address()

# 10. What does the address start with? Why?
print("Address segwit:", address_segwit.to_string())

# 11. What is the hash160 representation of the address?
print("Hash160:", address_segwit.to_hash())
