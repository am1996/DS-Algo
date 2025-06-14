a = [i for i in range(0, 1000, 3) if i % 2 == 0]


def generator(a):
  for i in a:
    yield i, i * 2


gen = generator(a)
