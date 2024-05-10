from settings import * 
from os import walk
from os.path import join

def import_image(*path, alpha = True, format = 'png'):
	full_path = join(*path) + f'.{format}'
	return pygame.image.load(full_path).convert_alpha() if alpha else pygame.image.load(full_path).convert()


def import_folder(*path):
    frames = []
    supported_extensions = ['.jpg', '.jpeg', '.png', '.bmp', '.gif']  # Add supported extensions here
    for folder_path, subfolders, image_names in walk(join(*path)):
        # Filter and prepare names for sorting
        filtered_sorted_names = []
        for image_name in image_names:
            if image_name.startswith('.'):
                continue  # Skip files starting with "."

            extension = '.' + image_name.split('.')[-1].lower()
            if extension not in supported_extensions:
                continue  # Skip unsupported file extensions
            
            # Try to extract the number before the dot for sorting
            name_part = image_name.split('.')[0]
            try:
                number = int(name_part)  # Convert to integer if possible
            except ValueError:
                number = 0  # Use 0 or any other default value for non-numeric names
            
            filtered_sorted_names.append((number, image_name))

        # Sort by the extracted number
        filtered_sorted_names.sort()

        # Load images in order
        for _, image_name in filtered_sorted_names:
            full_path = join(folder_path, image_name)
            frames.append(pygame.image.load(full_path).convert_alpha())
    
    return frames


'''
def import_folder(*path):
	frames = []
	supported_extensions = ['.jpg', '.jpeg', '.png', '.bmp', '.gif']  # Agrega las extensiones soportadas aquí
	for folder_path, subfolders, image_names in walk(join(*path)):
		print (folder_path)
		for image_name in sorted(image_names, key=lambda name: int(name.split('.')[0])):
			if image_name.startswith('.'):
				continue  # Saltar archivos que empiezan con "."
			
			extension = '.' + image_name.split('.')[-1].lower()
			if extension not in supported_extensions:
				continue  # Saltar archivos con extensiones no soportadas
			
			full_path = join(folder_path, image_name)
			print(full_path)
			frames.append(pygame.image.load(full_path).convert_alpha())
	return frames
'''
def import_folder_dict(*path):
	frame_dict = {}
	for folder_path, _, image_names in walk(join(*path)):
		for image_name in image_names:
			full_path = join(folder_path, image_name)
			surface = pygame.image.load(full_path).convert_alpha()
			frame_dict[image_name.split('.')[0]] = surface
	return frame_dict

def import_sub_folders(*path):
	frame_dict = {}
	for _, sub_folders, __ in walk(join(*path)): 
		if sub_folders:
			for sub_folder in sub_folders:
				frame_dict[sub_folder] = import_folder(*path, sub_folder)
	return frame_dict