// Square shape.
#pragma once

#include "shape.hpp"

class Square : public Shape {
public:
    explicit Square(double side) : side_(side) {}
    double area() const override;
    std::string describe() const override;

private:
    double side_;
};
