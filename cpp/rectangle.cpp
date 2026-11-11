#include "rectangle.hpp"

double Rectangle::area() const { return width_ * height_; }

std::string Rectangle::describe() const {
    return "Rectangle (width = " + fmt(width_) + ", height = " + fmt(height_) + ")";
}
