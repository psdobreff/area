// Shape factory and single include point for the shape hierarchy.
#pragma once

#include "circle.hpp"
#include "rectangle.hpp"
#include "right_triangle.hpp"
#include "shape.hpp"
#include "square.hpp"

#include <memory>
#include <string>
#include <vector>

// Build a shape from its name and dimensions.
// On failure returns nullptr and sets `errmsg` to explain why.
std::unique_ptr<Shape> create_shape(const std::string& name,
                                    const std::vector<double>& dims,
                                    std::string& errmsg);
