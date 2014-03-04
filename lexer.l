
%x COMMENT
%x STRING

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
delim 	[ \t]
ws		{delim}+
letter 	[a-zA-Z]
digit 	[0-9]
id		{letter}({letter}|{digit})*
number	{digit}+
float	{digit}+\.{digit}+ 

%{

#include "token.h"
// Based on lex2_cpp provided by Professor Xin Yuan
string lString;
int put_string(char *str, int len);
int put_stringid(char *str, int len);

int str_tbl_index = 0;
int yyline = 1, yycolumn = 1;
%}


%%

\n  								{yyline++;yycolumn=1;}
{ws}								{yycolumn += yyleng;}
{number}							{yylval.semantic_value = atoi(yytext); yycolumn += yyleng; return (ICONSTnumber);}
{float}								{yylval.fvalue = atof(yytext); yycolumn += yyleng; return (FCONSTnumber);}
({digit}+"."{digit}+{e}[+-]?{digit}+)|({digit}+"."{digit}+)		{yylval.fvalue = atof(yytext); 
																					 yycolumn += yyleng;  return (FCONSTnumber);}

"(*"								BEGIN(COMMENT);
<COMMENT>[^)*\n]+						++yycolumn;
<COMMENT>\n 						++yyline; yycolumn=1;
<COMMENT>"*)"						BEGIN(INITIAL);
<COMMENT><<EOF>>					cout << "Unmatched comment on line: " << yyline << ", column: " << yycolumn << endl;
<COMMENT>[*)]						

";"			{yycolumn += yyleng; return (SEMInumber);}
":"			{yycolumn += yyleng; return (COLONnumber);}
","			{yycolumn += yyleng; return (COMMAnumber);}
"."			{yycolumn += yyleng; return (DOTnumber);}
"("			{yycolumn += yyleng; return (LPARENnumber);}
")"			{yycolumn += yyleng; return	(RPARENnumber);}
"<"			{yycolumn += yyleng; return (LTnumber);}
">"			{yycolumn += yyleng; return (GTnumber);}
"="			{yycolumn += yyleng; return (EQnumber);}
"-"			{yycolumn += yyleng; return (MINUSnumber);}
"+"			{yycolumn += yyleng; return (PLUSnumber);}
"*"			{yycolumn += yyleng; return (TIMESnumber);}
".."								{yycolumn += yyleng; return (DOTDOTnumber);}
":="								{yycolumn += yyleng; return (COLEQnumber);}
"<="								{yycolumn += yyleng; return (LEnumber);}
">="								{yycolumn += yyleng; return (GEnumber);}
"<>"								{yycolumn += yyleng; return (NEnumber);}
"'"								 	{BEGIN (STRING); lString.clear(); lString = "";}
<STRING>"'"							{BEGIN (INITIAL); str_tbl.push_back(lString); str_tbl_index++; yylval.semantic_value = str_tbl_index-1; return SCONSTnumber;}
<STRING>\n	 						{yycolumn += yyleng; lString.append("\n");}
<STRING>\\'							{yycolumn += yyleng; lString.append("\'");}
<STRING>\\t 						{yycolumn += yyleng; lString.append("\t");}
<STRING>\\\\						{yycolumn += yyleng; lString.append("\\");}
<STRING>\\n 						{yycolumn += yyleng; lString.append("\n");}
<STRING>.							{yycolumn += yyleng; lString.append(yytext);}
{a}{n}{d}											{yycolumn += yyleng; return (ANDnumber);}
{a}{r}{r}{a}{y}										{yycolumn += yyleng; return (ARRAYnumber);}
{b}{e}{g}{i}{n}										{yycolumn += yyleng; return (BEGINnumber);}
{c}{o}{n}{s}{t}{a}{n}{t}							{yycolumn += yyleng; return (CONSTnumber);}
{d}{i}{v}											{yycolumn += yyleng; return (DIVIDEnumber);}
{d}{o}{w}{n}{t}{o}									{yycolumn += yyleng; return (DOWNTOnumber);}
{i}{n}{t}{e}{g}{e}{r}								{yycolumn += yyleng; return (INTnumber);}
{e}{l}{s}{e}										{yycolumn += yyleng; return (ELSEnumber);}
{e}{l}{s}{i}{f}										{yycolumn += yyleng; return (ELSIFnumber);}
{e}{n}{d}											{yycolumn += yyleng; return (ENDnumber);}
{e}{n}{d}{i}{f}										{yycolumn += yyleng; return (ENDIFnumber);}
{e}{n}{d}{l}{o}{o}{p}								{yycolumn += yyleng; return (ENDLOOPnumber);}
{e}{n}{d}{r}{e}{c}									{yycolumn += yyleng; return (ENDRECnumber);}
{e}{x}{i}{t}										{yycolumn += yyleng; return (EXITnumber);}
{f}{o}{r}											{yycolumn += yyleng; return (FORnumber);}
{f}{o}{r}{w}{a}{r}{d}								{yycolumn += yyleng; return (FORWARDnumber);}
{f}{u}{n}{c}{t}{i}{o}{n}							{yycolumn += yyleng; return (FUNCTIONnumber);}
{i}{f}												{yycolumn += yyleng; return (IFnumber);}
{i}{s}												{yycolumn += yyleng; return (ISnumber);}
{l}{o}{o}{p}										{yycolumn += yyleng; return (LOOPnumber);}
{n}{o}{t}											{yycolumn += yyleng; return (NOTnumber);}
{o}{f}												{yycolumn += yyleng; return (OFnumber);}
{o}{r}												{yycolumn += yyleng; return (ORnumber);}
{p}{r}{o}{c}{e}{d}{u}{r}{e}							{yycolumn += yyleng; return (PROCEDUREnumber);}
{p}{r}{o}{g}{r}{a}{m}								{yycolumn += yyleng; return (PROGRAMnumber);}
{r}{e}{c}{o}{r}{d}									{yycolumn += yyleng; return (RECORDnumber);}
{r}{e}{p}{e}{a}{t}									{yycolumn += yyleng; return (REPEATnumber);}
{f}{l}{o}{a}{t}										{yycolumn += yyleng; return (FLOATnumber);}
{r}{e}{t}{u}{r}{n}									{yycolumn += yyleng; return (RETURNnumber);}
{t}{h}{e}{n}										{yycolumn += yyleng; return (THENnumber);}
{t}{o}												{yycolumn += yyleng; return (TOnumber);}
{t}{y}{p}{e}										{yycolumn += yyleng; return (TYPEnumber);}
{u}{n}{t}{i}{l}										{yycolumn += yyleng; return (UNTILnumber);}
{v}{a}{r}											{yycolumn += yyleng; return (VARnumber);}
{w}{h}{i}{l}{e}										{yycolumn += yyleng; return (WHILEnumber);}
{p}{r}{i}{n}{t}										{yycolumn += yyleng; return (PRINTnumber);}
{id}												{yycolumn += yyleng; yylval.semantic_value = put_stringid(yytext, yyleng); return (IDnumber);}	
.           						{printf("Unknown character %s, line = %d, column = %d\n", yytext, yyline, yycolumn);yycolumn += yyleng;}
%%

int yywrap()
{
	if(feof(stdin)) 
		return 1;
	return 0;
}
int put_string(char *str, int len)
{
	char tmp[len];
	if(len != 2)
	{
		for(int i=0; i < len; ++i)
		{
			if(str[i] = '\\')
			{
				switch(str[i+1])
				{
					case '\'': tmp[i] = '\''; 
						break;
					case '\\': tmp[i] = '\\';
						break;
					case 't' : tmp[i] = '\t';
						break;
					case 'n' : tmp[i] = '\n';
						break;
				}
				++i;
			}
			else tmp[i] = str[i];
		}
		string s(tmp);
		str_tbl.push_back(s);
  		str_tbl_index++;
  		return str_tbl_index-1; 
	}
}
int put_stringid(char *str, int len)
{
	string s(str);
	str_tbl.push_back(s);
  	str_tbl_index++;
  	return str_tbl_index-1; 
}
