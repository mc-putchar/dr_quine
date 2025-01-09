#include <fcntl.h>
#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>
#define NAME "Sully_X.c"
#define I 5
#define COMP "/usr/bin/cc"
#define OUT "-o"
#define REPL(me,to,w,o,i) do{int f=open(to,O_WRONLY|O_CREAT|O_TRUNC,0444);dprintf(f,me,10,10,10,10,34,to,34,10,i,10,#w,34,w,34,10,#o,34,o,34,10,10,i+48,#me,10,10);close(f);}while(0)
#define SULLY() int main(){int i=I;if(__FILE__[5] == '_')--i;char n[22]=NAME;char o[20]=NAME;int l=1;int c=i;while(c>9){++l;c/=10;}c=-1;while(++c<l){n[6+c]=o[6+c]=i%10+48;i/=10;}o[6+c]=0;n[6+c]='.';n[c+7]='c';n[c+8]=0;REPL(\
"#include <fcntl.h>%c#include <stdio.h>%c#include <sys/wait.h>%c#include <unistd.h>%c#define NAME %c%s%c%c#define I %d%c#define %s %c%s%c%c#define %s %c%s%c%c\
#define REPL(me,to,w,o,i) do{int f=open(to,O_WRONLY|O_CREAT|O_TRUNC,0444);dprintf(f,me,10,10,10,10,34,to,34,10,i,10,#w,34,w,34,10,#o,34,o,34,10,10,i+48,#me,10,10);close(f);}while(0)%c\
#define SULLY() int main(void){int i=I;if(__FILE__[5] == '_')--i;char n[22]=NAME;char o[20]=NAME;int l=1;int c=i;while(c>9){++l;c/=10;}c=-1;while(++c<l){n[6+c]=o[6+c]=i%10+48;i/=10;}o[6+c]=0;n[6+c]='.';n[c+7]='c';n[c+8]=0;REPL(%s\
,n,COMP,OUT,i);if(i&&((!fork()&&execv(COMP,(char *[]){COMP,n,OUT,o,NULL}))||(wait(&i),execv(o,(char *[]){o,NULL}))))return(0);}%c\
SULLY()%c",n,COMP,OUT,i);if(i&&((!fork()&&execv(COMP,(char *[]){COMP,n,OUT,o,NULL}))||(wait(&i),execv(o,(char *[]){o,NULL}))))return(0);}
SULLY()
