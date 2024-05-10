import pygame, sys
from pygame.math import Vector2 as vector

GAME_TITLE = "Saga Dark Py"

# Dimensiones de la ventana del juego
SCREEN_SIZE = WIDTH, HEIGHT = 512, 304
TILE_SIZE = 16 # Tamaño en pixeles de los tiles
TILES_HORIZ = 480 # 15 pantallas a 32 tiles de ancho cada una
TILES_VERT = 19

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

ANIMATION_SPEED = 6

# Layer visibility
Z_LAYERS = {
    'terrain': 0,
    'bg': 1,
    'bg tiles':   2,
    'fg':   7,
    'main': 8,
    'fg2':  10
}