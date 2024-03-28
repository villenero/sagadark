import pygame
import sys, random
from guion import guion
from jaca import Jaca
from nave import Nave1, Nave2

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

# Cargar las imágenes del suelo y las montañas
ground_image = pygame.image.load("bitmaps/jaca/suelo-2x.png")
mountains_image = pygame.image.load("bitmaps/jaca/cordillera-2x.png")
cueva_image = pygame.image.load("bitmaps/jaca/cueva-2x.png")

# Cargar la imágenes del titulo
tittle_image = pygame.image.load("bitmaps/film/tittle.png")
tittle_rect = tittle_image.get_rect(center=(SCREEN_SIZE[0] // 2, 50))

# Obtener las dimensiones de la imagen del título
tittle_width = tittle_image.get_width()
tittle_height = tittle_image.get_height()

# Posición inicial de la caja negra que borra el título
box_height = 1

# Crear una lista para almacenar los pixels de la lluvia
gotas = []

# Reloj para controlar la velocidad de fotogramas
clock = pygame.time.Clock()
contador = 0

# Pantalla de Titulo con lluvia
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
    if len(gotas) < 8:
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

# Fundido a negro
fade_surface = pygame.Surface(SCREEN_SIZE)
fade_surface.fill(BLACK)
alpha = 0
retardo = 0
running = True
while running:
    if retardo > 3: # condición cutre para que no haga el fade tan rápido
        retardo = 0
        fade_surface.set_alpha(alpha)
        screen.blit(fade_surface, (0, 0))

        # Aumentar gradualmente la opacidad
        alpha += 1
        if alpha > 255:
            running = False

        # Actualizar la pantalla
        pygame.display.flip()
    else:
        retardo += 1


# Empieza la película
# Crear instancias de las clases Nave1 y Nave2 con 12 FPS
nave1 = Nave1(12)
nave2 = Nave2(12)

film_pantallas = [
    pygame.image.load("bitmaps/film/pant-01.png"),
    pygame.image.load("bitmaps/film/pant-02.png"),
    pygame.image.load("bitmaps/film/pant-03.png"),
    pygame.image.load("bitmaps/film/pant-04.png"),
    pygame.image.load("bitmaps/film/pant-05.png"),
    pygame.image.load("bitmaps/film/pant-06.png"),
    pygame.image.load("bitmaps/film/pant-07.png"),
    pygame.image.load("bitmaps/film/pant-08.png"),
    pygame.image.load("bitmaps/film/pant-09.png"),
    pygame.image.load("bitmaps/film/pant-01.png")
]

pant01_02_image = pygame.image.load("bitmaps/film/pant-01-02.png")

# Cargar el sonido del teclado
tap_sound = pygame.mixer.Sound("snds/tap.wav")

# Posición inicial del suelo y las montañas
ground_x = 0
mountains_x = 0

# Posición inicial de las naves de la pantalla 2
nave1_x = 0
nave2_x = 450

# Velocidad de desplazamiento del suelo y montañas
ground_speed = 3
mountains_speed = 1

# Texto a mostrar
text = "UNA ESBELTA FIGURA AVANZA POR\n LA ARIDEZ DEL DESIERTO."

# Índice de la letra actual del texto
text_index = 0

# Fuente para el texto
font = pygame.font.Font("font/arcade.otf", 18)

# Crear una instancia de la clase Jaca con 8 FPS
jaca = Jaca(SCREEN_SIZE, 60)

# Bucle principal primera parte de la animación
running = True
while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Actualizar la posición del personaje
    jaca.update()

    # Si llega al borde se para
    if jaca.x > SCREEN_SIZE[0] - jaca.get_width():
        running = False

    # Actualizar la posición del suelo
    ground_x -= ground_speed
    if ground_x < -ground_image.get_width():
        ground_x = 0

    # Actualizar la posición de las montañas
    mountains_x -= mountains_speed
    if mountains_x < -mountains_image.get_width():
        mountains_x = 0

    # Dibujar el fondo
    screen.fill(BLACK)

    # Dibujar las montañas por duplicado para el scroll
    screen.blit(mountains_image, (mountains_x, 80))
    screen.blit(mountains_image, (mountains_x + mountains_image.get_width(), 80))

    # Dibujar el suelo por duplicado para scroll
    screen.blit(ground_image, (ground_x, SCREEN_SIZE[1] - ground_image.get_height() - 32))
    screen.blit(ground_image, (ground_x + ground_image.get_width(), SCREEN_SIZE[1] - ground_image.get_height() - 32))

    # Dibujar el personaje
    jaca.draw(screen)

    # Dibujar el texto letra por letra
    text_lines = text[:text_index].split("\n")
    for i, line in enumerate(text_lines):
        text_surface = font.render(line, True, WHITE)
        text_rect = text_surface.get_rect(center=(SCREEN_SIZE[0] // 2, 144 + i * 24))
        screen.blit(text_surface, text_rect)

    # Actualizar el índice de la letra actual
    if text_index < len(text):
        text_index += 1

    # Actualizar la pantalla
    pygame.display.flip()

    # Limitar la velocidad de fotogramas
    clock.tick(10)

# Bucle principal segunda parte de la animación
running = True
# Posición inicial del personaje, suelo y las montañas
jaca.reset()
ground_x = mountains_x = 0

while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Actualizar la posición del personaje
    jaca.update()

    # Si llega a la cueva se para
    if jaca.x > SCREEN_SIZE[0] - jaca.get_width() - 60:
        running = False

    # Dibujar el fondo
    screen.fill(BLACK)

    # Dibujar las montañas
    screen.blit(mountains_image, (mountains_x, 80))

    # Dibujar el suelo
    screen.blit(ground_image, (ground_x, SCREEN_SIZE[1] - ground_image.get_height() - 32))

    # Dibujar la cueva
    screen.blit(cueva_image, (SCREEN_SIZE[0] - cueva_image.get_width(), 128))

    # Dibujar el personaje
    jaca.draw(screen)

    # Actualizar la pantalla
    pygame.display.update()

    # Limitar la velocidad de fotogramas
    clock.tick(12)


# Empieza la película
pausar_film = False

# Función que imprime los textos de la película
# retorna -1 si se llaga al final de la cadena.
def print_text(text):
    global pausar_film, text_index, current_text
    if text_index < len(text):
        if text[text_index] == "#":  # caracter '#' indica que cambiamos de página de texto y borra la anterior.
            current_text = ""  # Borrar los textos ya impresos
        else:
            current_text += text[text_index]
            tap_sound.play(0)
    else:
        # llegamos al final de texto
        text_index = 0
        current_text = ""
        return -1

    if not pausar_film:
        text_lines = current_text.split("\n")
        for i, line in enumerate(text_lines):
            text_surface = font.render(line, True, WHITE)
            text_rect = text_surface.get_rect(center=(SCREEN_SIZE[0] // 2, 272 + i * 24))
            screen.blit(text_surface, text_rect)
        text_index += 1
    else:
        return 0

# Índice de la letra actual del texto
text_index = 0
running = True
current_text = ""
current_screen = 0

# Dibujar el fondo
screen.fill(BLACK)
current_image = 0

while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Dibujar el fondo
    screen.fill(BLACK)

    # Dibujar la pantalla 1
    screen.blit(film_pantallas[current_screen], (0, 0))

    if current_screen == 0 or current_screen == 9:
        current_image += 1
        if current_image != 1:
            screen.blit(pant01_02_image, (0, 0))
            current_image = 0

    if current_screen == 1:
        # Naves para la pantalla 2
        # Actualizar la posición de las naves
        nave1.update()
        nave2.update()

        # Dibuja las naves
        nave1.draw(screen)
        nave2.draw(screen)

    if print_text(guion[current_screen]) == -1:
        current_screen += 1

    # Actualizar la pantalla
    pygame.display.flip()

    # Limitar la velocidad de fotogramas
    clock.tick(15)

# Salir del juego
pygame.quit()