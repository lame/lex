#include "token.h"
#include <stdio.h>
#include <iostream>
#include <vector>
#include <string>
#include <iomanip>
#include <cctype>
using namespace std;

struct VAL{
  int semantic_value;
  float fvalue;
};

struct VAL yylval;
vector<string> str_tbl;      //yylval.semantic_value for index

#include "lex.yy.c"

char output1[59][20]={"EOFtoken", "SEMItoken", "COLONtoken", "COMMAtoken",
     "DOTtoken", "LPARENtoken", "RPARENtoken", "LTtoken", 
     "GTtoken", "EQtoken", "MINUStoken",
     "PLUStoken", "TIMEStoken", "DOTDOTtoken", 
     "COLEQtoken", "LEtoken", "GEtoken", "NEtoken",
     "IDtoken", "ICONSTtoken", "CCONSTtoken", 
     "SCONSTtoken", "ANDtoken", "ARRAYtoken",
     "INTtoken", "CONSTtoken", "DIVIDEtoken",
     "DOWNTOtoken", "ELSEtoken",
     "ELSIFtoken", "ENDtoken", "ENDIFtoken", 
     "ENDLOOPtoken", "ENDRECtoken",
     "EXITtoken", "FORtoken", "FORWARDtoken", 
     "FUNCTIONtoken", "IFtoken", "IStoken",
     "LOOPtoken", "NOTtoken", "OFtoken", 
     "ORtoken", "PROCEDUREtoken", "PROGRAMtoken",
     "RECORDtoken", "REPEATtoken", "RETURNtoken", 
     "THENtoken", "TOtoken", "TYPEtoken",
     "UNTILtoken", "VARtoken", "WHILEtoken", "FCONSTtoken",
	 "BEGINtoken", "FLOATtoken", "PRINTtoken"};

main()
{

    int i;

    while ((i=yylex())!= 0) {
        //cout << "yylval: " << yylval << endl;
        switch(i) {
        case IDnumber :
            //cout << output1[i-1] << "\t" << yylval << endl;
            cout << setw(14) << right << output1[i-1];
            for(int j=0; str_tbl[yylval.semantic_value][j]; ++j) str_tbl[yylval.semantic_value][j] = toupper(str_tbl[yylval.semantic_value][j]);
            cout << ", " << str_tbl[yylval.semantic_value] << endl;
            //printf("%14s, %s\n", output1[i-1], toupper(str_tbl[yylval.semantic_value].c_str()));
            break;
        case SCONSTnumber:
            //cout << output1[i-1] << "\t" << yylval << endl;
            printf("%14s, string='%s'\n", output1[i-1],str_tbl[yylval.semantic_value].c_str());
            break;
        case ICONSTnumber :
            //cout << output1[i-1] << "\t" << yylval << endl;
            printf("%14s, %d\n",output1[i-1],yylval.semantic_value);
            break;
        case FCONSTnumber :
            //cout << output1[i-1] << "\t"<< yylval << endl;
            printf("%14s, %f\n",output1[i-1],yylval.fvalue);
            break;
        case CCONSTnumber :
            //cout << output1[i-1] << "\t" << yylval << endl;
            printf("%14s, ", output1[i-1]);
            switch(yylval.semantic_value) {
            case '\n' : printf("%s\n", "'\\n'"); break;
            case '\t' : printf("%s\n", "'\\t'"); break;
            case '\\' : printf("%s\n", "'\\\\'"); break;
            case '\'' : printf("%s\n", "'\\''"); break;
            default : printf("'%c'\n",  yylval.semantic_value); 
            }
            break;
          default :
            //cout << output1[i-1] << endl;
            printf("%14s\n",output1[i-1]);
	  }
            
      }
      printf("%14s\n","EOFtoken");
  }
