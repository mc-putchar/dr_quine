#include <fcntl.h>
#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>
#define NAME "Sully_X.c"
#define COMP "/usr/bin/cc"
#define OUT "-o"
#define REPL(me,to,w,o,i) do{int f=open(to,O_WRONLY|O_CREAT|O_TRUNC,0444);dprintf(f,me,10,10,10,10,34,to,34,10,#w,34,w,34,10,#o,34,o,34,10,10,i+47,#me,10,10);close(f);}while(0)
#define SULLY() int main(void){int i=5;char n[10]=NAME;char o[10]=NAME;n[6]=i+48;o[6]=i+48;o[7]=0;REPL(\
"#include <fcntl.h>%c#include <stdio.h>%c#include <sys/wait.h>%c#include <unistd.h>%c#define NAME %c%s%c%c#define %s %c%s%c%c#define %s %c%s%c%c\
#define REPL(me,to,w,o,i) do{int f=open(to,O_WRONLY|O_CREAT|O_TRUNC,0444);dprintf(f,me,10,10,10,10,34,to,34,10,#w,34,w,34,10,#o,34,o,34,10,10,i+47,#me,10,10);close(f);}while(0)%c\
#define SULLY() int main(void){int i=%c;char n[10]=NAME;char o[10]=NAME;n[6]=i+48;o[6]=i+48;o[7]=0;REPL(%s\
,n,COMP,OUT,i);if(i&&((!fork()&&execv(COMP,(char *[]){COMP,n,OUT,o,NULL}))||(wait(&i),execv(o,(char *[]){o,NULL}))))return(0);}%c\
SULLY()%c",n,COMP,OUT,i);if(i&&((!fork()&&execv(COMP,(char *[]){COMP,n,OUT,o,NULL}))||(wait(&i),execv(o,(char *[]){o,NULL}))))return(0);}
SULLY()
