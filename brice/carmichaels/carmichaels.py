#!/usr/bin/env python3

import sys
from PIL import Image, ImageDraw

WIDTH, HEIGHT = (10000,10000)

im = Image.new("RGB", (WIDTH, HEIGHT), "black")

im.putpixel((0,0), (255,0,0))
draw = ImageDraw.Draw(im)

# get carmichael numbers
with open("carmichaels.txt") as cmf:
	indexed_lines = [line.split() for line in cmf.readlines() if line.strip() is not ""]
	carmichaels = set([int(n) for i,n in indexed_lines])


def colour_given_n(n):
	if not n in carmichaels:
		return (0,0,0)
	else:
		print(n)
		return (0,255,0)


def within_bounds(pos):
	x,y=pos
	return (x<WIDTH and y<HEIGHT and x>=0 and y>=0)

pos=(int(WIDTH/2), int(HEIGHT/2))	
n=1
length=1
cycle = [
	lambda p: (p[0]+1, p[1]),
	lambda p: (p[0], p[1]-1),
	lambda p: (p[0]-1, p[1]),
	lambda p: (p[0], p[1]+1)
]



def set_pixel(im, pos, n):
	im.putpixel(pos, colour_given_n(n))



set_pixel(im,pos,n)
while True:
	for i in range(2):
		nexter = cycle.pop(0)
		cycle.append(nexter)

		for i in range(length):
			pos = nexter(pos)
			# print(pos)
			n += 1
			if within_bounds(pos):
				if n in carmichaels:
					draw.ellipse([pos[0]-10, pos[1]-10, pos[0]+10, pos[1]+10], fill=(255,0,0))
			else:
				im.save("carmichaels.png")
				sys.exit()
	length +=1



