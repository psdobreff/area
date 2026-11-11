#include "square.hpp"

double Square::area() const { return side_ * side_; }

std::string Square::describe() const {
    return "Square (side = " + fmt(side_) + ")";
}
