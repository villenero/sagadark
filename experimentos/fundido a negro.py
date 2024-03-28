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

# Cargar la imagen del título
tittle_image = pygame.image.load("bitmaps/film/tittle.png")

# Crear una superficie negra semitransparente para el fundido a negro
fade_surface = pygame.Surface(SCREEN_SIZE)
fade_surface.fill(BLACK)

# Bucle principal primera parte de la animación
running = True
alpha = 0  # Valor inicial de la opacidad

while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Dibujar el fondo
    screen.fill(BLACK)

    # Dibujar el logo de título
    screen.blit(tittle_image, (160, 16))

    # Dibujar la superficie semitransparente para el fundido a negro
    fade_surface.set_alpha(alpha)
    screen.blit(fade_surface, (0, 0))

    # Aumentar gradualmente la opacidad
    alpha += 1
    if alpha > 255:
        alpha = 255

    # Actualizar la pantalla
    pygame.display.flip()

    # Esperar un breve momento para controlar la velocidad del fundido
    pygame.time.delay(20)

# Salir de Pygame
pygame.quit()
sys.exit()