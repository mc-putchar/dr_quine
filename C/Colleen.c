#include <stdio.h>
#define PD(a, b, c) printf("#define %s%c%s%c%s%c", a, 34, b, 34, c, 10)
#define PL(x) printf("%s%c", x, 10)
#define PQ(x) printf("		%c%s%c,%c", 34, x, 34, 10)
#define PQL(x) printf("		%c%s%c%c", 34, x, 34, 10)

/*
	Dr. Quinn: Why can't you accept me for what I am?
*/
void quine(int i_am)
{
	static char const *const	d[] = {
		"PD(a, b, c) printf(",
		"#define %s%c%s%c%s%c",
		", a, 34, b, 34, c, 10)",
		"PL(x) printf(",
		"%s%c",
		", x, 10)",
		"PQ(x) printf(",
		"		%c%s%c,%c",
		", 34, x, 34, 10)",
		"PQL(x) printf(",
		"		%c%s%c%c",
		", 34, x, 34, 10)"
	};

	if (i_am)
	{
		while (++i_am < 4)
			PD(d[i_am * 3], d[i_am * 3 + 1], d[i_am * 3 + 2]);
		return ;
	}
	while (i_am < 11)
		PQ(d[i_am++]);
	PQL(d[i_am]);
}

int main(void)
{
	static char const *const	l[] = {
		"#include <stdio.h>",
		"",
		"/*",
		"	Dr. Quinn: Why can't you accept me for what I am?",
		"*/",
		"void quine(int i_am)",
		"{",
		"	static char const *const	d[] = {",
		"	};",
		"",
		"	if (i_am)",
		"	{",
		"		while (++i_am < 4)",
		"			PD(d[i_am * 3], d[i_am * 3 + 1], d[i_am * 3 + 2]);",
		"		return ;",
		"	}",
		"	while (i_am < 11)",
		"		PQ(d[i_am++]);",
		"	PQL(d[i_am]);",
		"}",
		"",
		"int main(void)",
		"{",
		"	static char const *const	l[] = {",
		"	};",
		"	int							i;",
		"	/*",
		"		Elizabeth Quinn: And what are you?",
		"		You're an unmarried woman,",
		"		trying to raise three children,",
		"		in a shack, in the middle of nowhere...",
		"		and offering your medical services",
		"		to a bunch of back-woodsman,",
		"		who pay you in potatoes and in chickens.",
		"	*/",
		"	i = 0;",
		"	PL(l[i--]);",
		"	quine(i);",
		"	i = 1;",
		"	while (i < 8)",
		"		PL(l[i++]);",
		"	quine(0);",
		"	while (i < 24)",
		"		PL(l[i++]);",
		"	i = 0;",
		"	while (i < 52)",
		"		PQ(l[i++]);",
		"	PQL(l[i]);",
		"	i = 24;",
		"	while (i <= 52)",
		"		PL(l[i++]);",
		"	return (0);",
		"}"
	};
	int							i;
	/*
		Elizabeth Quinn: And what are you?
		You're an unmarried woman,
		trying to raise three children,
		in a shack, in the middle of nowhere...
		and offering your medical services
		to a bunch of back-woodsman,
		who pay you in potatoes and in chickens.
	*/
	i = 0;
	PL(l[i--]);
	quine(i);
	i = 1;
	while (i < 8)
		PL(l[i++]);
	quine(0);
	while (i < 24)
		PL(l[i++]);
	i = 0;
	while (i < 52)
		PQ(l[i++]);
	PQL(l[i]);
	i = 24;
	while (i <= 52)
		PL(l[i++]);
	return (0);
}
