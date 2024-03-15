import pygame

class Player(pygame.sprite.Sprite):
    def __init__(self, x, y, fps):
        super().__init__()
        self.torso_images_right_idle = [
            pygame.image.load("bitmaps/azkar/torso_right_idle_1.png"),
            pygame.image.load("bitmaps/azkar/torso_right_idle_2.png"),
            pygame.image.load("bitmaps/azkar/torso_right_idle_3.png")
        ]
        self.torso_images_left_idle = [
            pygame.image.load("bitmaps/azkar/torso_left_idle_1.png"),
            pygame.image.load("bitmaps/azkar/torso_left_idle_2.png"),
            pygame.image.load("bitmaps/azkar/torso_left_idle_3.png")
        ]
        self.torso_images_right_attack = [
            pygame.image.load("bitmaps/azkar/torso_right_attack_1.png"),
            pygame.image.load("bitmaps/azkar/torso_right_attack_2.png"),
            pygame.image.load("bitmaps/azkar/torso_right_attack_3.png")
        ]
        self.torso_images_left_attack = [
            pygame.image.load("bitmaps/azkar/torso_left_attack_1.png"),
            pygame.image.load("bitmaps/azkar/torso_left_attack_2.png"),
            pygame.image.load("bitmaps/azkar/torso_left_attack_3.png")
        ]
        self.legs_images_right_idle = [
            pygame.image.load("bitmaps/azkar/legs_right_idle.png")
        ]
        self.legs_images_left_idle = [
            pygame.image.load("bitmaps/azkar/legs_left_idle.png")
        ]
        self.legs_images_right_move = [
            pygame.image.load("bitmaps/azkar/legs_right_walk_1.png"),
            pygame.image.load("bitmaps/azkar/legs_right_walk_2.png"),
            pygame.image.load("bitmaps/azkar/legs_right_walk_3.png"),
            pygame.image.load("bitmaps/azkar/legs_right_walk_4.png")
        ]
        self.legs_images_left_move = [
            pygame.image.load("bitmaps/azkar/legs_left_walk_1.png"),
            pygame.image.load("bitmaps/azkar/legs_left_walk_2.png"),
            pygame.image.load("bitmaps/azkar/legs_left_walk_3.png"),
            pygame.image.load("bitmaps/azkar/legs_left_walk_4.png")
        ]
        self.current_torso_image = 0
        self.current_legs_image = 0
        self.torso_image = self.torso_images_right_idle[self.current_torso_image]
        self.legs_image = self.legs_images_right_idle[self.current_legs_image]
        self.rect = self.torso_image.get_rect()
        self.rect.x = x
        self.rect.y = y
        self.speed_x = 0
        self.speed_y = 0
        self.jump_speed = -15
        self.gravity = 0.8
        self.direction = "right"
        self.is_moving = False
        self.is_attacking = False
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

    def attack(self):
        self.is_attacking = True

    def animate(self, dt):
        self.animation_timer += dt
        if self.animation_timer >= 1 / self.fps:
            self.animation_timer = 0
            if self.is_moving:
                if self.direction == "right":
                    self.current_legs_image = (self.current_legs_image + 1) % len(self.legs_images_right_move)
                    self.legs_image = self.legs_images_right_move[self.current_legs_image]
                else:
                    self.current_legs_image = (self.current_legs_image + 1) % len(self.legs_images_left_move)
                    self.legs_image = self.legs_images_left_move[self.current_legs_image]
            else:
                if self.direction == "right":
                    self.legs_image = self.legs_images_right_idle[0]
                else:
                    self.legs_image = self.legs_images_left_idle[0]

            if self.is_attacking:
                if self.direction == "right":
                    self.current_torso_image = (self.current_torso_image + 1) % len(self.torso_images_right_attack)
                    self.torso_image = self.torso_images_right_attack[self.current_torso_image]
                else:
                    self.current_torso_image = (self.current_torso_image + 1) % len(self.torso_images_left_attack)
                    self.torso_image = self.torso_images_left_attack[self.current_torso_image]
                if self.current_torso_image == len(self.torso_images_right_attack) - 1:
                    self.is_attacking = False
            else:
                if self.direction == "right":
                    self.current_torso_image = (self.current_torso_image + 1) % len(self.torso_images_right_idle)
                    self.torso_image = self.torso_images_right_idle[self.current_torso_image]
                else:
                    self.current_torso_image = (self.current_torso_image + 1) % len(self.torso_images_left_idle)
                    self.torso_image = self.torso_images_left_idle[self.current_torso_image]

    def draw(self, screen):
        legs_rect = self.legs_image.get_rect(midbottom=self.rect.midbottom)
        torso_rect = self.torso_image.get_rect(midbottom=legs_rect.midtop)
        screen.blit(self.legs_image, legs_rect)
        screen.blit(self.torso_image, torso_rect)