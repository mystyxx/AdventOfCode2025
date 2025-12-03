#include <stdio.h>

int str_to_int(char* s) {
	int i = 0;
	int res = 0;
	int digit;
	while(*(s + i) != '\0') {
		int digit = *(s + i) - '0';
		res = res * 10 + digit;
		++i;
	}
	return res;
}

long long max_joltage(char* bank, int n) {
	int i = 0;
	int fst_digit = *bank - '0';
	int prev_index[n];
	prev_index[0] = 0;

	// même fonctionnement mais on commence par aller jusqu'à bank[i + n]
	// ensuite on va chercher le i-ième en commençant par l'index du i-1 -ième

	// on choisit le plus "grand" chiffre en excluant les n-1 derniers
	// (sinon on aurait pas la place)
	while(*(bank + i + n - 1) != '\0') {
		if(fst_digit < bank[i] - '0') {
			fst_digit = bank[i] - '0';
			prev_index[0] = i;
		}
		++i;
	}
	// on choisit le plus "grand" chiffre à droite du précédent
	// tout en excluant les n - k derniers
	for(int k = 1; k < n; ++k) {
		int j = 0;
		int start_index = prev_index[k-1] + 1;
		int snd_digit = bank[start_index] - '0';
		prev_index[k] = start_index;

		while((bank[start_index + j + n - k - 1]) != '\0') {
			if(snd_digit < bank[start_index + j] - '0') {
				snd_digit = bank[start_index + j] - '0';
				prev_index[k] = start_index + j;
			}
			++j;
		}
	}
	

	long long res = 0;
	for(int l = 0; l < n; ++l) {
		res *= 10;
		res += bank[prev_index[l]] - '0';
	}
	//printf("%lld\n", res);
	return res;
}

int main(void) {
	FILE* input = fopen("input.txt", "r");
	long long res = 0;
	char bank[200];

	while(fscanf(input, "%s", bank) == 1) {
		res += max_joltage(bank, 12);
	}
	printf("%lld\n", res);
	return 0;
}
