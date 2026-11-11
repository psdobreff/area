#include "circle.hpp"

#include <cmath>

double Circle::area() const {
    static const double pi = std::acos(-1.0);
    return pi * radius_ * radius_;
}

std::string Circle::describe() const {
    return "Circle (radius = " + fmt(radius_) + ")";
}
