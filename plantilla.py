import pygame
import sys

# Dimensiones de la ventana del juego
SCREEN_SIZE = (512, 384)

# Colores
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

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

# Bucle principal primera parte de la animación
running = True
while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        
    # Dibujar el fondo
    screen.fill(BLACK)

    # Dibujar el logo de título
    screen.blit(tittle_image, (160, 16))

    # Actualizar la pantalla
    pygame.display.flip()
