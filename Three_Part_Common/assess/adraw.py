import pygame

LEFT_BUFFER = 50
TOP_BUFFER = 50

pygame.init()

class ALine:
	
	maxwidth = 2000
	maxdist = 2
	color = (0, 0, 0)
	
	def __init__(self, heightscale = 25, widthscale = 2):
		self.heightscale = heightscale
		self.widthscale = widthscale
		self.img = None
	
	def create_img(self, sequence, bkg):
		img = pygame.Surface((min(self.maxwidth, len(sequence) * self.widthscale), self.heightscale * self.maxdist))
		img.fill(bkg)
		for x in range(len(sequence)):
			pygame.draw.line(img, self.color, (x * self.widthscale, (self.maxdist - min(sequence[x], self.maxdist)) * self.heightscale - 1), (x * self.widthscale, self.maxdist * self.heightscale - 1), self.widthscale)
		self.img = img
	
	def draw(self):
		if not self.img:
			raise Exception("No sequence submitted for drawing")
		return self.img

def display_seqs(distsequences, size = (1024, 868), bkg = (200, 200, 200)):
	pygame.display.init()
	screen = pygame.display.set_mode(size)
	screen.fill(bkg)
	lines = []
	y = TOP_BUFFER
	for sequence in distsequences:
		lines.append(ALine())
		lines[-1].create_img(sequence, bkg)
		screen.blit(lines[-1].draw(), (LEFT_BUFFER, y))
		y += lines[-1].heightscale * ALine.maxdist
		if y >= size[1]:
			break
	pygame.display.flip()

def exit():
	pygame.display.quit()

if __name__ == "__main__":

	sequence = []
	for i in range(500):
		sequence.append(i * 0.002)
	seq2 = []
	for i in range(500):
		seq2.append(1 - i * 0.002)

	display_seqs([sequence, seq2])
	raw_input()
	exit()
	raw_input()
		