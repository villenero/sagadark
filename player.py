import pygame

class Player(pygame.sprite.Sprite):
    def __init__(self, x, y, fps):
        super().__init__()
        self.images_right_idle = [
            pygame.image.load("bitmaps/azkar/personaje_right_idle_1.png"),
            pygame.image.load("bitmaps/azkar/personaje_right_idle_2.png"),
            pygame.image.load("bitmaps/azkar/personaje_right_idle_3.png"),
            pygame.image.load("bitmaps/azkar/personaje_right_idle_4.png"),
            pygame.image.load("bitmaps/azkar/personaje_right_idle_5.png")
        ]
        self.images_left_idle = [
            pygame.image.load("bitmaps/azkar/personaje_left_idle_1.png"),
            pygame.image.load("bitmaps/azkar/personaje_left_idle_2.png"),
            pygame.image.load("bitmaps/azkar/personaje_left_idle_3.png"),
            pygame.image.load("bitmaps/azkar/personaje_left_idle_4.png"),
            pygame.image.load("bitmaps/azkar/personaje_left_idle_5.png")
        ]
        self.images_right_move = [
            pygame.image.load("bitmaps/azkar/personaje_right_move_1.png"),
            pygame.image.load("bitmaps/azkar/personaje_right_move_2.png"),
            pygame.image.load("bitmaps/azkar/personaje_right_move_3.png"),
            pygame.image.load("bitmaps/azkar/personaje_right_move_4.png")
        ]
        self.images_left_move = [
            pygame.image.load("bitmaps/azkar/personaje_left_move_1.png"),
            pygame.image.load("bitmaps/azkar/personaje_left_move_2.png"),
            pygame.image.load("bitmaps/azkar/personaje_left_move_3.png"),
            pygame.image.load("bitmaps/azkar/personaje_left_move_4.png")
        ]
        self.current_image = 0
        self.image = self.images_right_idle[self.current_image]
        self.rect = self.image.get_rect()
        self.rect.x = x
        self.rect.y = y
        self.speed_x = 0
        self.speed_y = 0
        self.jump_speed = -15
        self.gravity = 0.8
        self.direction = "right"
        self.is_moving = False
        self.fps = fps
        self.animation_timer = 0

    def update(self, dt):
        self.speed_y += self.gravity
        self.rect.x += self.speed_x
        self.rect.y += self.speed_y

        if self.rect.bottom >= 264:
            self.rect.bottom = 264
            self.speed_y = 0

        if self.rect.left < 0:
            self.rect.left = 0
        elif self.rect.right > 512:
            self.rect.right = 512

        self.animate(dt)

    def move_left(self):
        self.speed_x = -5
        self.direction = "left"
        self.is_moving = True

    def move_right(self):
        self.speed_x = 5
        self.direction = "right"
        self.is_moving = True

    def stop(self):
        self.speed_x = 0
        self.is_moving = False

    def jump(self):
        self.speed_y = self.jump_speed

    def animate(self, dt):
        self.animation_timer += dt
        if self.animation_timer >= 1 / self.fps:
            self.animation_timer = 0
            if self.is_moving:
                if self.direction == "right":
                    self.current_image = (self.current_image + 1) % len(self.images_right_move)
                    self.image = self.images_right_move[self.current_image]
                else:
                    self.current_image = (self.current_image + 1) % len(self.images_left_move)
                    self.image = self.images_left_move[self.current_image]
            else:
                if self.direction == "right":
                    self.current_image = (self.current_image + 1) % len(self.images_right_idle)
                    self.image = self.images_right_idle[self.current_image]
                else:
                    self.current_image = (self.current_image + 1) % len(self.images_left_idle)
                    self.image = self.images_left_idle[self.current_image]