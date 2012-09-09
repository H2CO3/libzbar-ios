NAME = zbar
VERSION = 0.10

CC = arm-apple-darwin-gcc
CXX = arm-apple-darwin-g++
LD = $(CC) # if C++ code is to be linked, change to $(CXX)
CFLAGS = -c -Wall -Wno-parentheses -I. -I.. -I../.. -Iinclude -I../include -I../../include
CXXFLAGS = -c -Wall -Wno-parentheses -I. -I.. -I../.. -Iinclude -I../include -I../../include -I/usr/arm-apple-darwin/usr/include/c++/4.2.1 -I/usr/arm-apple-darwin/usr/include/c++/4.2.1/armv6-apple-darwin10
LDFLAGS = -w -dynamiclib -ljpeg -liconv

TARGET_TRUE = lib$(NAME).$(VERSION).dylib
TARGET = lib$(NAME).dylib
OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c decoder/*.c processor/*.c qrcode/*.c video/*.c window/*.c))

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

