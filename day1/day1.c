#include <stdio.h>

int pos_after_op(int pos, char* op) {
	int sign;
	if(op[0] == 'R')
		sign = 1;
	else
		sign = -1;

	int shift = 0;
	++op;
	while(*(op) != '\0' && *op != '\n') {
		int digit = *(op) - '0';

		shift = shift * 10 + digit;
		++op;
	}
	int r = (pos + (shift * sign)) % 100;
	return r < 0 ? r + 100 : r;
}

int main(void) {
	int position = 50;
	int res = 0;
	char operation[6];

	FILE* input = fopen("input.txt", "r");

	while(fgets(operation, sizeof operation, input) != NULL) {
		position = pos_after_op(position, operation);
		if(position == 0) {
			++res;
		}
	}
	printf("%d\n", res);
	return 0;
}




