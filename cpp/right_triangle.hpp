// Right triangle shape (defined by its two legs).
#pragma once

#include "shape.hpp"

class RightTriangle : public Shape {
public:
    RightTriangle(double base, double height) : base_(base), height_(height) {}
    double area() const override;
    std::string describe() const override;

private:
    double base_;    // one leg
    double height_;  // the other leg
};
