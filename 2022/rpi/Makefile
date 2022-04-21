LIBS=-lpthread -lpng

CCOPT=-std=c99 -D_DEFAULT_SOURCE

all: futbalista

futbalista:	futbalista.c komunikacia.c kamera.c pngwriter.c
	gcc -o futbalista $^ $(LIBS) $(CCOPT)

clean:
	rm -f futbalista
