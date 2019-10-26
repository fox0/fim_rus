grammar FimRus;

program:
    'Дорогая принцесса Селестия' DOT
    body
    ('Ваша верная ученица'|'Ваш верный ученик') COMMA author DOT;

author:
    ID+;

body:
    statements DOT
    ;

statements:
    statement (DOT statement)*;

statement:
    say
    ;

say:
    'Я сказал' 'а'? CONST_STR;

DOT: '.';
COMMA: ',';

ID: [а-яА-ЯёЁ]+;
CONST_STR: '"' (~ ('"'))* '"';
WS: [ \t\r\n]+ -> skip;
COMMENT: '(' .*? ')' -> skip;
