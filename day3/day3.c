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

int max_joltage(char* bank) {
	int i = 0;
	int fst_digit = *bank - '0';
	int fst_index = 0;

	while(*(bank + i + 1) != '\0') {
		if(fst_digit < bank[i] - '0') {
			fst_digit = bank[i] - '0';
			fst_index = i;
		}
		++i;
	}
	int j = 0;
	int snd_digit = *(bank + fst_index + 1) - '0';
	while(*(bank + fst_index + j) != '\0') {
		if(snd_digit < *(bank + fst_index + 1 + j) - '0')
			snd_digit = bank[fst_index + 1 + j] - '0';
		++j;
	}
	return fst_digit * 10 + snd_digit;
}

int main(void) {
	FILE* input = fopen("input.txt", "r");
	int res = 0;
	char bank[200];

	while(fscanf(input, "%s", bank) == 1) {
		res += max_joltage(bank);
	}
	printf("%d\n", res);
	return 0;
}
