from settings import *
from sprites import Sprite, AnimatedSprite, MovingSprite
from player import Player
from groups import AllSprites

class Level:
    def __init__(self, tmx_map, level_frames):
        self.display_surface = pygame.display.get_surface()

        # grupos
        self.all_sprites = AllSprites()
        self.collision_sprites = pygame.sprite.Group()
        self.semi_collision_sprites = pygame.sprite.Group()
        self.setup(tmx_map, level_frames)

    def setup(self, tmx_map, level_frames):

        # tiles
        for layer in ['bg','fg', 'fg2', 'terrain']:
            for x,y, surf in tmx_map.get_layer_by_name(layer).tiles():
                groups = [self.all_sprites]
                if layer == 'terrain': groups.append(self.collision_sprites)
                # if layer == 'fg': groups.append(self.semi_collision_sprites)
                
                match layer:
                     case 'terrain': z = Z_LAYERS['terrain']
                     case 'bg': z = Z_LAYERS['bg tiles']
                     case 'fg': z = Z_LAYERS['fg']
                     case 'fg2': z = Z_LAYERS['fg2']
                     case _: z = Z_LAYERS['main']
                     
                Sprite((x * TILE_SIZE,y * TILE_SIZE), surf, groups, z)

        # objects
        for obj in tmx_map.get_layer_by_name('objects'):
            if (obj.name == 'player'):
                self.player = Player(
                    pos = (obj.x, obj.y),
                    groups = self.all_sprites,
                    collision_sprites = self.collision_sprites,
                    semi_collision_sprites = self.semi_collision_sprites,
                    frames = level_frames['player']
                    )
            else:
                if obj.name in ('aaa'):
                    Sprite((obj.x, obj.y), obj.image, (self.all_sprites, self.collision_sprites))
                else:
                     
                     frames = level_frames[obj.name]
                     AnimatedSprite((obj.x, obj.y), frames, groups)
                    
        # moving objects
        for obj in tmx_map.get_layer_by_name('moving objects'):
            if obj.name == "plataforma":
                if obj.width > obj.height: #plataforma horizontal
                        move_dir = 'x'
                        start_pos = (obj.x, obj.y + obj.height / 2)
                        end_pos = (obj.x + obj.width, obj.y + obj.height / 2)
                else: #plataforma vertical
                        move_dir = 'y'
                        start_pos = (obj.x + obj.width / 2, obj.y)
                        end_pos = (obj.x + obj.width / 2, obj.y + obj.height)
                speed = obj.properties['speed']
                MovingSprite((self.all_sprites, self.semi_collision_sprites), start_pos, end_pos, move_dir, speed)

    def run(self, dt):
        self.display_surface.fill('gray')
        self.all_sprites.update(dt)
        self.all_sprites.draw(self.player.hitbox_rect.center)