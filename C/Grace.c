#include <fcntl.h>
#include <stdio.h>
/*
	No comment
*/
#define GRACE() int main(){QUINE("#include <fcntl.h>%c#include <stdio.h>%c/*%c	No comment%c*/%c#define GRACE() int main(){QUINE(%s,KID); return 0;}%c#define QUINE(me,to) dprintf(open(to,O_WRONLY|O_CREAT|O_TRUNC,0644),me,10,10,10,10,10,#me,10,10,34,to,34,10,10)%c#define KID %c%s%c%cGRACE()%c",KID); return 0;}
#define QUINE(me,to) dprintf(open(to,O_WRONLY|O_CREAT|O_TRUNC,0644),me,10,10,10,10,10,#me,10,10,34,to,34,10,10)
#define KID "Grace_kid.c"
GRACE()
