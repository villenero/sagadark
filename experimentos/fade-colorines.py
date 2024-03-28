import pygame
import sys

# Dimensiones de la ventana del juego
SCREEN_SIZE = (512, 384)

# Colores
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
YELLOW = (255, 255, 0)
CYAN = (0, 255, 255)
GREEN = (0, 255, 0)
FUCHSIA = (255, 0, 255)
BLUE = (0, 0, 255)

# Inicializar Pygame
pygame.init()

# Crear la ventana del juego
screen = pygame.display.set_mode(SCREEN_SIZE)
pygame.display.set_caption("SAGA DARK FILM")

# Icono de la APP
window_icon = pygame.image.load("bitmaps/icon.png")
pygame.display.set_icon(window_icon)

# Cargar la imagen del título
tittle_image = pygame.image.load("bitmaps/film/tittle.png")

# Crear una superficie del mismo tamaño que la pantalla
blend_surface = pygame.Surface(SCREEN_SIZE)
blend_surface.set_colorkey((0, 0, 0))
blend_surface.set_alpha(0)

# Variable para controlar la opacidad de la superficie de blending
blend_opacity = 0

# Lista de colores para la animación
colors = [WHITE, YELLOW, CYAN, GREEN, FUCHSIA, BLUE, BLACK]
color_index = 0

# Bucle principal de la animación
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

    # Dibujar la superficie de blending con la opacidad actual
    blend_surface.fill(colors[color_index])
    blend_surface.set_alpha(blend_opacity)
    screen.blit(blend_surface, (0, 0), special_flags=pygame.BLEND_RGB_SUB)

    # Actualizar la opacidad de la superficie de blending
    blend_opacity = (blend_opacity + 1) % 256

    # Cambiar al siguiente color cuando se completa un ciclo de opacidad
    if blend_opacity == 0:
        color_index = (color_index + 1) % len(colors)

    # Actualizar la pantalla
    pygame.display.flip()

pygame.quit()
sys.exit()