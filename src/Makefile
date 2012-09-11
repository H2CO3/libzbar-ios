NAME = zbar
VERSION = 0.10

CC = arm-apple-darwin9-gcc
CXX = arm-apple-darwin9-g++
LD = $(CC) # if C++ code is to be linked, change to $(CXX)
CFLAGS = -isysroot /var/mobile/sysroot -c -Wall -Wno-parentheses -I. -I.. -I../.. -Iinclude -I../include -I../../include
CXXFLAGS = -isysroot /var/mobile/sysroot -c -Wall -Wno-parentheses -I. -I.. -I../.. -Iinclude -I../include -I../../include
LDFLAGS = -isysroot /var/mobile/sysroot -w -dynamiclib -ljpeg -liconv -lobjc -framework Foundation -framework CoreGraphics

TARGET_TRUE = lib$(NAME).$(VERSION).dylib
TARGET = lib$(NAME).dylib
OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c decoder/*.c processor/*.c qrcode/*.c video/*.c window/*.c))
OBJECTS += $(patsubst %.m, %.o, $(wildcard objc/*.m))

all: $(TARGET)

clean:
	rm -f $(OBJECTS) $(TARGET) $(TARGET_TRUE)

$(TARGET): $(TARGET_TRUE)
	ln -s $< $@

$(TARGET_TRUE): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -o $@ $<

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ $<

%.o: %.m
	$(CC) $(CFLAGS) -o $@ $<
