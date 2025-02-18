#include <stdio.h>

int main(int c, char *a[]) {
	if (c>1) fputs(a[1], stdout);
	for (int i=2; i<c; i++) {
		putchar(' ');
		fputs(a[i], stdout);
	}
	putchar('\n');
}
