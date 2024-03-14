import pygame
import random
from player import Player
from plataformas import Platform
from enemy import Enemy1, Enemy2

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
pygame.display.set_caption("Saga Dark Python")

# Cargar la imagen de fondo
background_image = pygame.image.load("bitmaps/fondo.png")

# Crear el personaje
player = Player(width // 2, height - 60, 10)

# Grupo de sprites
all_sprites = pygame.sprite.Group()
all_sprites.add(player)

# Grupo de plataformas
platforms = pygame.sprite.Group()

# Grupo de enemigos
enemies = pygame.sprite.Group()

# Crear plataformas aleatorias
for _ in range(2):
    platform_width = random.randint(50, 100)
    platform_height = 20
    platform_x = random.randint(0, width - platform_width)
    platform_y = random.randint(50, height - 100)
    platform = Platform(platform_x, platform_y, platform_width, platform_height)
    platforms.add(platform)

# Bucle principal del juego
running = True
clock = pygame.time.Clock()

while running:
    dt = clock.tick(60) / 1000  # Calcular el tiempo transcurrido desde el último fotograma

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_LEFT:
                player.move_left()
            elif event.key == pygame.K_RIGHT:
                player.move_right()
            elif event.key == pygame.K_SPACE:
                player.jump()
        elif event.type == pygame.KEYUP:
            if event.key == pygame.K_LEFT and player.speed_x < 0:
                player.stop()
            elif event.key == pygame.K_RIGHT and player.speed_x > 0:
                player.stop()



    # Generar enemigos aleatoriamente
    if random.randint(1, 100) == 1:
        enemy_type = random.choice([Enemy1, Enemy2])
        enemy = enemy_type(10)  # Pasar los fotogramas por segundo deseados
        all_sprites.add(enemy)
        enemies.add(enemy)

    # Actualizar los sprites
    all_sprites.update(dt)

    # Comprobar colisiones con las plataformas
    if pygame.sprite.spritecollide(player, platforms, False):
        player.rect.bottom = pygame.sprite.spritecollide(player, platforms, False)[0].rect.top
        player.speed_y = 0

    # Comprobar colisiones con los enemigos
    if pygame.sprite.spritecollide(player, enemies, False):
        running = False

    # Borrar el fondo antes de dibujar los sprites
    screen.fill(white)
    screen.blit(background_image, (0, 0))

    # Dibujar los sprites
    all_sprites.draw(screen)
    platforms.draw(screen)
    pygame.display.flip()

# Salir del juego
pygame.quit()