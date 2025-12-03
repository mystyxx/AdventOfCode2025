#include <stdio.h>

int pos_after_op(int pos, char* op, int* res) {
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

	while(shift != 0) {
		if(pos < 0)
			pos += 100;
		if(pos > 99) 
			pos -= 100;
		if(pos == 0)
			++*res;
		pos += sign;
		--shift;
	}
	return pos;
}

int main(void) {
	int position = 50;
	int res = 0;
	char operation[6];

	FILE* input = fopen("input.txt", "r");

	while(fgets(operation, sizeof operation, input) != NULL) {
		position = pos_after_op(position, operation, &res);
	}
	printf("%d\n", res);
	return 0;
}




