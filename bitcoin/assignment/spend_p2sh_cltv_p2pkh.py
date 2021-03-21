#!/usr/bin/env python
# vim:et:sta:sts=4:sw=4:ts=8:tw=79:

# Copyright (C) 2019 The python-bitcoin-utils developers
#
# This file is part of python-bitcoin-utils
#
# It is subject to the license terms in the LICENSE file found in the top-level
# directory of this distribution.
#
# No part of python-bitcoin-utils, including this file, may be copied,
# modified, propagated, or distributed except according to the terms contained
# in the LICENSE file.

#
# This script spends all available funds that a P2SH address containing a
# CLTV+P2PKH script as created from examples/create_p2sh_cltv_p2pkh.py has
# received
#

from bitcoinutils.setup import setup
from bitcoinutils.transactions import Transaction, TxInput, TxOutput, Sequence, Locktime
from bitcoinutils.keys import P2pkhAddress, P2shAddress, PrivateKey
from bitcoinutils.script import Script
from bitcoinutils.constants import TYPE_ABSOLUTE_TIMELOCK
from bitcoinutils.proxy import NodeProxy
from decimal import Decimal
import requests
import sys

def main():
    # always remember to setup the network
    setup('regtest')

    # RPC credentials for communicating with the node
    rpcuser = 'btc'
    rpcpass = 'btcpass098'
    proxy = NodeProxy(rpcuser, rpcpass).get_proxy()

    # set values
    block_height = 140

    # secret key needed to spend P2PKH that is wrapped by P2SH
    p2pkh_sk = PrivateKey('cSbKZh6a6wNUAQ8pr2KLKeZCQ4eJnFmN35wtReaoU4kCP97XQu6W')
    # this is the P2SH address the funds have been locked in
    p2shaddress = '2NGWStpuXtke1VXCTgNnzUgWbun7eY2f3nH'
    # this is the address the funds will be sent to 
    to_addr = P2pkhAddress('mnS1ng5D1hdvLkYAK2oS8R1C4e37aQdVoC')
   
    seq = Sequence(TYPE_ABSOLUTE_TIMELOCK, block_height)
    lock = Locktime(block_height)

    # import the address as watch-only
    print('importaddress')
    proxy.importaddress(p2shaddress , "P2SH absolute timelock", True)
    # find all UTXOs for this address. 10.000.000 should be enough
    print('listunspent')
    list_unspent = proxy.listunspent(0, 9999999, [p2shaddress])

    # create transaction inputs for all UTXOs. Calculate the total amount of
    # bitcoins they contain
    txin_list = []
    total_amount = 0
    for i in list_unspent:
        txin = TxInput(i['txid'], i['vout'], sequence=seq.for_input_sequence())
        txin_list.append(txin)
        total_amount = total_amount + i['amount']
    if total_amount == 0:
        print("No funds to move")
        sys.exit(0)

    # derive public key and adddress from the private key
    p2pkh_pk = p2pkh_sk.get_public_key().to_hex()
    p2pkh_addr = p2pkh_sk.get_public_key().get_address()

    # create the redeem script - needed to sign the transaction
    redeem_script = Script([seq.for_script(), 'OP_CHECKLOCKTIMEVERIFY', 'OP_DROP', 'OP_DUP', 'OP_HASH160', p2pkh_addr.to_hash160(), 'OP_EQUALVERIFY', 'OP_CHECKSIG'])

    # get fees using API. Although we may be running in regtest, we'll use the
    # fees as if we were using testnet (fees are in satoshis)
    url = 'https://api.blockcypher.com/v1/btc/test3'
    resp = requests.get(url)
    fee_per_kb = resp.json()['medium_fee_per_kb']

    # calculate transaction size according to:
    # in*180 + out*34 + 10 plus or minus 'in'
    # https://bitcoin.stackexchange.com/questions/1195/how-to-calculate-transaction-size-before-sending-legacy-non-segwit-p2pkh-p2sh
    # we'll play it safe and use the upper bound
    tx_size = len(txin_list) * 180 + 34 + 10 + len(txin_list)
    fees = tx_size * fee_per_kb / (1024 * 10**8)
    print('fees:', fees)

    # create the output
    txout = TxOutput(Decimal(total_amount) - Decimal(fees), to_addr.to_script_pub_key() )

    # create transaction from inputs/outputs
    tx = Transaction(txin_list, [txout], lock.for_transaction())


    # use the private key corresponding to the address that contains the
    # UTXO we are trying to spend to create the signatures for all txins -
    # note that the redeem script is passed to replace the scriptSig
    for i, txin in enumerate(txin_list):
        sig = p2pkh_sk.sign_input(tx, i, redeem_script )
        # set the scriptSig (unlocking script) -- unlock the P2PKH (sig, pk) plus
        # the redeem script, since it is a P2SH
        txin.script_sig = Script([sig, p2pkh_pk, redeem_script.to_hex()])

    # serialize the transaction
    signed_tx = tx.serialize()
    
    # test if the transaction will be accepted by the mempool
    print('testmempoolaccept')
    res = proxy.testmempoolaccept([signed_tx])
    print(res)
    if not res[0]['allowed']:
        print("Transaction not valid")
        sys.exit(1)

    # print raw transaction
    print("\nRaw unsigned transaction:\n" + tx.serialize())
    # print raw signed transaction ready to be broadcasted
    print("\nRaw signed transaction:\n" + signed_tx)
    print("\nTxId:", tx.get_txid())

if __name__ == "__main__":
    main()

