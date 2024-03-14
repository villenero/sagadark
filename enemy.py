import pygame
import random

class Enemy(pygame.sprite.Sprite):
    def __init__(self, images, y_pos, fps):
        super().__init__()
        self.images = images
        self.current_image = 0
        self.image = self.images[self.current_image]
        self.rect = self.image.get_rect()
        self.rect.x = 512
        self.rect.y = y_pos
        self.speed_x = -3
        self.fps = fps
        self.animation_timer = 0

    def update(self, dt):
        self.rect.x += self.speed_x
        if self.rect.right < 0:
            self.kill()
        self.animate(dt)

    def animate(self, dt):
        self.animation_timer += dt
        if self.animation_timer >= 1 / self.fps:
            self.animation_timer = 0
            self.current_image = (self.current_image + 1) % len(self.images)
            self.image = self.images[self.current_image]

class Enemy1(Enemy):
    def __init__(self, fps):
        images = [
            pygame.image.load("bitmaps/enemies/enemigo1_1.png"),
            pygame.image.load("bitmaps/enemies/enemigo1_2.png"),
            pygame.image.load("bitmaps/enemies/enemigo1_3.png"),
            pygame.image.load("bitmaps/enemies/enemigo1_2.png")
        ]
        super().__init__(images, 144, fps)

class Enemy2(Enemy):
    def __init__(self, fps):
        images = [
            pygame.image.load("bitmaps/enemies/enemigo2_1.png"),
            pygame.image.load("bitmaps/enemies/enemigo2_2.png")
        ]
        super().__init__(images, 184, fps)