import string

class WordListGenerator:

  def __init__(self, wordlist, length):
    self.wordlist = wordlist
    self.words = set()
    self.load_wordlist()
    self.generate_wordlist(length)
    self.save_wordlist()
    self.print_wordlist()
    self.print_wordlist_length()

  def load_wordlist(self):
    with open(self.wordlist, 'r') as f:
      self.words = f.read().splitlines()
      print(f"[+] Loaded {len(self.words)} words from {self.wordlist}")
      f.close()
      return self.words

  def generate_wordlist(self, length):
    self.words = [word for word in self.words if len(word) > length]
    
    print(
        f"[+] Generated {len(self.words)} words with length greater than {length}"
    )
    return self.words

  def save_wordlist(self):
    with open('generated_wordlist.txt', 'w') as f:
      f.write('\n'.join(self.words))
      print(f"[+] Saved {len(self.words)} words to generated_wordlist.txt")
      f.close()

  def print_wordlist(self):
    print(f"[+] Printing wordlist: {self.words}")

  def print_wordlist_length(self):
    print(f"[+] Wordlist length: {len(self.words)}")


for i in string.punctuation:

