import pygame
import sys

# Inicializar Pygame
pygame.init()

# Configuración de la ventana
width = 800
height = 600


# Margen entre bloques en pixeles
margin = 0

screen = pygame.display.set_mode((width, height))
pygame.display.set_caption("Visualizador de bloques de memoria")

# Inicializar la fuente
font = pygame.font.SysFont(None, 24)

# Colores
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)

# Tamaño de los bloques y píxeles
BLOCK_SIZE = 16
PIXEL_SIZE = 2

# Ruta del archivo binario ".z80"
file_path = "sdark1.sna"

show_alternate = False

# Busca cadena montaña
sequence = bytes([
    0xFF,
    0x8F,
    0x03,
    0x01,
    0x19,
    0x3F,
    0x7F,
    0x00
])

info_text = "Click en un bloque para ver su contenido"

# Leer el archivo binario
with open(file_path, "rb") as file:
    data = file.read()

# Buscar la secuencia en el volcado de memoria
index = data.find(sequence)

clock = pygame.time.Clock()

if index != -1:
    # Calcular el número de bloques a mostrar
    num_blocks = 32
    num_columns = 6
    num_rows = num_blocks // num_columns
    transpose = False

    # Bucle principal
    running = True
    while running:

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_RIGHT:
                    index += 1
                if event.key == pygame.K_LEFT:
                    index -= 1
                if event.key == pygame.K_DOWN:
                    index += 8 * BLOCK_SIZE
                if event.key == pygame.K_UP:
                    index -= 8 * BLOCK_SIZE
                if event.key == pygame.K_a:
                    num_columns = max(1, num_columns - 1)
                    num_rows = num_blocks // num_columns
                if event.key == pygame.K_d:
                    num_columns += 1
                    num_rows = num_blocks // num_columns
                if event.key == pygame.K_w:
                    num_rows = min(num_blocks, num_rows + 1)
                    num_columns = num_blocks // num_rows
                if event.key == pygame.K_s:
                    num_rows = max(1, num_rows - 1)
                    num_columns = num_blocks // num_rows
                if event.key == pygame.K_r:
                    transpose = not transpose
                if event.key == pygame.K_q:
                    num_blocks -= 1
                if event.key == pygame.K_e:
                    num_blocks += 1
                if event.key == pygame.K_i:
                    show_alternate = not show_alternate
            if event.type == pygame.MOUSEBUTTONDOWN:
                # Obtener la posición del clic del mouse
                mouse_pos = pygame.mouse.get_pos()
                
                # Calcular el índice del bloque en el que se hizo clic
                if transpose:
                    block_x = (mouse_pos[0] - start_x) // (BLOCK_SIZE + margin)
                    block_y = (mouse_pos[1] - start_y) // (BLOCK_SIZE + margin)
                    block_index = block_y * num_columns + block_x
                else:
                    block_x = (mouse_pos[0] - start_x) // (BLOCK_SIZE + margin)
                    block_y = (mouse_pos[1] - start_y) // (BLOCK_SIZE + margin)
                    block_index = block_y * num_columns + block_x
                
                # Verificar si el clic está dentro de los límites de los bloques
                if 0 <= block_index < num_blocks:
                    # Obtener el contenido del bloque en hexadecimal
                    block_data = data[index + block_index * 8: index + (block_index + 1) * 8]
                    block_hex = " 0x".join([f'{byte:02X}' for byte in block_data])
                    # Decodificar los datos del bloque y reemplazar los caracteres nulos
                    block_ascii = block_data.decode('ascii', errors='replace').replace('\x00', '_')
                    
                    # Mostrar el índice y el contenido del bloque en la pantalla
                    mem_pos = hex(index + block_index * 8 + 16384 - 27).upper()
                    mem_pos = mem_pos.replace("0X", "0x")
                    
                    info_text = f"{mem_pos}: 0x{block_hex} | {block_ascii}"
                    print(info_text)
                    
        screen.fill('grey')
        # Renderizar el texto en una superficie
        texto_superficie = font.render(info_text, True, "black")

        # Obtener el rectángulo del texto
        texto_rect = texto_superficie.get_rect()

        # Centrar el texto en la pantalla
        texto_rect.center = (width/2, 100)
        # Dibujar el texto en la pantalla
        screen.blit(texto_superficie, texto_rect)

        # Calcular el tamaño total de la visualización
        display_width = num_columns * (BLOCK_SIZE + margin) - margin
        display_height = num_rows * (BLOCK_SIZE + margin) - margin

        # Calcular la posición de inicio para centrar la visualización
        start_x = (width - display_width) // 2
        start_y = (height - display_height) // 2

        # Dibujar los bloques de memoria
        for i in range(num_blocks):
            if show_alternate:
                block_data = data[index + i * 16: index + (i + 1) * 16]
            else:
                block_data = data[index + i * 8: index + (i + 1) * 8]

            for y in range(8):
                if show_alternate:
                    byte = block_data[y * 2]
                else:
                    byte = block_data[y]
                for x in range(8):
                    pixel_value = (byte >> (7 - x)) & 1
                    color = WHITE if pixel_value == 1 else BLACK

                    if transpose:
                        pixel_rect = pygame.Rect(
                            start_x + (i // num_rows) * (BLOCK_SIZE + margin) + x * PIXEL_SIZE,
                            start_y + (i % num_rows) * (BLOCK_SIZE + margin) + y * PIXEL_SIZE,
                            PIXEL_SIZE,
                            PIXEL_SIZE
                        )
                    else:
                        pixel_rect = pygame.Rect(
                            start_x + (i % num_columns) * (BLOCK_SIZE + margin) + x * PIXEL_SIZE,
                            start_y + (i // num_columns) * (BLOCK_SIZE + margin) + y * PIXEL_SIZE,
                            PIXEL_SIZE,
                            PIXEL_SIZE
                        )

                    pygame.draw.rect(screen, color, pixel_rect)

        pygame.display.flip()
        clock.tick(60)

    pygame.quit()
else:
    print("La secuencia no se encontró en el volcado de memoria.")
    pygame.quit()
    sys.exit()