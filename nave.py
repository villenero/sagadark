import pygame

class Nave:
    def __init__(self, image_path, x, y, speed, fps):
        self.image = pygame.image.load(image_path)
        self.x = x
        self.y = y
        self.speed = speed
        self.fps = fps
        self.frame_count = 0

    def update(self):
        self.x += self.speed
        self.frame_count += 1
        if self.frame_count % (60 // self.fps) == 0:
            self.frame_count = 0

    def draw(self, screen):
        screen.blit(self.image, (self.x, self.y))

class Nave1(Nave):
    def __init__(self, fps):
        super().__init__("bitmaps/film/pant-02-nave-01.png", 0, 18, 5, fps)

class Nave2(Nave):
    def __init__(self, fps):
        super().__init__("bitmaps/film/pant-02-nave-02.png", 450, 0, -2, fps)