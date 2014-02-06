%{

// Based on lex2_cpp provided by Professor Xin Yuan

#include <string.h>
#include <stdio.h>
#include <iostream>
#include <vector>
#include <string>
#include "token.h"

using namespace std;
extern int put_string(char *str, int len);

int yyval;
char* string_buff;
vector<string> string_table;
int string_table_index = 0;
int yyline = 1, yycolumn = 1;
%}

delim 	[ \t]
ws		{delim}+
letter 	[a-zA-Z]
digit 	[0-9]
id		{letter}({letter}|{digit})*
number	{digit}+
float	{digit}+\.{digit}+

a [aA]
b [bB]
c [cC]
d [dD]
e [eE]
f [fF]
g [gG]
h [hH]
i [iI]
j [jJ]
k [kK]
l [lL]
m [mM]
n [nN]
o [oO]
p [pP]
q [qQ]
r [rR]
s [sS]
t [tT]
u [uU]
v [vV]
w [wW]
x [xX]
y [yY]
z [zZ]

%%
\n  					{yyline++;yycolumn=1;}
{ws}					{yycolumn += yyleng;}


";"														{yycolumn += yyleng; return (SEMInumber);}
":"														{yycolumn += yyleng; return (COLONnumber);}
","														{yycolumn += yyleng; return (COMMAnumber);}
"."														{yycolumn += yyleng; return (DOTnumber);}
"("														{yycolumn += yyleng; return (LPARENnumber);}
")"														{yycolumn += yyleng; return	(RPARENnumber);}
"<"														{yycolumn += yyleng; return (LTnumber);}
">"														{yycolumn += yyleng; return (GTnumber);}
"="														{yycolumn += yyleng; return (EQnumber);}
"-"														{yycolumn += yyleng; return (MINUSnumber);}
"+"														{yycolumn += yyleng; return (PLUSnumber);}
"*"														{yycolumn += yyleng; return (TIMESnumber);}
".."													{yycolumn += yyleng; return (DOTDOTnumber);}
":="													{yycolumn += yyleng; return (COLEQnumber);}
"<="													{yycolumn += yyleng; return (LEnumber);}
">="													{yycolumn += yyleng; return (GEnumber);}
"<>"													{yycolumn += yyleng; return (NEnumber);}

'[^'\n]*    {
				int c;
           		yycolumn += yyleng;
           		if (yyleng == 2) {
              		yyval = put_string(yytext+1, yyleng-1);
              		c=yyinput(); /* read the additional ' */
              		if (c != '\'') {
                		cout << "unenclosed character, line = " << yyline << ", column =" <<  yycolumn-yyleng << "\n";
                		if (c != 0) unput(c);
              		} 
              		return(CCONSTnumber);
           		} 
           		else {
              		yyval = put_string(yytext+1, yyleng-1);
              		c= yyinput();
              		if (c != '\'') {
                		cout << "unended string, line = " << yyline << ", column = " << yycolumn-yyleng << "\n";
                	if (c != 0) unput(c);
              		} 
              		return(SCONSTnumber);
           		}
          	}

{a}{n}{d}							{yycolumn += yyleng; return (ANDnumber);}
{a}{r}{r}{a}{y}						{yycolumn += yyleng; return (ARRAYnumber);}
{b}{e}{g}{i}{n}						{yycolumn += yyleng; return (BEGINnumber);}
{c}{o}{n}{s}{t}{a}{n}{t}			{yycolumn += yyleng; return (CONSTnumber);}
{d}{i}{v}							{yycolumn += yyleng; return (DIVIDEnumber);}
{d}{o}{w}{n}{t}{o}					{yycolumn += yyleng; return (DOWNTOnumber);}
{i}{n}{t}{e}{g}{e}{r}				{yycolumn += yyleng; return (INTnumber);}
{e}{l}{s}{e}						{yycolumn += yyleng; return (ELSEnumber);}
{e}{l}{s}{i}{f}						{yycolumn += yyleng; return (ELSIFnumber);}
{e}{n}{d}							{yycolumn += yyleng; return (ENDnumber);}
{e}{n}{d}{i}{f}						{yycolumn += yyleng; return (ENDIFnumber);}
{e}{n}{d}{l}{o}{o}{p}				{yycolumn += yyleng; return (ENDLOOPnumber);}
{e}{n}{d}{r}{e}{c}					{yycolumn += yyleng; return (ENDRECnumber);}
{e}{x}{i}{t}						{yycolumn += yyleng; return (EXITnumber);}
{f}{o}{r}							{yycolumn += yyleng; return (FORnumber);}
{f}{o}{r}{w}{a}{r}{d}				{yycolumn += yyleng; return (FORWARDnumber);}
{f}{u}{n}{c}{t}{i}{o}{n}			{yycolumn += yyleng; return (FUNCTIONnumber);}
{i}{f}								{yycolumn += yyleng; return (IFnumber);}
{i}{s}								{yycolumn += yyleng; return (ISnumber);}
{l}{o}{o}{p}						{yycolumn += yyleng; return (LOOPnumber);}
{n}{o}{t}							{yycolumn += yyleng; return (NOTnumber);}
{o}{f}								{yycolumn += yyleng; return (OFnumber);}
{o}{r}								{yycolumn += yyleng; return (ORnumber);}
{p}{r}{o}{c}{e}{d}{u}{r}{e}			{yycolumn += yyleng; return (PROCEDUREnumber);}
{p}{r}{o}{g}{r}{a}{m}				{yycolumn += yyleng; return (PROGRAMnumber);}
{r}{e}{c}{o}{r}{d}					{yycolumn += yyleng; return (RECORDnumber);}
{r}{e}{p}{e}{a}{t}					{yycolumn += yyleng; return (REPEATnumber);}
{f}{l}{o}{a}{t}						{yycolumn += yyleng; return (FLOATnumber);}
{r}{e}{t}{u}{r}{n}					{yycolumn += yyleng; return (RETURNnumber);}
{t}{h}{e}{n}						{yycolumn += yyleng; return (THENnumber);}
{t}{o}								{yycolumn += yyleng; return (TOnumber);}
{t}{y}{p}{e}						{yycolumn += yyleng; return (TYPEnumber);}
{u}{n}{t}{i}{l}						{yycolumn += yyleng; return (UNTILnumber);}
{v}{a}{r}							{yycolumn += yyleng; return (VARnumber);}
{w}{h}{i}{l}{e}						{yycolumn += yyleng; return (WHILEnumber);}
{p}{r}{i}{n}{t}						{yycolumn += yyleng; return (PRINTnumber);}

%%

int yywrap()
{
	if(feof(stdin)) 
		return 1;
	return 0;
}
