// Abstract base class for the shape hierarchy.
//
// `Shape` declares the interface every shape must implement; concrete
// classes (one per file) derive from it and provide their own `area` and
// `describe` methods.
#pragma once

#include <string>

class Shape {
public:
    virtual ~Shape() = default;
    virtual double area() const = 0;
    virtual std::string describe() const = 0;
};

// Format a double compactly (6 significant digits) for use in descriptions.
std::string fmt(double x);
