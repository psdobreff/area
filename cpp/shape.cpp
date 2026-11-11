#include "shape.hpp"

#include <sstream>

std::string fmt(double x) {
    std::ostringstream os;
    os.precision(6);
    os << std::showpoint << x;
    return os.str();
}
