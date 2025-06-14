import binascii
from Crypto.Hash import MD4


def ntlm_hash(password):
  password = password.encode('utf-16le')
  md4 = MD4.new()
  md4.update(password)
  return md4.hexdigest()


print(ntlm_hash("hello world"))
