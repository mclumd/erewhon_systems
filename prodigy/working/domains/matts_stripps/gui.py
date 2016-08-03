import pygame, sys
from pygame.locals import *

class CheckBox:
	
	mouseable = True
	keyable = False
	
	def __init__(self, label="", checked = False, size=20):
		self.label = label
		self.name = label
		self.textsize = size
		self.boxsize = size
		self.bordercolor = (20, 80, 80)
		self.boxcolor = (255, 255, 255)
		self.bkgcolor = (160, 160, 160)
		self.textcolor = (0, 0, 0)
		self.xcolor = (255, 0, 0)
		self.xwidth = 2
		self.font = None
		self.bufferwidth = 3
		self.borderwidth = 3
		self.checked = checked
	
	def get_size(self):
		font = pygame.font.Font(self.font, self.textsize)
		labelsize = font.size(self.label)
		return (2 * self.borderwidth + 3 * self.bufferwidth + self.boxsize + labelsize[0], 2 * (self.borderwidth + self.bufferwidth) + max(self.boxsize, labelsize[1]))
	
	def in_box(self, loc):
		return loc[0] >= self.borderwidth + self.bufferwidth and loc[0] < self.borderwidth + self.bufferwidth + self.boxsize and loc[1] >= self.borderwidth + self.bufferwidth and loc[1] < self.borderwidth + self.bufferwidth + self.boxsize
	
	def click(self, button, loc):
		if button == 1:
			if self.in_box(loc):
				self.checked  = not self.checked
	
	def draw(self):
		font = pygame.font.Font(self.font, self.textsize)
		#get size of box
		size = self.get_size()
		
		#draw bkg, border
		surf = pygame.Surface(size)
		surf.fill(self.bkgcolor)
		pygame.draw.rect(surf, self.bordercolor, (0, 0, size[0], size[1]), self.borderwidth)
		
		#draw box
		pygame.draw.rect(surf, self.boxcolor, (self.borderwidth + self.bufferwidth, self.borderwidth + self.bufferwidth, self.boxsize, self.boxsize))
		if self.checked: #draw x as two lines
			pygame.draw.line(surf, self.xcolor, (self.borderwidth + self.bufferwidth, self.borderwidth + self.bufferwidth), (self.borderwidth + self.bufferwidth + self.boxsize, self.borderwidth + self.bufferwidth + self.boxsize), self.xwidth)
			pygame.draw.line(surf, self.xcolor, (self.borderwidth + self.bufferwidth, self.borderwidth + self.bufferwidth + self.boxsize), (self.borderwidth + self.bufferwidth + self.boxsize, self.borderwidth + self.bufferwidth), self.xwidth)
		
		#draw label
		labelloc = (2 * self.bufferwidth + self.borderwidth + self.boxsize, self.borderwidth + self.bufferwidth)
		surf.blit(font.render(self.label, True, self.textcolor), labelloc)
		return surf
		
		

#1 line writeable text box (self-sizing by default)
class TextBox:
	
	mouseable = False
	keyable = True
	
	def __init__(self, text="", size=20, numericOnly=False):
		self.text = text
		self.textsize = size
		self.bordercolor = (80, 80, 80)
		self.bkgcolor = (255, 255, 255)
		self.textcolor = (0, 0, 0)
		self.borderwidth = 3
		self.bufferwidth = 3
		self.font = None
		self.minsize = (0, 0)
		self.numeric = numericOnly
		self.maxchars = 200
	
	def get_size(self):
		font = pygame.font.Font(self.font, self.textsize)
		size = font.size(self.text)
		size = (max(self.minsize[0], size[0] + 2 * (self.borderwidth + self.bufferwidth)), max(self.minsize[0], size[1] + 2 * (self.borderwidth + self.bufferwidth)))
		return size
	
	def key_down(self, key):
		isnum = key >= K_0 and key <= K_9
		isletter = key >= K_a and key <= K_z
		if key == K_BACKSPACE and len(self.text) > 0:
			self.text = self.text[:-1]
		elif len(self.text) < self.maxchars and (isnum or ((not self.numeric) and (isletter or key == K_SPACE))):
			self.text += chr(key)
	
	def draw(self):
		font = pygame.font.Font(self.font, self.textsize)
		#get size of box
		size = self.get_size()
		
		#draw bkg and box
		surf = pygame.Surface(size)
		surf.fill(self.bkgcolor)
		pygame.draw.rect(surf, self.bordercolor, (0, 0, size[0], size[1]), self.borderwidth)
		#draw text
		surf.blit(font.render(self.text, True, self.textcolor), (self.borderwidth + self.bufferwidth, self.borderwidth + self.bufferwidth))
		return surf

class Label:
	
	mouseable = False
	keyable = False
	
	def __init__(self, text, size=20):
		self.text = text
		self.textsize = size
		self.textcolor = (0, 0, 0)
		self.font = None
	
	def get_size(self):
		font = pygame.font.Font(self.font, self.textsize)
		size = font.size(self.text)
		return size
	
	def draw(self):
		font = pygame.font.Font(self.font, self.textsize)
		return font.render(self.text, True, self.textcolor)

class Button:
	
	mouseable = True
	keyable = False
	
	def __init__(self, text, size=20):
		self.text = text
		self.name = text
		self.textsize = size
		self.textcolor = (200, 200, 200)
		self.font = None
		self.bkgcolor = (50, 50, 50)
		self.bordercolor = (255, 255, 255)
		self.borderwidth = 3
		self.bufferwidth = 3
		self.minsize = (0, 0)
	
	def get_size(self):
		font = pygame.font.Font(self.font, self.textsize)
		size = font.size(self.text)
		size = (max(self.minsize[0], size[0] + 2 * (self.borderwidth + self.bufferwidth)), max(self.minsize[0], size[1] + 2 * (self.borderwidth + self.bufferwidth)))
		return size
		
	def click(self, button, loc):
		if button == 1:
			return self
		return None
	
	def draw(self):
		font = pygame.font.Font(self.font, self.textsize)
		#get size of box
		size = self.get_size()
		
		#draw bkg and box
		surf = pygame.Surface(size)
		surf.fill(self.bkgcolor)
		pygame.draw.rect(surf, self.bordercolor, (0, 0, size[0], size[1]), self.borderwidth)
		#draw text
		surf.blit(font.render(self.text, True, self.textcolor), (self.borderwidth + self.bufferwidth, self.borderwidth + self.bufferwidth))
		return surf
	
class GUI:
	
	def __init__(self, size, bkgcolor=(0, 0, 0)):
		self.size = size
		self.bkgcolor = bkgcolor
		self.objects = [] #reverse order of display "height"
		self.locs = {}
		self.mouseselected = None
		self.keyselected = None #objects to which output should be redirected
		self.modes = {}
		self.modedisplay = None
		self.bools = {}
		self.mode = None
		self.changed = True
	
	def focus(self, obj):
		#add or move to front
		if obj in self.objects:
			self.objects.remove(obj)
		self.objects.append(obj)
		#set to currently selected obj
		if obj.mouseable:
			self.mouseselected = obj
		if obj.keyable:
			self.keyselected = obj
		self.changed = True
	
	def add(self, obj, loc):
		if len(loc) != 2:
			raise Exception("loc must be a tuple")
		self.focus(obj)
		self.locs[obj] = loc
		self.changed = True
	
	def remove(self, obj):
		if obj == self.keyselected:
			self.keyselected = None
		if obj == self.mouseselected:
			 self.mouseselected = None
		self.objects.remove(obj)
		del self.locs[obj]
		self.changed = True
	
	#only handles backspace, space, alphanumerics at present.
	def key_down(self, key):
		if self.keyselected:
			self.keyselected.key_down(key)
		self.changed = True
	
	def obj_hit(self, loc):
		i = len(self.objects) - 1
		while i >= 0:
			obj = self.objects[i]
			objsize = obj.get_size()
			if loc[0] >= self.locs[obj][0] and loc[0] < objsize[0] + self.locs[obj][0] and loc[1] >= self.locs[obj][1] and loc[1] < objsize[1] + self.locs[obj][1]:
				return obj
			i -= 1
		return None
	
	def click(self, button, loc):
		val = None
		if button == 1 or button == 3:
			obj = self.obj_hit(loc)
			if obj:
				self.focus(obj)
				if obj.mouseable:
					val = obj.click(button, (loc[0] - self.locs[obj][0], loc[1] - self.locs[obj][1]))
		if val:
			self.changed = True
		if val in self.modes:
			self.set_mode(self.modes[val])
		else:
			return val #a non-mode button is assumed to be custom-use
	
	def has_changed(self):
		return self.changed
	
	def draw(self):
		self.changed = False
		surf = pygame.Surface(self.size)
		surf.fill(self.bkgcolor)
		for obj in self.objects:
			surf.blit(obj.draw(), self.locs[obj])
		return surf
	
	def add_bool_checkbox(self, label, boolname, default, loc):
		box = CheckBox(label, default)
		box.name = boolname
		self.bools[boolname] = box
		self.add(box, loc)
	
	def get_bool(self, name):
		return self.bools[name].checked
	
	def set_mode(self, mode):
		if self.modedisplay:
			if self.mode:
				self.modedisplay.text = self.modedisplay.text.replace(self.mode, mode)
			else:
				self.modedisplay.text = self.modedisplay.text.replace("none", mode)
		self.mode = mode
	
	def add_mode_button(self, label, mode, loc):
		button = Button(label)
		button.name = mode
		self.modes[button] = mode
		self.add(button, loc)
	
	#put current mode in as [mode]. Will mess up with certain mode names, due to simplicity of updating process.
	def add_mode_display(self, text, loc):
		if self.mode == None:
			label = Label(text.replace("[mode]", "none"))
		else:
			label = Label(text.replace("[mode]", self.mode))
		self.modedisplay = label
		self.add(label, loc)
			
	