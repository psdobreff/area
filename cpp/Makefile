CXX       = g++
CXXFLAGS ?= -std=c++17 -Wall -Wextra -O2

SRCS = shape.cpp rectangle.cpp circle.cpp right_triangle.cpp shapes.cpp area.cpp
OBJS = $(SRCS:.cpp=.o)

area: $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -MP -c $<

-include $(OBJS:.o=.d)

run: area
	./area ../shape.in

clean:
	rm -f *.o *.d area

.PHONY: run clean
