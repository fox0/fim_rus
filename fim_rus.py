import sys

from antlr4.FileStream import FileStream
from antlr4.CommonTokenStream import CommonTokenStream
from antlr4.tree.Tree import ParseTreeWalker

from FimRusLexer import FimRusLexer
from FimRusListener import FimRusListener
from FimRusParser import FimRusParser


class Listener(FimRusListener):
    def __init__(self):
        self.vars = {}

    def exitSay(self, ctx: FimRusParser.SayContext):
        print(ctx.CONST_STR().getText().strip('"'))


def main(filename):
    lexer = FimRusLexer(FileStream(filename, encoding='utf8'))
    stream = CommonTokenStream(lexer)
    parser = FimRusParser(stream)
    tree = parser.program()
    listener = Listener()
    walker = ParseTreeWalker()
    walker.walk(listener, tree)


if __name__ == '__main__':
    if len(sys.argv) == 2:
        main(sys.argv[1])
    else:
        main('examples/00-hello.fim')
