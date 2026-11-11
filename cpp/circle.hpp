// Circle shape.
#pragma once

#include "shape.hpp"

class Circle : public Shape {
public:
    explicit Circle(double radius) : radius_(radius) {}
    double area() const override;
    std::string describe() const override;

private:
    double radius_;
};
