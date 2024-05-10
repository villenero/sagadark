from typing import List
from pygame import Surface
from pygame.rect import FRect, Rect
from settings import *

class AllSprites(pygame.sprite.Group):
    def __init__(self):
        super().__init__()
        self.display_surface = pygame.display.get_surface()
        self.offset = vector()
        self.borders = {
            'left': 0,
            'right': - (7680 - WIDTH),
            #'top': 0,
            #'bottom': 0
        }

    def camera_constraint(self):
        self.offset.x = self.offset.x if self.offset.x < self.borders['left'] else self.borders['left']
        self.offset.x = self.offset.x if self.offset.x > self.borders['right'] else self.borders['right']

    def draw(self, target_pos):
        self.offset.x = -(target_pos[0] - WIDTH / 2)
        self.offset.y = 0 # -(target_pos[1] - HEIGHT / 2)
        self.camera_constraint()

        for sprite in sorted(self, key = lambda sprite: sprite.z):
            offset_pos = sprite.rect.topleft + self.offset
            self.display_surface.blit(sprite.image, offset_pos)