import pygame

# Inicializar Pygame
pygame.init()

# Dimensiones de la ventana del juego
width = 512
height = 384

# Colores
white = (255, 255, 255)
black = (0, 0, 0)

# Crear la ventana del juego
screen = pygame.display.set_mode((width, height))
pygame.display.set_caption("Jaca")

# Reloj para controlar la velocidad de fotogramas
clock = pygame.time.Clock()

# Fuente para el texto
font = pygame.font.Font("font/arcade.otf", 18)

# Cargar el sonido del teclado
tap_sound = pygame.mixer.Sound("snds/tap.wav")

# Unificar los textos en una sola variable con el código de escape "\p"
text = "HIJO MIO... HAN SIDO LARGOS AÑOS\nDE DURO ENTRENAMIENTO, AHORA\nESCUCHA LA HISTORIA QUE VOY A\nNARRARTE. LUEGO, DE TI DEPENDERÁ#" \
       "MI FUTURO... Y EL DE LO QUE\nQUE QUEDA DE HUMANIDAD.#" \
       "HACE MUCHOS AÑOS EN ESTE MALDITO\nPLANETA EXISTIÓ UNA GRAN CULTURA\nNUESTROS ANTEPASADOS VIVÍAN EN\nGIGANTESCAS CONSTRUCCIONES QUE"

text_index = 0
current_text = ""

def print_text(text):
    global text_index, current_text
    if text_index < len(text):
        if text[text_index] == "#":
            current_text = ""
            text_index += 1
            # screen.fill(black)  # Borrar los textos ya impresos
            pygame.display.update()
        else:
            current_text += text[text_index]
            text_index += 1
            tap_sound.play(0)
    else:
        text_index = 0
        current_text = ""

    text_lines = current_text.split("\n")
    for i, line in enumerate(text_lines):
        text_surface = font.render(line, True, white)
        text_rect = text_surface.get_rect(center=(width // 2, 272 + i * 24))
        screen.blit(text_surface, text_rect)

running = True
while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Dibujar el fondo
    screen.fill(black)

    # Imprimir el texto en pantalla
    print_text(text)

    # Actualizar la pantalla
    pygame.display.flip()

    # Limitar la velocidad de fotogramas
    clock.tick(12)

# Salir del juego
pygame.quit()