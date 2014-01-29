#include "token.h"
union {
  int semantic_value;
  float fvalue;
} yylval, yyval;

#include "lex.yy.c"

char output1[100][20]={"EOFtoken", "SEMItoken", "COLONtoken", "COMMAtoken",
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
     "BEGINtoken", "FLOATtoken"};

main()
{

    int i;
    while ((i=yylex())!=EOFnumber) {
        switch(i) {
	case IDnumber :
            printf("%14s, %s\n", 
                   output1[i-100], string_buff+yylval.semantic_value);
            break;
	case SCONSTnumber:
            printf("%14s, string='%s'\n", 
                   output1[i-100],string_buff+yylval.semantic_value);
            break;
	  case ICONSTnumber :
            printf("%14s, %d\n",output1[i-100],yylval.semantic_value);
            break;
	  case FCONSTnumber :
            printf("%14s, %f\n",output1[i-100],yylval.fvalue);
            break;
	  case CCONSTnumber :
            printf("%14s, ", output1[i-100]);
            switch(yylval.semantic_value) {
	    case '\n' : printf("%s\n", "'\\n'"); break;
	    case '\t' : printf("%s\n", "'\\t'"); break;
            case '\\' : printf("%s\n", "'\\\\'"); break;
            case '\'' : printf("%s\n", "'\\''"); break;
            default : printf("'%c'\n",  yylval.semantic_value); 
	    }
            break;
          default :
            printf("%14s\n",output1[i-100]);
	  }
            
      }
      printf("%14s\n","EOFtoken");
  }
