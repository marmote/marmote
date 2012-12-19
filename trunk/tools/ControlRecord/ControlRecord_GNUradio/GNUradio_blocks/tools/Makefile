IDIR =.
CXX=gcc
CXXFLAGS=-I$(IDIR)
RELEASE_FLAGS=-g0 -O3


ODIR=obj
LDIR=.

#LIBS=-ldirent
LIBS=

NAME=tools
FULLNAME=lib$(NAME).a


_DEPS = ExtractFrames.h ExtractNsamples16bit.h FileSource.h FrameBuffer.h FrameConfig.h HumanReadableDataSize.h strnatcmp.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

SRC =  ExtractFrames.cpp ExtractNsamples16bit.cpp FileSource.cpp FrameBuffer.cpp HumanReadableDataSize.cpp strnatcmp.cpp
_OBJ =$(SRC:.cpp=.o)
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))


all: $(FULLNAME)

$(FULLNAME): $(OBJ)
	ar rcs $@ $^

$(ODIR)/%.o: %.cpp $(DEPS)
	mkdir -p $(ODIR)
	$(CXX) $(RELEASE_FLAGS) -fPIC -c -o $@ $< $(CXXFLAGS)

clean:
	rm -f $(ODIR)/*.o *.a 

.PHONY: all clean
