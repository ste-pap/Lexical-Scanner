
%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
FILE *fout;
%}


%%

for {fprintf(fout,"for_loop : %s\n",yytext);}
while {fprintf(fout,"while_loop : %s\n",yytext);}
#include {fprintf(fout,"include library macro : %s\n",yytext);}
int {fprintf(fout,"Integers type : %s\n",yytext);}
double {fprintf(fout,"Doubles type : %s\n",yytext);}

[+] {fprintf(fout,"Add : %s\n",yytext);}
[-] {fprintf(fout,"Subtract : %s\n",yytext);}
[&] {fprintf(fout,"Ampersand : %s\n",yytext);}
[/] {fprintf(fout,"Division : %s\n",yytext);}
[*] {fprintf(fout,"Multiple : %s\n",yytext);}
[\^] {fprintf(fout,"power of.. : %s\n",yytext);}
[+]{2} {fprintf(fout,"Increase : %s\n",yytext);}
[-]{2} {fprintf(fout,"Decrease : %s\n",yytext);}
[&]{2} {fprintf(fout,"Logical AND : %s\n",yytext);}
[*]{2} {fprintf(fout,"Pointer to Pointer : %s\n",yytext);}
[=]{2} {fprintf(fout,"Is the same : %s\n",yytext);}
"!=" {fprintf(fout,"Isn't the same : %s\n",yytext);}

(([0]+[.][0]+)|([+-]?[1-9][0-9]*[.][0-9]+))[xX][1-9][0-9]*[*^][-]?[1-9][0-9]* { fprintf(fout,"weird decimal numbers with x,X and ^ or *: %s\n",yytext); }
(([0]+[.][0]+)|([+-]?[1-9][0-9]*[.][0-9]+))[eE][+-][1-9][0-9]* { fprintf(fout,"weird decimal numbers with e,E: %s\n",yytext); }

[0]|([+-]?[1-9][0-9]*) { fprintf(fout,"Int : %s\n",yytext); }
([0]+[.][0]+)|([+-]?[1-9][0-9]*[.][0-9]+) { fprintf(fout,"Doubles: %s\n",yytext); }

cst[0-9]{4}/2010 {fprintf(fout,"dexio sumfrazomeno euresi : %s\n",yytext);}
(\"|\')[a-zA-Z]([a-zA-Z]|[0-9]|[_])*[.]([a-zA-Z]|[0-9]){3}(\"|\') {fprintf(fout,"Filename : %s\n",yytext);}
^\"(([^\"]|\\\")*[^\\])?\" {fprintf(fout,"String at start of line: %s\n",yytext);}
\"(([^\"]|\\\")*[^\\])?\" {fprintf(fout,"String: %s\n",yytext);}
"//".* { fprintf(fout,"line_comment : %s\n",yytext);  }
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] { fprintf(fout,"comment : %s\n",yytext); }

%%


int main(int argc, char ** argv){
    if(argc < 3){
        printf("\nError!!! Missing Command line arguments");
        printf("\nUsage exe <inputfile> <outputfile>");
        exit(1);
    }else{
        fopen_s(&fout,argv[2],"w");
        fopen_s(&yyin,argv[1],"r");
        yylex();
    }
    return 0;
}

