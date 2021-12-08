#! /usr/bin/env python3

import sys

def seg(s):
    s = ','.join([c for c in s.upper()])
    return f'[{s}]'

def segs(s):
    s = s.strip().split()
    return '[' + ','.join([seg(ss) for ss in s]) + ']'


with open('in.txt', 'r') as f:
    lines = f.readlines()

print("tell('out.txt').\n")
for line in lines:
    if len(line) < 2:
        continue
    line = line.split('|')
    print(f'process({segs(line[0])}, {segs(line[1])}).\n')
print('told.\n')

