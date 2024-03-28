import pygame

class Jaca:
    def __init__(self, screen_size, fps):
        self.screen_size = screen_size
        self.images = self.load_images()
        self.x = 0
        self.y = screen_size[1] - 176
        self.speed = 5
        self.current_image = 0
        self.toc_sound = pygame.mixer.Sound("snds/galop-01.wav")
        self.fps = fps
        self.frame_count = 0

    def load_images(self):
        return [
            pygame.image.load("bitmaps/jaca/jaca-2x-01.png"),
            pygame.image.load("bitmaps/jaca/jaca-2x-02.png"),
            pygame.image.load("bitmaps/jaca/jaca-2x-03.png"),
            pygame.image.load("bitmaps/jaca/jaca-2x-04.png")
        ]

    def update(self):
        self.x += self.speed
        self.frame_count += 1
        if self.frame_count % (60 // self.fps) == 0:
            self.current_image = (self.current_image + 1) % len(self.images)
            if self.current_image == 0:
                self.toc_sound.play(0)

    def draw(self, screen):
        screen.blit(self.images[self.current_image], (self.x, self.y))

    def reset(self):
        self.x = 0
        self.frame_count = 0

    def get_width(self):
        return self.images[0].get_width()