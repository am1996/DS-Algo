import binascii
from Crypto.Hash import MD4
import socket
import requests


def fuzz_domains(target, wordlist, https=False):
  for word in wordlist:
    url = f"{'https' if https else 'http'}://{word}.{target}"
    try:
      response = requests.get(url)
      print(f"[+] {url} returned {response.status_code}")
    except Exception:
      pass


def scan_ports(ip, ports):
  for port in ports:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(1)
    result = s.connect_ex((ip, port))
    if result == 0:
      print(f"[+] Port {port} is open")
    else:
      print(f"[-] Port {port} is closed")
    s.close()


def ntlm_hash(password):
  password = password.encode('utf-16le')
  md4 = MD4.new()
  md4.update(password)
  return md4.hexdigest()


scan_ports("8.8.8.8", [22, 80, 443, 3389])
fuzz_domains("google.com", ["www", "mail", "ftp", "admin"], https=True)
