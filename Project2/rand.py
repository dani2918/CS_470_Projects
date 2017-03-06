import random

w1 = 1.0
w2 = 1.0

def change(w1, w2):
    w1 += random.uniform(-1,1)
    w2 += random.uniform(-1,1)
    print(w1, w2)
