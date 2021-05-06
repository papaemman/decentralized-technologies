#
#  Panoramix v4 Oct 2019 
#  Decompiled source of 0xe381A318AF4BCC2410d5d2d183d61004b924a8e2
# 
#  Let's make the world open source 
# 
#
#  I failed with these: 
#  - withdrawFunds()
#  All the rest is below.
#

const unknown227c7123 = 40
const unknown3c4de40f = '1.1', 0
const totalBalance = eth.balance(this.address)
const unknownb5077f44 = 10000
const unknownd547cfb7 = ''

def storage:
  stor0 is array of struct at storage 0
  stor1 is array of struct at storage 1
  ownerOf is mapping of addr at storage 2
  balanceOf is mapping of uint256 at storage 3
  approved is mapping of addr at storage 4
  stor5 is mapping of uint8 at storage 5
  owner is addr at storage 6
  stor7 is addr at storage 7
  stor8 is uint256 at storage 8
  stor9 is mapping of struct at storage 9
  unknown4dc2fefb is uint256 at storage 10
  unknownb9a8ac7c is uint256 at storage 11
  unknown817f750e is uint256 at storage 12

def getApproved(uint256 _tokenId): # not payable
  require calldata.size - 4 >=′ 32
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approved query for nonexistent token'
  return approved[_tokenId]

def unknown4dc2fefb(): # not payable
  return unknown4dc2fefb

def ownerOf(uint256 _tokenId): # not payable
  require calldata.size - 4 >=′ 32
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  return ownerOf[_tokenId]

def balanceOf(address _owner): # not payable
  require calldata.size - 4 >=′ 32
  require _owner == _owner
  if not _owner:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: balance query for the zero address'
  return balanceOf[addr(_owner)]

def unknown817f750e(): # not payable
  return unknown817f750e

def owner(): # not payable
  return owner

def unknownb9a8ac7c(): # not payable
  return unknownb9a8ac7c

#
#  Regular functions
#

def _fallback() payable: # default function
  revert

def renounceOwnership(): # not payable
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  log OwnershipTransferred(
        address previousOwner=owner,
        address newOwner=0)
  owner = 0

def transferOwnership(address _newOwner): # not payable
  require calldata.size - 4 >=′ 32
  require _newOwner == _newOwner
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  if not _newOwner:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'Ownable: new owner is the zero address'
  log OwnershipTransferred(
        address previousOwner=owner,
        address newOwner=_newOwner)
  owner = _newOwner

def supportsInterface(bytes4 _interfaceId): # not payable
  require calldata.size - 4 >=′ 32
  require _interfaceId == Mask(32, 224, _interfaceId)
  if Mask(32, 224, _interfaceId) == 0x80ac58cd00000000000000000000000000000000000000000000000000000000:
      return True
  if Mask(32, 224, _interfaceId) == 0x5b5e139f00000000000000000000000000000000000000000000000000000000:
      return True
  return (Mask(32, 224, _interfaceId) == 0x1ffc9a700000000000000000000000000000000000000000000000000000000)

def setApprovalForAll(address _to, bool _approved): # not payable
  require calldata.size - 4 >=′ 64
  require _to == _to
  require _approved == _approved
  if _to == caller:
      revert with 0, 'ERC721: approve to caller'
  stor5[caller][addr(_to)] = uint8(_approved)
  log ApprovalForAll(
        address owner=_approved,
        address operator=caller,
        bool approved=_to)

def unknown210fa96b(uint256 _param1): # not payable
  require calldata.size - 4 >=′ 32
  require _param1 == _param1
  if _param1 != 10^17:
      if _param1 != 10^16:
          revert with 0, 'Not enough Ether provided'
      return 32, 53, 
             0x6f697066733a2f2f516d505a4a314b38454b486151674a79467473684245793532637462515a544a475054775478363445765a6756, mem[181 len 11] >> 168,
             0
  if unknown817f750e >= 40:
      revert with 0, 'Sale has already ended'
  return 32, 53, 
         0xfe697066733a2f2f516d6337344244486b7a6a4c705a623967793552737272593344416f3655554d514d42486b4b776e7936715150, mem[181 len 11] >> 168,
         0

def isApprovedForAll(address _owner, address _operator): # not payable
  require calldata.size - 4 >=′ 64
  require _owner == _owner
  require _operator == _operator
  require ext_code.size(stor7)
  static call stor7.proxies(address param1) with:
          gas gas_remaining wei
         args _owner
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size >=′ 32
  require ext_call.return_data == ext_call.return_data[12 len 20]
  if ext_call.return_data_operator:
      return bool(stor5[addr(_owner)][addr(_operator)])
  return 1

def unknown755edd17(uint256 _param1): # not payable
  require calldata.size - 4 >=′ 32
  require _param1 == addr(_param1)
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  if not addr(_param1):
      revert with 0, 'ERC721: mint to the zero address'
  if ownerOf[stor8]:
      revert with 0, 'ERC721: token already minted'
  if balanceOf[addr(_param1)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_param1)]++
  ownerOf[stor8] = addr(_param1)
  log Transfer(
        address from=0,
        address to=addr(_param1),
        uint256 value=stor8)
  stor8++

def approve(address _spender, uint256 _value): # not payable
  require calldata.size - 4 >=′ 64
  require _spender == _spender
  require _value == _value
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if _spender == ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approval to current owner'
  if ownerOf[_value] != caller:
      if not stor5[stor2[_value]][caller]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                      'ERC721: approve caller is not owner nor approved for all'
  approved[_value] = _spender
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_value],
        address spender=_spender,
        uint256 value=_value)

def transferFrom(address _from, address _to, uint256 _value): # not payable
  require calldata.size - 4 >=′ 96
  require _from == _from
  require _to == _to
  require _value == _value
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if ownerOf[_value] != caller:
      if not ownerOf[_value]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: approved query for nonexistent token'
      if approved[_value] != caller:
          if not stor5[stor2[_value]][caller]:
              revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: transfer caller is not owner nor approved'
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  if ownerOf[_value] != _from:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: transfer of token that is not own'
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: transfer to the zero address'
  approved[_value] = 0
  if not ownerOf[_value]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_value],
        address spender=0,
        uint256 value=_value)
  if balanceOf[addr(_from)] < 1:
      revert with 'NH{q', 17
  balanceOf[addr(_from)]--
  if balanceOf[addr(_to)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_to)]++
  ownerOf[_value] = _to
  log Transfer(
        address from=_from,
        address to=_to,
        uint256 value=_value)

def safeTransferFrom(address _from, address _to, uint256 _tokenId): # not payable
  require calldata.size - 4 >=′ 96
  require _from == _from
  require _to == _to
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != caller:
      if not ownerOf[_tokenId]:
          revert with 0, 'ERC721: approved query for nonexistent token'
      if approved[_tokenId] != caller:
          if not stor5[stor2[_tokenId]][caller]:
              revert with 0, 'ERC721: transfer caller is not owner nor approved'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != _from:
      revert with 0, 'ERC721: transfer of token that is not own'
  if not _to:
      revert with 0, 'ERC721: transfer to the zero address'
  approved[_tokenId] = 0
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_tokenId],
        address spender=0,
        uint256 value=_tokenId)
  if balanceOf[addr(_from)] < 1:
      revert with 'NH{q', 17
  balanceOf[addr(_from)]--
  if balanceOf[addr(_to)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_to)]++
  ownerOf[_tokenId] = _to
  log Transfer(
        address from=_from,
        address to=_to,
        uint256 value=_tokenId)
  if ext_code.size(_to) > 0:
      require ext_code.size(_to)
      call _to.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
           gas gas_remaining wei
          args 0, uint32(caller), addr(_from), _tokenId, 128, 0
      if not ext_call.success:
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size >=′ 32
      require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
      if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
          revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'

def safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes _data): # not payable
  require calldata.size - 4 >=′ 128
  require _from == _from
  require _to == _to
  require _tokenId == _tokenId
  require _data <= 18446744073709551615
  require _data + 35 <′ calldata.size
  if _data.length > 18446744073709551615:
      revert with 'NH{q', 65
  if ceil32(ceil32(_data.length)) + 97 > 18446744073709551615 or ceil32(ceil32(_data.length)) + 97 < 96:
      revert with 'NH{q', 65
  require _data + _data.length + 36 <= calldata.size
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: operator query for nonexistent token'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != caller:
      if not ownerOf[_tokenId]:
          revert with 0, 'ERC721: approved query for nonexistent token'
      if approved[_tokenId] != caller:
          if not stor5[stor2[_tokenId]][caller]:
              revert with 0, 'ERC721: transfer caller is not owner nor approved'
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  if ownerOf[_tokenId] != _from:
      revert with 0, 'ERC721: transfer of token that is not own'
  if not _to:
      revert with 0, 'ERC721: transfer to the zero address'
  approved[_tokenId] = 0
  if not ownerOf[_tokenId]:
      revert with 0, 'ERC721: owner query for nonexistent token'
  log Approval(
        address owner=ownerOf[_tokenId],
        address spender=0,
        uint256 value=_tokenId)
  if balanceOf[addr(_from)] < 1:
      revert with 'NH{q', 17
  balanceOf[addr(_from)]--
  if balanceOf[addr(_to)] > -2:
      revert with 'NH{q', 17
  balanceOf[addr(_to)]++
  ownerOf[_tokenId] = _to
  log Transfer(
        address from=_from,
        address to=_to,
        uint256 value=_tokenId)
  if ext_code.size(_to) > 0:
      require ext_code.size(_to)
      call _to.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
           gas gas_remaining wei
          args caller, addr(_from), _tokenId, Array(len=_data.length, data=_data[all])
      if not ext_call.success:
          if not return_data.size:
              if not _data.length:
                  revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
              revert with _data[all]
          if not return_data.size:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size >=′ 32
      require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
      if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
          revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'

def name(): # not payable
  if bool(stor0.length):
      if bool(stor0.length) == stor0.length.field_1 < 32:
          revert with 'NH{q', 34
      if bool(stor0.length):
          if bool(stor0.length) == stor0.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor0.length.field_1:
              if 31 < stor0.length.field_1:
                  mem[128] = uint256(stor0.field_0)
                  idx = 128
                  s = 0
                  while stor0.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor0[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor0.length.field_1), data=mem[128 len ceil32(stor0.length.field_1)])
              mem[128] = 256 * stor0.length.field_8
      else:
          if bool(stor0.length) == stor0.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor0.length.field_1:
              if 31 < stor0.length.field_1:
                  mem[128] = uint256(stor0.field_0)
                  idx = 128
                  s = 0
                  while stor0.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor0[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor0.length.field_1), data=mem[128 len ceil32(stor0.length.field_1)])
              mem[128] = 256 * stor0.length.field_8
      mem[ceil32(stor0.length.field_1) + 192 len ceil32(stor0.length.field_1)] = mem[128 len ceil32(stor0.length.field_1)]
      if ceil32(stor0.length.field_1) > stor0.length.field_1:
          mem[ceil32(stor0.length.field_1) + stor0.length.field_1 + 192] = 0
      return Array(len=2 * Mask(256, -1, stor0.length.field_1), data=mem[128 len ceil32(stor0.length.field_1)], mem[(2 * ceil32(stor0.length.field_1)) + 192 len 2 * ceil32(stor0.length.field_1)]), 
  if bool(stor0.length) == stor0.length.field_1 < 32:
      revert with 'NH{q', 34
  if bool(stor0.length):
      if bool(stor0.length) == stor0.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor0.length.field_1:
          if 31 < stor0.length.field_1:
              mem[128] = uint256(stor0.field_0)
              idx = 128
              s = 0
              while stor0.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor0[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor0.length % 128, data=mem[128 len ceil32(stor0.length.field_1)])
          mem[128] = 256 * stor0.length.field_8
  else:
      if bool(stor0.length) == stor0.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor0.length.field_1:
          if 31 < stor0.length.field_1:
              mem[128] = uint256(stor0.field_0)
              idx = 128
              s = 0
              while stor0.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor0[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor0.length % 128, data=mem[128 len ceil32(stor0.length.field_1)])
          mem[128] = 256 * stor0.length.field_8
  mem[ceil32(stor0.length.field_1) + 192 len ceil32(stor0.length.field_1)] = mem[128 len ceil32(stor0.length.field_1)]
  if ceil32(stor0.length.field_1) > stor0.length.field_1:
      mem[ceil32(stor0.length.field_1) + stor0.length.field_1 + 192] = 0
  return Array(len=stor0.length % 128, data=mem[128 len ceil32(stor0.length.field_1)], mem[(2 * ceil32(stor0.length.field_1)) + 192 len 2 * ceil32(stor0.length.field_1)]), 

def symbol(): # not payable
  if bool(stor1.length):
      if bool(stor1.length) == stor1.length.field_1 < 32:
          revert with 'NH{q', 34
      if bool(stor1.length):
          if bool(stor1.length) == stor1.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor1.length.field_1:
              if 31 < stor1.length.field_1:
                  mem[128] = uint256(stor1.field_0)
                  idx = 128
                  s = 0
                  while stor1.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor1[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor1.length.field_1), data=mem[128 len ceil32(stor1.length.field_1)])
              mem[128] = 256 * stor1.length.field_8
      else:
          if bool(stor1.length) == stor1.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor1.length.field_1:
              if 31 < stor1.length.field_1:
                  mem[128] = uint256(stor1.field_0)
                  idx = 128
                  s = 0
                  while stor1.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor1[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
                  return Array(len=2 * Mask(256, -1, stor1.length.field_1), data=mem[128 len ceil32(stor1.length.field_1)])
              mem[128] = 256 * stor1.length.field_8
      mem[ceil32(stor1.length.field_1) + 192 len ceil32(stor1.length.field_1)] = mem[128 len ceil32(stor1.length.field_1)]
      if ceil32(stor1.length.field_1) > stor1.length.field_1:
          mem[ceil32(stor1.length.field_1) + stor1.length.field_1 + 192] = 0
      return Array(len=2 * Mask(256, -1, stor1.length.field_1), data=mem[128 len ceil32(stor1.length.field_1)], mem[(2 * ceil32(stor1.length.field_1)) + 192 len 2 * ceil32(stor1.length.field_1)]), 
  if bool(stor1.length) == stor1.length.field_1 < 32:
      revert with 'NH{q', 34
  if bool(stor1.length):
      if bool(stor1.length) == stor1.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor1.length.field_1:
          if 31 < stor1.length.field_1:
              mem[128] = uint256(stor1.field_0)
              idx = 128
              s = 0
              while stor1.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor1[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor1.length % 128, data=mem[128 len ceil32(stor1.length.field_1)])
          mem[128] = 256 * stor1.length.field_8
  else:
      if bool(stor1.length) == stor1.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor1.length.field_1:
          if 31 < stor1.length.field_1:
              mem[128] = uint256(stor1.field_0)
              idx = 128
              s = 0
              while stor1.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor1[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
              return Array(len=stor1.length % 128, data=mem[128 len ceil32(stor1.length.field_1)])
          mem[128] = 256 * stor1.length.field_8
  mem[ceil32(stor1.length.field_1) + 192 len ceil32(stor1.length.field_1)] = mem[128 len ceil32(stor1.length.field_1)]
  if ceil32(stor1.length.field_1) > stor1.length.field_1:
      mem[ceil32(stor1.length.field_1) + stor1.length.field_1 + 192] = 0
  return Array(len=stor1.length % 128, data=mem[128 len ceil32(stor1.length.field_1)], mem[(2 * ceil32(stor1.length.field_1)) + 192 len 2 * ceil32(stor1.length.field_1)]), 

def unknownad1fef9c() payable: 
  if unknown4dc2fefb >= 10000:
      revert with 0, 'Sale has already ended'
  unknown4dc2fefb++
  if 10^17 != call.value:
      unknownb9a8ac7c++
      if not caller:
          revert with 0, 'ERC721: mint to the zero address'
      if ownerOf[stor11]:
          revert with 0, 'ERC721: token already minted'
      if balanceOf[caller] > -2:
          revert with 'NH{q', 17
      balanceOf[caller]++
      ownerOf[stor11] = caller
      log Transfer(
            address from=0,
            address to=caller,
            uint256 value=unknownb9a8ac7c)
      if ext_code.size(caller) <= 0:
          if 10^17 != call.value:
              if 10^16 != call.value:
                  revert with 0, 'Not enough Ether provided'
              mem[160 len 53] = 0x6f697066733a2f2f516d505a4a314b38454b486151674a79467473684245793532637462515a544a475054775478363445765a6756
          else:
              if unknown817f750e >= 40:
                  revert with 0, 'Sale has already ended'
              mem[160 len 53] = 0xfe697066733a2f2f516d6337344244486b7a6a4c705a623967793552737272593344416f3655554d514d42486b4b776e7936715150
          if not ownerOf[stor11]:
              revert with 0, 'ERC721Metadata: URI set of nonexistent token'
          if stor9[stor11].field_0:
              if stor9[stor11].field_0 == stor9[stor11].field_1 < 32:
                  revert with 'NH{q', 34
              stor9[stor11].field_0 = 107
              s = 0
              idx = 160
              while 213 > idx:
                  stor9[stor11][s].field_0 = mem[idx]
                  s = s + 1
                  idx = idx + 32
                  continue 
              idx = 2
              while stor9[stor11].field_1 + 31 / 32 > idx:
                  stor9[stor11][idx].field_0 = 0
                  idx = idx + 1
                  continue 
          else:
              if stor9[stor11].field_0 == stor9[stor11].field_1 < 32:
                  revert with 'NH{q', 34
              stor9[stor11].field_0 = 107
              s = 0
              idx = 160
              while 213 > idx:
                  stor9[stor11][s].field_0 = mem[idx]
                  s = s + 1
                  idx = idx + 32
                  continue 
              idx = 2
              while stor9[stor11].field_1 + 31 / 32 > idx:
                  stor9[stor11][idx].field_0 = 0
                  idx = idx + 1
                  continue 
      else:
          mem[164] = 0
          mem[196] = unknownb9a8ac7c
          mem[228] = 128
          mem[260] = 0
          mem[292 len 0] = None
          require ext_code.size(caller)
          call caller.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
               gas gas_remaining wei
              args 0, uint32(caller), 0, unknownb9a8ac7c, 128, 0
          if not ext_call.success:
              if not return_data.size:
                  revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
              if not return_data.size:
                  revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size >=′ 32
          require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
          if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          if 10^17 != call.value:
              if 10^16 != call.value:
                  revert with 0, 'Not enough Ether provided'
              mem[ceil32(return_data.size) + 160 len 53] = 0x6f697066733a2f2f516d505a4a314b38454b486151674a79467473684245793532637462515a544a475054775478363445765a6756
          else:
              if unknown817f750e >= 40:
                  revert with 0, 'Sale has already ended'
              mem[ceil32(return_data.size) + 160 len 53] = 0xfe697066733a2f2f516d6337344244486b7a6a4c705a623967793552737272593344416f3655554d514d42486b4b776e7936715150
          if not ownerOf[stor11]:
              revert with 0, 'ERC721Metadata: URI set of nonexistent token'
          if stor9[stor11].field_0:
              if stor9[stor11].field_0 == stor9[stor11].field_1 < 32:
                  revert with 'NH{q', 34
              stor9[stor11].field_0 = 107
              s = 0
              idx = ceil32(return_data.size) + 160
              while ceil32(return_data.size) + 213 > idx:
                  stor9[stor11][s].field_0 = mem[idx]
                  s = s + 1
                  idx = idx + 32
                  continue 
              idx = 2
              while stor9[stor11].field_1 + 31 / 32 > idx:
                  stor9[stor11][idx].field_0 = 0
                  idx = idx + 1
                  continue 
          else:
              if stor9[stor11].field_0 == stor9[stor11].field_1 < 32:
                  revert with 'NH{q', 34
              stor9[stor11].field_0 = 107
              s = 0
              idx = ceil32(return_data.size) + 160
              while ceil32(return_data.size) + 213 > idx:
                  stor9[stor11][s].field_0 = mem[idx]
                  s = s + 1
                  idx = idx + 32
                  continue 
              idx = 2
              while stor9[stor11].field_1 + 31 / 32 > idx:
                  stor9[stor11][idx].field_0 = 0
                  idx = idx + 1
                  continue 
  else:
      unknown817f750e++
      if not caller:
          revert with 0, 'ERC721: mint to the zero address'
      if ownerOf[stor12]:
          revert with 0, 'ERC721: token already minted'
      if balanceOf[caller] > -2:
          revert with 'NH{q', 17
      balanceOf[caller]++
      ownerOf[stor12] = caller
      log Transfer(
            address from=0,
            address to=caller,
            uint256 value=unknown817f750e)
      if ext_code.size(caller) <= 0:
          if 10^17 != call.value:
              if 10^16 != call.value:
                  revert with 0, 'Not enough Ether provided'
              mem[160 len 53] = 0x6f697066733a2f2f516d505a4a314b38454b486151674a79467473684245793532637462515a544a475054775478363445765a6756
          else:
              if unknown817f750e >= 40:
                  revert with 0, 'Sale has already ended'
              mem[160 len 53] = 0xfe697066733a2f2f516d6337344244486b7a6a4c705a623967793552737272593344416f3655554d514d42486b4b776e7936715150
          if not ownerOf[stor12]:
              revert with 0, 'ERC721Metadata: URI set of nonexistent token'
          if stor9[stor12].field_0:
              if stor9[stor12].field_0 == stor9[stor12].field_1 < 32:
                  revert with 'NH{q', 34
              stor9[stor12].field_0 = 107
              s = 0
              idx = 160
              while 213 > idx:
                  stor9[stor12][s].field_0 = mem[idx]
                  s = s + 1
                  idx = idx + 32
                  continue 
              idx = 2
              while stor9[stor12].field_1 + 31 / 32 > idx:
                  stor9[stor12][idx].field_0 = 0
                  idx = idx + 1
                  continue 
          else:
              if stor9[stor12].field_0 == stor9[stor12].field_1 < 32:
                  revert with 'NH{q', 34
              stor9[stor12].field_0 = 107
              s = 0
              idx = 160
              while 213 > idx:
                  stor9[stor12][s].field_0 = mem[idx]
                  s = s + 1
                  idx = idx + 32
                  continue 
              idx = 2
              while stor9[stor12].field_1 + 31 / 32 > idx:
                  stor9[stor12][idx].field_0 = 0
                  idx = idx + 1
                  continue 
      else:
          mem[164] = 0
          mem[196] = unknown817f750e
          mem[228] = 128
          mem[260] = 0
          mem[292 len 0] = None
          require ext_code.size(caller)
          call caller.onERC721Received(address operator, address from, uint256 tokenId, bytes data) with:
               gas gas_remaining wei
              args 0, uint32(caller), 0, unknown817f750e, 128, 0
          if not ext_call.success:
              if not return_data.size:
                  revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
              if not return_data.size:
                  revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size >=′ 32
          require ext_call.return_data == Mask(32, 224, ext_call.return_data[0])
          if Mask(32, 224, ext_call.return_data[0]) != 0x150b7a0200000000000000000000000000000000000000000000000000000000:
              revert with 0, 'ERC721: transfer to non ERC721Receiver implementer'
          if 10^17 != call.value:
              if 10^16 != call.value:
                  revert with 0, 'Not enough Ether provided'
              mem[ceil32(return_data.size) + 160 len 53] = 0x6f697066733a2f2f516d505a4a314b38454b486151674a79467473684245793532637462515a544a475054775478363445765a6756
          else:
              if unknown817f750e >= 40:
                  revert with 0, 'Sale has already ended'
              mem[ceil32(return_data.size) + 160 len 53] = 0xfe697066733a2f2f516d6337344244486b7a6a4c705a623967793552737272593344416f3655554d514d42486b4b776e7936715150
          if not ownerOf[stor12]:
              revert with 0, 'ERC721Metadata: URI set of nonexistent token'
          if stor9[stor12].field_0:
              if stor9[stor12].field_0 == stor9[stor12].field_1 < 32:
                  revert with 'NH{q', 34
              stor9[stor12].field_0 = 107
              s = 0
              idx = ceil32(return_data.size) + 160
              while ceil32(return_data.size) + 213 > idx:
                  stor9[stor12][s].field_0 = mem[idx]
                  s = s + 1
                  idx = idx + 32
                  continue 
              idx = 2
              while stor9[stor12].field_1 + 31 / 32 > idx:
                  stor9[stor12][idx].field_0 = 0
                  idx = idx + 1
                  continue 
          else:
              if stor9[stor12].field_0 == stor9[stor12].field_1 < 32:
                  revert with 'NH{q', 34
              stor9[stor12].field_0 = 107
              s = 0
              idx = ceil32(return_data.size) + 160
              while ceil32(return_data.size) + 213 > idx:
                  stor9[stor12][s].field_0 = mem[idx]
                  s = s + 1
                  idx = idx + 32
                  continue 
              idx = 2
              while stor9[stor12].field_1 + 31 / 32 > idx:
                  stor9[stor12][idx].field_0 = 0
                  idx = idx + 1
                  continue 

def tokenURI(uint256 _tokenId): # not payable
  require calldata.size - 4 >=′ 32
  require _tokenId == _tokenId
  if not ownerOf[_tokenId]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC721Metadata: URI query for nonexistent token'
  if stor9[_tokenId].field_0:
      if stor9[_tokenId].field_0 == stor9[_tokenId].field_1 < 32:
          revert with 'NH{q', 34
      if stor9[_tokenId].field_0:
          if stor9[_tokenId].field_0 == stor9[_tokenId].field_1 < 32:
              revert with 'NH{q', 34
          if not stor9[_tokenId].field_1:
              mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(stor9[_tokenId].field_1)] = mem[128 len ceil32(stor9[_tokenId].field_1)]
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 160] = 32
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 192] = mem[ceil32(stor9[_tokenId].field_1) + 128]
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])] = mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]
              if ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128]) > mem[ceil32(stor9[_tokenId].field_1) + 128]:
                  mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + mem[ceil32(stor9[_tokenId].field_1) + 128] + 224] = 0
          else:
              if 31 >= stor9[_tokenId].field_1:
                  mem[128] = 256 * stor9[_tokenId].field_8
              else:
                  mem[128] = stor9[_tokenId].field_0
                  idx = 128
                  s = 0
                  while stor9[_tokenId].field_1 + 96 > idx:
                      mem[idx + 32] = stor9[_tokenId][s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
              mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(stor9[_tokenId].field_1)] = mem[128 len ceil32(stor9[_tokenId].field_1)]
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 160] = 32
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 192] = mem[ceil32(stor9[_tokenId].field_1) + 128]
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])] = mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]
              if ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128]) > mem[ceil32(stor9[_tokenId].field_1) + 128]:
                  mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + mem[ceil32(stor9[_tokenId].field_1) + 128] + 224] = 0
      else:
          if stor9[_tokenId].field_0 == stor9[_tokenId].field_1 < 32:
              revert with 'NH{q', 34
          if not stor9[_tokenId].field_1:
              mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(stor9[_tokenId].field_1)] = mem[128 len ceil32(stor9[_tokenId].field_1)]
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 160] = 32
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 192] = mem[ceil32(stor9[_tokenId].field_1) + 128]
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])] = mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]
              if ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128]) > mem[ceil32(stor9[_tokenId].field_1) + 128]:
                  mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + mem[ceil32(stor9[_tokenId].field_1) + 128] + 224] = 0
          else:
              if 31 >= stor9[_tokenId].field_1:
                  mem[128] = 256 * stor9[_tokenId].field_8
              else:
                  mem[128] = stor9[_tokenId].field_0
                  idx = 128
                  s = 0
                  while stor9[_tokenId].field_1 + 96 > idx:
                      mem[idx + 32] = stor9[_tokenId][s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue 
              mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(stor9[_tokenId].field_1)] = mem[128 len ceil32(stor9[_tokenId].field_1)]
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 160] = 32
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 192] = mem[ceil32(stor9[_tokenId].field_1) + 128]
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])] = mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]
              if ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128]) > mem[ceil32(stor9[_tokenId].field_1) + 128]:
                  mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + mem[ceil32(stor9[_tokenId].field_1) + 128] + 224] = 0
      return Array(len=mem[ceil32(stor9[_tokenId].field_1) + 128], data=mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]), 
  if stor9[_tokenId].field_0 == stor9[_tokenId].field_1 < 32:
      revert with 'NH{q', 34
  if stor9[_tokenId].field_0:
      if stor9[_tokenId].field_0 == stor9[_tokenId].field_1 < 32:
          revert with 'NH{q', 34
      if not stor9[_tokenId].field_1:
          mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(stor9[_tokenId].field_1)] = mem[128 len ceil32(stor9[_tokenId].field_1)]
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 160] = 32
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 192] = mem[ceil32(stor9[_tokenId].field_1) + 128]
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])] = mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]
          if ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128]) > mem[ceil32(stor9[_tokenId].field_1) + 128]:
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + mem[ceil32(stor9[_tokenId].field_1) + 128] + 224] = 0
      else:
          if 31 >= stor9[_tokenId].field_1:
              mem[128] = 256 * stor9[_tokenId].field_8
          else:
              mem[128] = stor9[_tokenId].field_0
              idx = 128
              s = 0
              while stor9[_tokenId].field_1 + 96 > idx:
                  mem[idx + 32] = stor9[_tokenId][s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
          mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(stor9[_tokenId].field_1)] = mem[128 len ceil32(stor9[_tokenId].field_1)]
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 160] = 32
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 192] = mem[ceil32(stor9[_tokenId].field_1) + 128]
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])] = mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]
          if ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128]) > mem[ceil32(stor9[_tokenId].field_1) + 128]:
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + mem[ceil32(stor9[_tokenId].field_1) + 128] + 224] = 0
  else:
      if stor9[_tokenId].field_0 == stor9[_tokenId].field_1 < 32:
          revert with 'NH{q', 34
      if not stor9[_tokenId].field_1:
          mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(stor9[_tokenId].field_1)] = mem[128 len ceil32(stor9[_tokenId].field_1)]
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 160] = 32
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 192] = mem[ceil32(stor9[_tokenId].field_1) + 128]
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])] = mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]
          if ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128]) > mem[ceil32(stor9[_tokenId].field_1) + 128]:
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + mem[ceil32(stor9[_tokenId].field_1) + 128] + 224] = 0
      else:
          if 31 >= stor9[_tokenId].field_1:
              mem[128] = 256 * stor9[_tokenId].field_8
          else:
              mem[128] = stor9[_tokenId].field_0
              idx = 128
              s = 0
              while stor9[_tokenId].field_1 + 96 > idx:
                  mem[idx + 32] = stor9[_tokenId][s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue 
          mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(stor9[_tokenId].field_1)] = mem[128 len ceil32(stor9[_tokenId].field_1)]
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 160] = 32
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 192] = mem[ceil32(stor9[_tokenId].field_1) + 128]
          mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])] = mem[ceil32(stor9[_tokenId].field_1) + 160 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]
          if ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128]) > mem[ceil32(stor9[_tokenId].field_1) + 128]:
              mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + mem[ceil32(stor9[_tokenId].field_1) + 128] + 224] = 0
  return Array(len=mem[ceil32(stor9[_tokenId].field_1) + 128], data=mem[ceil32(stor9[_tokenId].field_1) + stor9[_tokenId].field_1 + 224 len ceil32(mem[ceil32(stor9[_tokenId].field_1) + 128])]), 

