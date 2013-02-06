
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"="                   return '='
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"!"                   return '!'
"%"                   return '%'
"("                   return '('
")"                   return ')'
"{"                   return '{'
"}"                   return '}'
"PI"                  return 'PI'
"E"                   return 'E'
"\frac"               return 'FRAC'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '='
%left '+' '-'
%left '*' '/'
%left '^'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : e EOF
        { return $1; }
    ;

e
    : e '+' e
        {$$ = ['+', $1, $3]; }
    | e '-' e
        {$$ = ['-', $1, $3]; }
    | e '*' e
        {$$ = ['*', $1, $3]; }
    | e e
        {$$ = ['*', $1, $2]; }
    | e '/' e
        {$$ = ['/', $1, $3]; }
    | e '^' e
        {$$ = ['^', '$1', $3]; }
    | '-' e %prec UMINUS
        {$$ = ['~', $2]; }
    | '(' e ')'
        {$$ = $2;}
    | FRAC '{' e '}' '{' e '}'
        {$$ = ['/', $3, $6]; }
    | NUMBER
        {$$ = parseFloat(yytext.replace(',','.'));}
    | E
        {$$ = "e";}
    | PI
        {$$ = "pi";}
    ;
