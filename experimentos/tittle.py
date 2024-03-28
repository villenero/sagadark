import pygame
import sys
import random

# Dimensiones de la ventana del juego
SCREEN_SIZE = (512, 384)
# Colores
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

class Gota:
    def __init__(self, x, y, speed):
        self.x = x
        self.y = y
        self.speed = speed

    def update(self):
        self.y += self.speed
        if self.y > SCREEN_SIZE[1]:
            self.reset()

    def reset(self):
        self.x = random.randint(tittle_rect.left, tittle_rect.right)
        self.y = tittle_rect.bottom
        self.speed = random.randint(1, 10)

    def draw(self, screen):
        pygame.draw.rect(screen, WHITE, (self.x, self.y, 2, 2))

# Inicializar Pygame
pygame.init()
# Crear la ventana del juego
screen = pygame.display.set_mode(SCREEN_SIZE)
pygame.display.set_caption("SAGA DARK FILM")
# Icono de la APP
window_icon = pygame.image.load("bitmaps/icon.png")
pygame.display.set_icon(window_icon)

# Cargar la imágenes del titulo
tittle_image = pygame.image.load("bitmaps/film/tittle.png")
tittle_rect = tittle_image.get_rect(center=(SCREEN_SIZE[0] // 2, 50))

# Obtener las dimensiones de la imagen del título
tittle_width = tittle_image.get_width()
tittle_height = tittle_image.get_height()

# Posición inicial de la caja negra
box_height = 1

# Reloj para controlar la velocidad de fotogramas
clock = pygame.time.Clock()

# Crear una lista para almacenar los pixels
gotas = []

contador = 0
# Bucle principal primera parte de la animación
running = True
while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.KEYDOWN:
            running = False

    # Dibujar el fondo
    screen.fill(BLACK)

    # Crear nuevos pixels
    if len(gotas) < 6:
        x = random.randint(tittle_rect.left, tittle_rect.right)
        y = tittle_rect.bottom
        speed = random.randint(1, 10)
        gota = Gota(x, y, speed)
        gotas.append(gota)

    # Actualizar la posición de los pixels
    for gota in gotas:
        gota.update()

    # Dibujar el logo de título
    screen.blit(tittle_image, tittle_rect)
    # Dibujar los pixels
    for gota in gotas:
        gota.draw(screen)

    # Dibujar la caja negra
    pygame.draw.rect(screen, BLACK, (tittle_rect.left, tittle_rect.top, tittle_width, box_height))

    contador += 1
    if contador > 20:
        # Incrementar la altura de la caja negra
        box_height += 1
        contador = 0

    # Detener la animación cuando la caja alcance la altura del bitmap
    if box_height > tittle_height:
        running = False

    # Limitar la velocidad de fotogramas
    clock.tick(60)

    # Actualizar la pantalla
    pygame.display.flip()

pygame.quit()
sys.exit()