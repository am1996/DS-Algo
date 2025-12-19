import hmac
import json

obj = {"message": "hello world"}

print(json.dumps(obj))
print(hmac.new(b"secret", json.dumps(obj).encode(), "sha256").hexdigest())
