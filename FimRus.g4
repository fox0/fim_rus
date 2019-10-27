grammar FimRus;

program:
    'Дорогая принцесса Селестия' DOT
    body
    ('Ваша верная ученица'|'Ваш верный ученик') COMMA variable DOT;

body:
    statements endLine
    ;

statements:
    statement (endLine statement)*;

endLine:
    DOT | QUESTION;

statement
    : say
    | assignmentStatement
    ;

say:
    'Я сказал' 'а'? expressions;

assignmentStatement:
    'Вы знали, что' variable 'нравится' expression;

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
QUESTION: '?';
//COLON: ':';

//MINUS: '-';

ID: [а-яА-ЯёЁ]+;
CONST_INT: [0-9]+;
CONST_STR: '"' (~ ('"'))* '"';

WS: [ \t\r\n]+ -> skip;
COMMENT: '(' .*? ')' -> skip;
