FC      = gfortran
FFLAGS ?= -std=f2018 -Wall -Wextra -O2

SHAPES = rectangle_mod.o circle_mod.o right_triangle_mod.o
OBJS   = shape_base_mod.o $(SHAPES) shapes_mod.o area.o

area: $(OBJS)
	$(FC) $(FFLAGS) -o $@ $^

%.o: %.f90
	$(FC) $(FFLAGS) -c $<

# Module dependencies: a file must be compiled after the modules it uses.
$(SHAPES):     shape_base_mod.o
shapes_mod.o:  shape_base_mod.o $(SHAPES)
area.o:        shapes_mod.o

run: area
	./area shape.in

clean:
	rm -f *.o *.mod area

.PHONY: run clean
