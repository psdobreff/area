// Rectangle shape.
#pragma once

#include "shape.hpp"

class Rectangle : public Shape {
public:
    Rectangle(double width, double height) : width_(width), height_(height) {}
    double area() const override;
    std::string describe() const override;

private:
    double width_;
    double height_;
};
