import sys
import logging

from antlr4.FileStream import FileStream
from antlr4.CommonTokenStream import CommonTokenStream
from antlr4.tree.Tree import ParseTreeWalker

from FimRusLexer import FimRusLexer
from FimRusListener import FimRusListener
from FimRusParser import FimRusParser

log = logging.getLogger(__name__)


class Listener(FimRusListener):
    def __init__(self):
        self.vars = {}

    def exitAssignmentStatement(self, ctx: FimRusParser.AssignmentStatementContext):
        var = ctx.variable().getText()
        expr = ctx.expression()
        value = self._parse_expr(expr)
        log.debug('%s = %d', var, value)
        self.vars[var] = value

    def exitSay(self, ctx: FimRusParser.SayContext):
        for expr in ctx.expressions().children:
            r = self._parse_expr(expr)
            if isinstance(r, str):
                print(r, end='')
            else:
                log.error('NotImplementedError')
        print()

    @staticmethod
    def _parse_expr(expr):
        log.debug(expr.getText())

        const_int = expr.CONST_INT()
        if const_int:
            return int(const_int.getText())

        const_str = expr.CONST_STR()
        if const_str:
            return const_str.getText().strip('"')

        log.error('NotImplementedError')


def main(filename):
    lexer = FimRusLexer(FileStream(filename, encoding='utf8'))
    stream = CommonTokenStream(lexer)
    parser = FimRusParser(stream)
    tree = parser.program()
    listener = Listener()
    walker = ParseTreeWalker()
    walker.walk(listener, tree)


if __name__ == '__main__':
    logging.basicConfig(level=logging.DEBUG)
    if len(sys.argv) == 2:
        main(sys.argv[1])
    else:
        main('examples/00-hello.fim')
        # main('examples/01-99bottles.fim')
