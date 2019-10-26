all: FimRusParser.py

run:
	. venv/bin/activate;\
	python fim_rus.py;\
	deactivate

FimRusParser.py: FimRus.g4
	antlr4 -Dlanguage=Python3 $<

clean:
	rm -f *.interp *.tokens FimRus*.py
