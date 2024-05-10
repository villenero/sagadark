from pygame import Surface
from settings import *
from settings import TILE_SIZE, Z_LAYERS

class Sprite(pygame.sprite.Sprite):
    def __init__(self, pos, surf = pygame.Surface((TILE_SIZE, TILE_SIZE)), groups = None, z = Z_LAYERS['main']):
        super().__init__(groups)
        self.image = surf
        # self.image.fill('white')
        self.rect = self.image.get_frect(topleft = pos)
        self.old_rect = self.rect.copy()
        self.z = z

class AnimatedSprite(Sprite):
    def __init__(self, pos, frames, groups, z=Z_LAYERS['main'], animation_speed = ANIMATION_SPEED):
        self.frames, self.frames_index = frames, 0
        super().__init__(pos, self.frames[self.frames_index], groups, z)
        self.animation_speed = animation_speed
    
    def animate(self, dt):
        self.frames_index += self.animation_speed * dt
        self.image = self.frames[int(self.frames_index) % len(self.frames)]

    def update(self, dt):
        self.animate(dt)

class MovingSprite(Sprite):
    def __init__(self, groups, start_pos, end_pos, move_dir, speed):
        surf = pygame.Surface((100,25))
        super().__init__(start_pos, surf, groups)
        if move_dir == 'x':
            self.rect.midleft = start_pos
        else:
            self.rect.midtop = start_pos
        self.rect.center = start_pos
        self.start_pos = start_pos
        self.end_pos = end_pos

        # movement
        self.moving = True
        self.speed = speed
        self.direction = vector(1,0) if move_dir == 'x' else vector(0,1)
        self.move_dir = move_dir

    def check_boder(self):
        if self.move_dir == 'x':
            if self.rect.right >= self.end_pos[0] and self.direction.x == 1:
                self.direction.x = -1
                self.rect.right = self.end_pos[0]
            if self.rect.left <= self.start_pos[0] and self.direction.x == -1:
                self.direction.x = 1
                self.rect.left = self.start_pos[0]
        else:
            if self.rect.bottom >= self.end_pos[1] and self.direction.y == 1:
                self.direction.y = -1
                self.rect.bottom = self.end_pos[1]
            if self.rect.top <= self.start_pos[1] and self.direction.y == -1:
                self.direction.y = 1
                self.rect.top = self.start_pos[1]


    def update(self, dt):
        self.old_rect = self.rect.copy()
        self.rect.topleft += self.direction * self.speed * dt
        self.check_boder()