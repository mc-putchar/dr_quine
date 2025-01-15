#include <fcntl.h>
#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>
#define NAME "Sully_X.c"
#define I 5
#define COMP "/usr/bin/cc"
#define OUT "-o"
#define REPL(me,to,w,o,i) do{int f=open(to,O_WRONLY|O_CREAT|O_TRUNC,0444);dprintf(f,me,10,10,10,10,34,to,34,10,i,10,#w,34,w,34,10,#o,34,o,34,10,10,#me,10,10);close(f);}while(0)
#define SULLY() int main(){int i=I;if(i<0)return(0);if(__FILE__[5] == '_')--i;char n[22];char o[20];int l=-1;while(++l<6)n[l]=o[l]=NAME[l];int c=i;l=1;while(c>9){++l;c/=10;}o[6+l]=n[8+l]=0;n[6+l]='.';n[7+l]='c';c=i;while(l--){n[6+l]=o[6+l]=c%10+48;c/=10;}REPL("#include <fcntl.h>%c#include <stdio.h>%c#include <sys/wait.h>%c#include <unistd.h>%c#define NAME %c%s%c%c#define I %i%c#define %s %c%s%c%c#define %s %c%s%c%c#define REPL(me,to,w,o,i) do{int f=open(to,O_WRONLY|O_CREAT|O_TRUNC,0444);dprintf(f,me,10,10,10,10,34,to,34,10,i,10,#w,34,w,34,10,#o,34,o,34,10,10,#me,10,10);close(f);}while(0)%c#define SULLY() int main(){int i=I;if(i<0)return(0);if(__FILE__[5] == '_')--i;char n[22];char o[20];int l=-1;while(++l<6)n[l]=o[l]=NAME[l];int c=i;l=1;while(c>9){++l;c/=10;}o[6+l]=n[8+l]=0;n[6+l]='.';n[7+l]='c';c=i;while(l--){n[6+l]=o[6+l]=c%%10+48;c/=10;}REPL(%s,n,COMP,OUT,i);if(i&&((!fork()&&execv(COMP,(char *[]){COMP,n,OUT,o,NULL}))||(wait(&i),execv(o,(char *[]){o,NULL}))))return(0);}%cSULLY()%c",n,COMP,OUT,i);if(i&&((!fork()&&execv(COMP,(char *[]){COMP,n,OUT,o,NULL}))||(wait(&i),execv(o,(char *[]){o,NULL}))))return(0);}
SULLY()
