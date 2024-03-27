import pygame, sys
# Dimensiones de la ventana del juego
screen_size = (512, 384)

# Colores
white = (255, 255, 255)
black = (0, 0, 0)

# Inicializar Pygame
pygame.init()


# Crear la ventana del juego
screen = pygame.display.set_mode(screen_size)
pygame.display.set_caption("SAGA DARK FILM")

# Icono de la APP
window_icon = pygame.image.load("bitmaps/icon.png")
pygame.display.set_icon(window_icon)

# Cargar las imágenes del personaje
jaca_images = [
    pygame.image.load("bitmaps/jaca/jaca-2x-01.png"),
    pygame.image.load("bitmaps/jaca/jaca-2x-02.png"),
    pygame.image.load("bitmaps/jaca/jaca-2x-03.png"),
    pygame.image.load("bitmaps/jaca/jaca-2x-04.png")
]

# Cargar las imágenes del suelo y las montañas
ground_image = pygame.image.load("bitmaps/jaca/suelo-2x.png")
mountains_image = pygame.image.load("bitmaps/jaca/cordillera-2x.png")
cueva_image = pygame.image.load("bitmaps/jaca/cueva-2x.png")

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
pant02_nave1 = pygame.image.load("bitmaps/film/pant-02-nave-01.png")
pant02_nave2 = pygame.image.load("bitmaps/film/pant-02-nave-02.png")

# Cargar el sonido de galope de la jaca
toc_sound = pygame.mixer.Sound("snds/galop-01.wav")

# Cargar el sonido del teclado
tap_sound = pygame.mixer.Sound("snds/tap.wav")

# Posición inicial del personaje
character_x = 0
character_y = screen_size[1] - 176

# Posición inicial del suelo y las montañas
ground_x = 0
mountains_x = 0

# Posición inicial de las naves de la pantalla 2
nave1_x = 0
nave2_x = 450

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

# Textos a mostrar, hay una variable por cada pantalla. El caracter "#"" se usa para indicar cambio de página.
guion = [
    "HIJO MIO... HAN SIDO LARGOS AÑOS\nDE DURO ENTRENAMIENTO, AHORA\nESCUCHA LA HISTORIA QUE VOY A\nNARRARTE. LUEGO, DE TI DEPENDERÁ#" \
    "MI FUTURO... Y EL DE LO QUE\nQUE QUEDA DE HUMANIDAD.#",

    "HACE MUCHOS AÑOS EN ESTE MALDITO\nPLANETA EXISTIÓ UNA GRAN CULTURA\nNUESTROS ANTEPASADOS VIVÍAN EN\nGIGANTESCAS CONSTRUCCIONES QUE#" \
    "LLEGABAN AL CIELO, PERO LA\nCODICIA DE ESTOS LES CONDUJO A\nSU PROPIA EXTINCIÓN.#",

    "GIGANTESCOS ÁRBOLES DE FUEGO,\nACABARON CON LA BRILLANTE\nCIVILIZACIÓN. LOS GRANDES ÁRBOLES\nTRANSFORMARON EN CENIZAS#" \
    "CONSTRUCCIONES, HOMBRES Y\nANIMALES POR IGUAL#",

    "SOLO UNOS POCOS SOBREVIVIERON,\nAQUELLOS ELEGIDOS EMPRENDIERON\nUNA DIFÍCIL TAREA E INTENTARON\nVOLVER A SER COMO ERAN, PERO...#" \
    "JAMAS LO CONSIGUIERON.\nLAS EPIDEMIAS SE SUCEDIERON Y\nDIEZMARON AUN MÁS A LA YA AZOTADA\nCIVILIZACIÓN#",

    "LOS REMOTOS Y OLVIDADOS TIEMPOS\nDE BRUJOS, DRAGONES Y HECHIZEROS\nREGRESARON. FUE ENTONCES CUANDO\nAPARECIÓN EL PRIMER -DARK-#" \
    "ESTE NO TARDÓ EN RECLUTAR Y\nADIESTRAR FUERTES Y MALÉVOLOS\nSERES.#",

    "EL Y SU TROPA SAQUEARON, MATARON\nY VIOLARON A LOS INDEFENSOS\nHABITANTES DE LOS POBLADOS\nPOR DONDE PASABAN .#" \
    "PRIMERO FUERON LAS ALDEAS DE LA\nCOSTA Y DESPUÉS LAS DEL INTERIOR\nTODOS ERAN SOMETIDOS BAJO SU\nCRUEL Y SANGRIENTA MIRADA.#",

    "KAMUIR, EL SEGUNDO -DARK-, NO SE\nHIZO ESPERAR, TRAS LA MUERTE DE\nSU PADRE SAQUEÓ NUESTRO POBLADO\nY SEGÓ LA VIDAD DE MI FAMILIA.#" \
    "CON FRIA SONRISA LENTAMENTE BAJÓ\nSU CABEZA Y ME MIRÓ, YO PORTABA\nEN MIS BRAZOS EL LIBRO MÍSTICO\nEL CONTENIDO DE ESE LIBRO LO ERA#" \
    "TODO PARA MI. ERA MI PROTECTOR\nCONTRA LAS FUERZAS OCULTAS DE\nLAS TINIEBLAS. PUDE ESCAPAR DE\nAQUEL INFIERNO.#",

    "ESTUVE AL BORDE DE LA MUERTE EN\nVARIAS OCASIONES, PERO PUDE\nALCANZAR UN FOCO DE CIVILIZACIÓN\nALEJADO DE LA DESOLACIÓN.#" \
    "PASARON LOS AÑOS Y CUANDO TODO\nERA RECORDADO COMO UNA LEJANA\nPESADILLA, KAMUIR REGRESÓ CON\nSU ODIO HACIA TODO LO VIVO.#",

    "POR SEGUNDA VEZ DESTRUYÓ TODO\nAQUELLO POR LO QUE YO HABÍA\nLUCHADO, MI FAMILIA Y MI LIBRO\nDEL CUAL SE APODERÓ#",

    "FUE SOBRE LA TUMBA DE TU MADRE\nDONDE YO JURÉ VENGANZA, Y AHORA\nTÚ SERÁS EL ENCARGADO DE\nLLEVARLA A CABO.#"
]

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
    if character_x > screen_size[0] - jaca_images[0].get_width():
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

    # Dibujar las montañas por duplicado para el scroll
    screen.blit(mountains_image, (mountains_x, 80))
    screen.blit(mountains_image, (mountains_x + mountains_image.get_width(), 80))

    # Dibujar el suelo por duplicado para scroll
    screen.blit(ground_image, (ground_x, screen_size[1] - ground_image.get_height() - 32))
    screen.blit(ground_image, (ground_x + ground_image.get_width(), screen_size[1] - ground_image.get_height() - 32))

    # Dibujar el personaje
    screen.blit(jaca_images[current_image], (character_x, character_y))

    # Actualizar el índice de la imagen del personaje
    current_image = (current_image + 1) % len(jaca_images)
    if current_image == 0:
        # Reproducir el sonido de galope en el primer frame de cada ciclo de animación
        toc_sound.play(0)

    # Dibujar el texto letra por letra
    text_lines = text[:text_index].split("\n")
    for i, line in enumerate(text_lines):
        text_surface = font.render(line, True, white)
        text_rect = text_surface.get_rect(center=(screen_size[0] // 2, 144 + i * 24)) # height // 2 + i * 24))
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

# Posición inicial del personaje, suelo y las montañas
character_x = ground_x = mountains_x = 0

while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Actualizar la posición del personaje
    character_x += character_speed

    # Si llega a la cueva se para
    if character_x > screen_size[0] - jaca_images[0].get_width() - 60:
        running = False

    # Dibujar el fondo
    screen.fill(black)

    # Dibujar las montañas
    screen.blit(mountains_image, (mountains_x, 80))

    # Dibujar el suelo
    screen.blit(ground_image, (ground_x, screen_size[1] - ground_image.get_height() - 32))
    
    # Dibujar la cueva
    screen.blit(cueva_image, (screen_size[0] - cueva_image.get_width(), 128))

    # Dibujar el personaje
    screen.blit(jaca_images[current_image], (character_x, character_y))

    # Actualizar el índice de la imagen del personaje
    current_image = (current_image + 1) % len(jaca_images)
    if current_image == 0:
        # Reproducir el sonido de galope en el primer frame de cada ciclo de animación
        toc_sound.play(0)

    # Actualizar la pantalla
    pygame.display.update()

    # Limitar la velocidad de fotogramas
    clock.tick(12)

# Función que imprime los textos de la película
# retorna -1 si se llaga al final de la cadena.

# Empieza la película
pausar_film = False

def print_text(text):
    global pausar_film, text_index, current_text

    if text_index < len(text):
        
        if text[text_index] == "#": # caracter '#' indica que cambiamos de página de texto y borra la anterior.
            # pausar_film = True
            current_text = "" # Borrar los textos ya impresos
        else:
            current_text += text[text_index]
            tap_sound.play(0)

    else:
        # llegamos al final de texto
        text_index = 0
        current_text = ""
        return -1

    if pausar_film == False:
        text_lines = current_text.split("\n")
        for i, line in enumerate(text_lines):
            text_surface = font.render(line, True, white)
            text_rect = text_surface.get_rect(center=(screen_size[0] // 2, 272 + i * 24))
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
screen.fill(black)

current_image = 0


while running:
    # Manejar eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
    
    # Dibujar el fondo
    screen.fill(black)
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
        nave1_x += 5
        nave2_x -= 2
        # Dibuja las naves
        screen.blit(pant02_nave1, (nave1_x, 18))
        screen.blit(pant02_nave2, (nave2_x, 0))

    if print_text(guion[current_screen]) == -1:
        current_screen += 1

    # Actualizar la pantalla
    pygame.display.flip()

    # Limitar la velocidad de fotogramas
    clock.tick(15)

# Salir del juego
pygame.quit()