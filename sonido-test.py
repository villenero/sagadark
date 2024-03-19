import pygame

# Inicializar Pygame
pygame.init()

# Cargar el sonido "toc toc"
toc_sound = pygame.mixer.Sound("snds/galop-01.wav")

# Reproducir el sonido "toc toc" en un bucle
toc_sound.play(0)

# Esperar hasta que se pulse una tecla
waiting = True
while waiting:
    for event in pygame.event.get():
        if event.type == pygame.KEYDOWN:
            waiting = False
        elif event.type == pygame.QUIT:
            waiting = False

# Detener el sonido
toc_sound.stop()

# Salir del juego
pygame.quit()