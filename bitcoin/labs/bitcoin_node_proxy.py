#############################################
#                                           #
#  HOW TO: Connect python to bitcoin node   #
#                                           #
#############################################

# IMPORTANT: Before proceed to the script make sure that you have start a regtest node.


# Import modules
from bitcoinutils.setup import setup
from bitcoinutils.proxy import NodeProxy

# Setup the network
setup("testnet")

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

proxy.getrawmempool()
txid_1 = '4255910df6c69f6fdb0c37d162969152d0af9faeba41a1c56691932c4db0a77f'

# Get information about my wallet, my addresses etc
proxy.getwalletinfo()
proxy.getbalance()
proxy.listaddressgroupings()
proxy.getreceivedbyaddress()
