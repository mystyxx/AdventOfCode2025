#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define FILE_PATH "test.txt"

int is_in_bounds(int x, int y, int x_max, int y_max) {
	return x >= 0 && y >= 0 && x < x_max && y < y_max;
}

int count_paper_rolls_around(int x, int y, char** grid, int grid_columns, int grid_lines) {
	int res = 0;
	for(int i = y-1; i <= y+1; ++i) {
		for(int j = x-1; j <= x+1; ++j) {
			if(is_in_bounds(j, i, grid_columns, grid_lines))
				res += grid[i][j] == '@';
		}
	}
	return res - (grid[y][x] == '@'); // si on teste autour d'un rouleau, il se compterait lui-même sinon
}

int main(void) {
	
	// obtenir la taille d'une ligne
	FILE* f = fopen(FILE_PATH, "r");	
	char* line = malloc(sizeof(char) * 512);
	fscanf(f, "%s", line);
	fclose(f);

	int columns = strlen(line);
	printf("colonnes : %d\n", columns);
	int lines = 0;
	char** grid = NULL;

	FILE* input = fopen(FILE_PATH, "r");
	char buffer[512];

	// créer la grille
	while(fscanf(input, "%s", buffer) == 1) {
		grid = realloc(grid, sizeof(char*) * (lines + 1));
		grid[lines] = malloc(strlen(buffer) + 1);
		strncpy(grid[lines], buffer, columns);
		++lines;
	}
	int res = 0; int prev_res = -1;
	// ici on va compter les rouleaux
	while(res != prev_res) {
		prev_res = res;
		for(int i = 0; i < lines; ++i) {
			for(int j = 0; j < columns; ++j) {
				if(grid[i][j] == '@') {
					if(count_paper_rolls_around(j, i, grid, columns, lines) < 4) {
						res += 1;
						grid[i][j] = '.';
					}
				}
			}
		}
	}
	printf("%d\n", res);

	fclose(input);
	return 0;
}

