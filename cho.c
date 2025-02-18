#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int cho(int argc, char *argv[]) {
	if (argc>1) fputs(argv[1], stdout);
	for (int i=2; i<argc; i++) {
		putchar(' ');
		fputs(argv[i], stdout);
	}
	putchar('\n');
	return 0;
}

int choq(int argc, char *argv[]) {
    for (int i = 1; i < argc; i++) {
        if (i > 1)
            putchar(' ');

        /* Check for any unsafe characters */
        int unsafe = 0;
        for (char *p = argv[i]; *p; p++) {
            if (isspace((unsigned char)*p) ||
                *p == '$' || *p == '`' || *p == '"' ||
                *p == '\'' || *p == '\\') {
                unsafe = 1;
                break;
            }
        }
        
        if (!unsafe) {
            /* Argument is completely safe; output as-is */
            fputs(argv[i], stdout);
        }
        else if (!strchr(argv[i], '\'')) {
            /* Contains unsafe characters but no single quotes; use single quotes */
            putchar('\'');
            fputs(argv[i], stdout);
            putchar('\'');
        }
        else {
            /* Contains single quotes; use double quotes and escape $, \, `, " */
            putchar('"');
            for (char *p = argv[i]; *p; p++) {
                if (*p == '$' || *p == '\\' || *p == '`' || *p == '"')
                    putchar('\\');
                putchar(*p);
            }
            putchar('"');
        }
    }
    putchar('\n');
    return 0;
}

int main(int argc, char *argv[]) {
	const char *prog = argv[0];
	const char *slash = strrchr(prog, '/');
	if (slash) prog = slash + 1;
	if (!strcmp(prog, "choq")) {
		choq(argc, argv);
	} else {
		cho(argc, argv);
	}
	exit(0);
}

