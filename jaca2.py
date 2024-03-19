import pygame

# Inicializar Pygame
pygame.init()

# Dimensiones de la ventana del juego
WIDTH = 512
HEIGHT = 384

# Colores
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

# Clase para representar el personaje
class Character(pygame.sprite.Sprite):
    def __init__(self, x, y, images):
        super().__init__()
        self.images = images
        self.current_image = 0
        self.image = self.images[self.current_image]
        self.rect = self.image.get_rect()
        self.rect.x = x
        self.rect.y = y
        self.speed = 5

    def update(self):
        self.current_image = (self.current_image + 1) % len(self.images)
        self.image = self.images[self.current_image]
        self.rect.x += self.speed

# Clase para representar el fondo (suelo y montañas)
class Background(pygame.sprite.Sprite):
    def __init__(self, x, y, image, speed):
        super().__init__()
        self.image = image
        self.rect = self.image.get_rect()
        self.rect.x = x
        self.rect.y = y
        self.speed = speed

    def update(self):
        self.rect.x -= self.speed
        if self.rect.right < 0:
            self.rect.x = WIDTH

# Función para dibujar texto letra por letra
def draw_text(screen, text, font, color, center_x, center_y, line_spacing=24):
    text_lines = text.split("\n")
    for i, line in enumerate(text_lines):
        text_surface = font.render(line, True, color)
        text_rect = text_surface.get_rect(center=(center_x, center_y + i * line_spacing))
        screen.blit(text_surface, text_rect)

# Función principal del juego
def main():
    # Crear la ventana del juego
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    pygame.display.set_caption("Jaca")

    # Cargar las imágenes del personaje
    character_images = [
        pygame.image.load("bitmaps/jaca/jaca-2x-01.png"),
        pygame.image.load("bitmaps/jaca/jaca-2x-02.png"),
        pygame.image.load("bitmaps/jaca/jaca-2x-03.png"),
        pygame.image.load("bitmaps/jaca/jaca-2x-04.png")
    ]

    # Cargar las imágenes del suelo y las montañas
    ground_image = pygame.image.load("bitmaps/jaca/suelo-2x.png")
    mountains_image = pygame.image.load("bitmaps/jaca/cordillera-2x.png")
    cueva_image = pygame.image.load("bitmaps/jaca/cueva-2x.png")
    pant01_image = pygame.image.load("bitmaps/film/pant-01.png")

    # Cargar el sonido de galope de la jaca
    toc_sound = pygame.mixer.Sound("snds/galop-01.wav")

    # Crear el personaje
    character = Character(0, HEIGHT - 176, character_images)

    # Crear el fondo (suelo y montañas)
    ground = Background(0, HEIGHT - ground_image.get_height() - 32, ground_image, 3)
    mountains = Background(0, 80, mountains_image, 1)

    # Crear los grupos de sprites
    character_group = pygame.sprite.Group(character)
    background_group = pygame.sprite.Group(ground, mountains)

    # Fuente para el texto
    font = pygame.font.Font("font/arcade.otf", 18)

    # Reloj para controlar la velocidad de fotogramas
    clock = pygame.time.Clock()

    # Bucle principal primera parte de la animación
    running = True
    while running:
        # Manejar eventos
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        # Actualizar los sprites
        character_group.update()
        background_group.update()

        # Verificar si el personaje llega al borde
        if character.rect.right > WIDTH:
            running = False

        # Dibujar el fondo
        screen.fill(BLACK)
        background_group.draw(screen)
        character_group.draw(screen)

        # Dibujar el texto letra por letra
        text = "UNA ESBELTA FIGURA AVANZA POR\n LA ARIDEZ DEL DESIERTO."
        draw_text(screen, text, font, WHITE, WIDTH // 2, 144)

        # Reproducir el sonido de galope en el primer frame de cada ciclo de animación
        if character.current_image == 0:
            toc_sound.play(0)

        # Actualizar la pantalla
        pygame.display.flip()
        clock.tick(8)

    # Bucle principal segunda parte de la animación
    running = True
    while running:
        # Manejar eventos
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        # Actualizar los sprites
        character_group.update()

        # Verificar si el personaje llega a la cueva
        if character.rect.right > WIDTH - 60:
            running = False

        # Dibujar el fondo
        screen.fill(BLACK)
        screen.blit(mountains_image, (0, 80))
        screen.blit(ground_image, (0, HEIGHT - ground_image.get_height() - 32))
        screen.blit(cueva_image, (WIDTH - cueva_image.get_width(), 128))
        character_group.draw(screen)

        # Reproducir el sonido de galope en el primer frame de cada ciclo de animación
        if character.current_image == 0:
            toc_sound.play(0)

        # Actualizar la pantalla
        pygame.display.flip()
        clock.tick(12)

    # Empieza la película
    running = True
    while running:
        # Manejar eventos
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        # Dibujar el fondo
        screen.fill(BLACK)
        screen.blit(pant01_image, (0, 0))

        # Dibujar el texto letra por letra
        text = "HIJO MIO... HAN SIDO LARGOS AÑOS\nDE DURO ENTRENAMIENTO, AHORA\n ESCUCHA LA HISTORIA QUE VOY A\n NARRARTE. LUEGO, DE TI DEPENDERÁ"
        draw_text(screen, text, font, WHITE, WIDTH // 2, 272)

        # Actualizar la pantalla
        pygame.display.flip()
        clock.tick(12)

    # Salir del juego
    pygame.quit()

# Ejecutar el juego
if __name__ == "__main__":
    main()