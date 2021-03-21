#######################################
#                                     #
# Python scripting (bitcoin lab II)   #
#                                     #
#######################################

# // DOCUMENTATION //
# python bitcoin-utils:  https://github.com/karask/python-bitcoin-utils

# Import modules
from decimal import Decimal

# IMport from bitcoin utils
from bitcoinutils.setup import setup
from bitcoinutils.keys import PrivateKey, P2pkhAddress, P2shAddress
from bitcoinutils.transactions import Sequence, TYPE_RELATIVE_TIMELOCK, Transaction, TxInput, TxOutput
from bitcoinutils.script import Script
from bitcoinutils.proxy import NodeProxy

# Get help for a class / method / function from bitcoinutils module using help() or ctrl + click
help(PrivateKey)
help(Script)


# // LAB: Relative Timelock Example //

# 0. What is the type of network you working on? (mainnet / testnet)
#    Always remember to setup the network before anything else.
setup('testnet')


# 1. Create a new private key
#    Use secret_exponent parameter to get a non random private key
priv = PrivateKey(secret_exponent=1)
priv.to_wif()
priv.to_bytes()  # 32 bytes = 32 * 8 bits = 256 bits

# 2a. Get the corresponding public Key
pub = priv.get_public_key()
pub.to_hex()
pub.to_hash160()
pub.to_bytes()

# 2b. Get the address that corresponds to that public key.
#     The string representation of this address starts with m on n, because it is a Bitcoin testnet address
address = priv.get_public_key().get_address()
address.to_string()
address.to_hash160()

address._is_address_valid(address.to_string())   # True
address._is_address_valid(address.to_hash160())  # False


# 3. Create an input sequence for a relative timelock of 10 blocks.
#    Notes: Locktime defines the earliest time that a transaction can be added to the blockchain.
#    If locktime is < 500.000.000 it is interpreted as a block height, else it is interpreted as UNIX Epoch timestamp
help(Sequence)

relative_blocks = 10
seq = Sequence(seq_type=TYPE_RELATIVE_TIMELOCK, value=relative_blocks)

seq.is_type_block  # True
seq.value          # 10

# Note: I will use regtest node (from scratch) so the relative_blocks restriction can be tested.

# 4. What is the redeem script? Create it.
#  Redeem script is a special type of script.
#  - The hash of the redeem script used to lock the outputs of a transaction.
#  - Then the redeem script used to unlock these UTXOs.

redeem_script = Script([seq.for_script(), 'OP_CHECKSEQUENCEVERIFY', 'OP_DROP', 'OP_DUP', 'OP_HASH160', address.to_hash160(), 'OP_EQUALVERIFY', 'OP_CHECKSIG'])

# Script code explanation:
# - add on top of the stack the relative_blocks number (10) and the check if this sequence have been verified, ie the locktime have been pass. (T/F)
# - drop the top element of the stack
# - duplicate the and get its hash
# - also get the address hash and check if are equal
# - then check if the signature is valid

# 5. What is the P2SH address for that script? (Get the hash from the redeem_script)
help(P2shAddress)
p2sh_addr = P2shAddress.from_script(redeem_script)
print(p2sh_addr.to_string())


# 6. Send some bitcoin to that P2SH address.

# / Important Notes /
# Until this point no interaction with bitcoin network have been made!
# At this time I have to start a regtest node and then I have to proceed with bitcoin transfer,
# either using cli (bitcoin-cli), either programmatically through python.

# Also note, that I need to already have an address and sufficient funds in order to send btc
# to this address or else I would get an error.

# To create a new address and get enough btc, I can execute the following commands:
# $ bitcoin-cli getnewaddress "temp"
# $ bitcoin-cli generatetoaddress 101 "2N3UMz868UzEKMupLuuhd8ecPGeUKqNKgfS"
# $ bitcoin-cli getbalance


# - 1. Start regtest node

# - 2. Send btc to the newly created address, using cli and keep txid.
#      I have to use the string represantation of address to send the funds (not the hash_160 representation)

# $ bitcoin-cli sendtoaddress mrCDrCybB6J1vRfbwM5hemdJz73FwDBC8r 1
p2sh_addr.to_string()

# txid: 44812f95c6b5f2b6eb0281df6dc937e66a118ca900fe9a8e2aa4592ac8f9e251


# - 3. OR send btc to my address programmatically using python

# Get a node proxy using default host and port
def get_connection():
    global proxy
    proxy = NodeProxy(rpcuser='panagiotis', rpcpassword='papas1996', port="18443").get_proxy()

get_connection()
help(proxy)

# Get general information about regtest network, using proxy connection with the regtest node and common bitcoin-cli commands.
proxy.getblockchaininfo()
proxy.getblockcount()
proxy.getblockhash(101)
proxy.getblock("14c5799eb472d473ae3017d3d76e833efc52b05e3a57ce9478543c1a871b0cbc")

proxy.getrawmempool()  # contains only the first txid

# Get information about my wallet, my addresses etc
proxy.getwalletinfo()
proxy.getbalance()
proxy.listaddressgroupings()


# Sent 1 more btc from my address (defined in my wallet in the regtest node)
# to this new address and keep transaction id
btc_to_send = 1

proxy.sendtoaddress(p2sh_addr.to_string(), btc_to_send)
txid_2 = 'a7b3c7160634b184b0cd194f9964fcbb36f9ad97aa4c461d0decf52445a3eb6b'


# 7. Can you see the transaction in the mempool (Most recent transaction appears on top)?
get_connection()
proxy.getrawmempool()

# 8. Mine the transaction in a new block. (Using my address from my wallet in regtest node)
proxy.generatetoaddress(1, "2Mvej56LqS4xBD1BHq6bLxmRnsCcsa2vYTT")
proxy.getrawmempool()  # Empty


# 9. Can you find the transaction in the last block? What is the txid? (The last one)
current_block_hash = proxy.getblockhash(proxy.getblockcount())
current_block_hash
proxy.getblock(current_block_hash)


# 10. Create a new address in your wallet. You will use this address later to send all time locked funds to.
address2 = proxy.getnewaddress("papas_locktime_address", "legacy")
address2  # 'mu6WP7uVHeCKeFTzstRbnShQrpfStyZe2F'

proxy.listaddressgroupings()


# 11. Having the redeem script you created earlier in mind, along with the txid and the new address you just generated, create a new transaction.

# Transaction must have:
# - Input (the previous transaction)
# - Output (sent the funcds in the new address)


# 12. Use as input the output of the transaction you submitted to the blockchain earlier.

txid_2
proxy.gettransaction()

help(TxInput)

txin = TxInput(txid=txid_2, txout_index=0, sequence=seq.for_input_sequence())

# 13. Use as output the address you just created in your wallet.
print(address2)
to_address = P2pkhAddress(address2)
to_address.to_string()

# 14. Add a small fee. A few satoshis is fine.
fee = 0.0001
amount = Decimal(btc_to_send) - Decimal(fee)
print("Amount:", amount)

txout = TxOutput(amount, to_address.to_script_pub_key())

# 15. Create the transaction using the input and output.
tx = Transaction([txin], [txout])

# 16. Sign the input.
sig = priv.sign_input(tx, 0, redeem_script)

# 17. Create the signature.
txin.script_sig = Script([sig, pub.to_hex(), redeem_script.to_hex()])

signed_tx = tx.serialize()
print("\nTxId:", tx.get_txid())


# 18. Print the raw transaction.
tx.get_txid()
tx.get_size()
tx

tx.has_segwit

# 19. Submit the transaction to the blockchain. What happens?
get_connection()
proxy.getrawmempool()
proxy.sendrawtransaction(signed_tx)

