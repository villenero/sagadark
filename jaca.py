import pygame

# Inicializar Pygame
pygame.init()

# Dimensiones de la ventana del juego
width = 512
height = 304

# Colores
white = (255, 255, 255)
black = (0, 0, 0)

# Crear la ventana del juego
screen = pygame.display.set_mode((width, height))
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

# Cargar el sonido de galope de la jaca
toc_sound = pygame.mixer.Sound("snds/galop-01.wav")

# Posición inicial del personaje
character_x = 0
character_y = height - 144

# Posición inicial del suelo y las montañas
ground_x = 0
mountains_x = 0

# Velocidad de desplazamiento del personaje, suelo y montañas
character_speed = 5
ground_speed = 3
mountains_speed = 1

# Índice de la imagen actual del personaje
current_image = 0

# Reloj para controlar la velocidad de fotogramas
clock = pygame.time.Clock()

# Texto a mostrar
text = "UNA ESBELTA FIGURA AVANZA POR\n LA ARIDEZ DEL DESIERTO."

# Índice de la letra actual del texto
text_index = 0

# Fuente para el texto
font = pygame.font.Font("font/arcade.otf", 18)

# Bucle principal primera parte de la animación
running = True
while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Actualizar la posición del personaje
    character_x += character_speed

    # Si llega al borde se para
    if character_x > width - character_images[0].get_width():
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
    screen.fill(black)

    # Dibujar las montañas
    screen.blit(mountains_image, (mountains_x, 40))
    screen.blit(mountains_image, (mountains_x + mountains_image.get_width(), 40))

    # Dibujar el suelo
    screen.blit(ground_image, (ground_x, height - ground_image.get_height()))
    screen.blit(ground_image, (ground_x + ground_image.get_width(), height - ground_image.get_height()))

    # Dibujar el personaje
    screen.blit(character_images[current_image], (character_x, character_y))

    # Actualizar el índice de la imagen del personaje
    current_image = (current_image + 1) % len(character_images)
    if current_image == 0:
        # Reproducir el sonido de galope en el primer frame de cada ciclo de animación
        toc_sound.play(0)

    # Dibujar el texto letra por letra
    text_lines = text[:text_index].split("\n")
    for i, line in enumerate(text_lines):
        text_surface = font.render(line, True, white)
        text_rect = text_surface.get_rect(center=(width // 2, 100 + i * 24)) # height // 2 + i * 24))
        screen.blit(text_surface, text_rect)

    # Actualizar el índice de la letra actual
    if text_index < len(text):
        text_index += 1

    # Actualizar la pantalla
    pygame.display.flip()

    # Limitar la velocidad de fotogramas
    clock.tick(8)

# Bucle principal segunda parte de la animación
running = True
character_x = 0
while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Actualizar la posición del personaje
    character_x += character_speed

    # Si llega a la cueva se para
    if character_x > width - character_images[0].get_width() - 60:
        running = False

    # Dibujar el fondo
    screen.fill(black)

    # Dibujar las montañas
    screen.blit(mountains_image, (mountains_x, 40))
    screen.blit(mountains_image, (mountains_x + mountains_image.get_width(), 40))

    # Dibujar el suelo
    screen.blit(ground_image, (ground_x, height - ground_image.get_height()))
    screen.blit(ground_image, (ground_x + ground_image.get_width(), height - ground_image.get_height()))
    
    # Dibujar la cueva
    screen.blit(cueva_image, (width - cueva_image.get_width(), 80))

    # Dibujar el personaje
    screen.blit(character_images[current_image], (character_x, character_y))

    # Actualizar el índice de la imagen del personaje
    current_image = (current_image + 1) % len(character_images)
    if current_image == 0:
        # Reproducir el sonido de galope en el primer frame de cada ciclo de animación
        toc_sound.play(0)

    # Actualizar la pantalla
    pygame.display.flip()

    # Limitar la velocidad de fotogramas
    clock.tick(12)

# Salir del juego
pygame.quit()