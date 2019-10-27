grammar FimRus;

program:
    'Дорогая принцесса Селестия' DOT
    body
    ('Ваша верная ученица'|'Ваш верный ученик') COMMA variable DOT;

body:
    statements DOT
    ;

statements:
    statement (DOT statement)*;

statement
    : say
    | assignmentStatement
    | assignmentMinus
    ;

say:
    'Я сказал' 'а'? expressions;

// var = expr
assignmentStatement:
    variable 'нравится' expression;

// var -= const_int
assignmentMinus:
    variable COMMA 'вычти' CONST_INT;

expressions:
    expression+;

expression
    : 'число' CONST_INT
    | CONST_STR
    | variable
    ;

variable:
    ID+;

DOT: '.';
COMMA: ',';
//QUESTION: '?';
//COLON: ':';

//MINUS: '-';

ID: [а-яА-ЯёЁ]+;
CONST_INT: [0-9]+;
CONST_STR: '"' (~ ('"'))* '"';

WS: [ \t\r\n]+ -> skip;
COMMENT: '(' .*? ')' -> skip;
