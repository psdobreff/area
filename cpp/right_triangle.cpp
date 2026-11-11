#include "right_triangle.hpp"

double RightTriangle::area() const { return 0.5 * base_ * height_; }

std::string RightTriangle::describe() const {
    return "Right triangle (base = " + fmt(base_) + ", height = " + fmt(height_) + ")";
}
