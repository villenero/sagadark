import pygame
import sys

# Inicializar Pygame
pygame.init()

# Definir dimensiones de la pantalla
screen_width = 512
screen_height = 304

# Crear la ventana
screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("Animación de bloques")

# Definir colores
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

# Definir dimensiones de los bloques
block_size = 120

# Definir la velocidad de movimiento de los bloques
block_speed = 2

# Definir los mensajes de texto
messages = ["Mensaje 1", "Mensaje 2", "Mensaje 3"]

# Crear una lista para almacenar los bloques
blocks = []

# Crear los bloques y agregarlos a la lista
for i in range(len(messages)):
    block = pygame.Rect(screen_width // 2 - block_size // 2, screen_height + i * block_size, block_size, block_size)
    blocks.append(block)

# Crear una fuente para el texto
font = pygame.font.Font(None, 36)

# Bucle principal del juego
while True:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    # Mover los bloques hacia arriba
    for block in blocks:
        block.move_ip(0, -block_speed)

    # Verificar si los bloques llegaron al centro de la pantalla
    for i, block in enumerate(blocks):
        if block.centery == screen_height // 2:
            # Detener el bloque
            block.move_ip(0, 0)

            # Renderizar el texto correspondiente
            text = font.render(messages[i], True, WHITE)
            text_rect = text.get_rect(center=block.center)
            screen.blit(text, text_rect)

    # Limpiar la pantalla
    screen.fill(BLACK)

    # Dibujar los bloques en la pantalla
    for block in blocks:
        pygame.draw.rect(screen, WHITE, block)

    # Actualizar la pantalla
    pygame.display.flip()

    # Controlar la velocidad de fotogramas
    pygame.time.delay(10)