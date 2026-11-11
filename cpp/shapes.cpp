#include "shapes.hpp"

#include <algorithm>
#include <cctype>

namespace {

std::string to_lower(std::string s) {
    for (char& c : s) c = static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
    return s;
}

}  // namespace

std::unique_ptr<Shape> create_shape(const std::string& name,
                                    const std::vector<double>& dims,
                                    std::string& errmsg) {
    errmsg.clear();

    if (std::any_of(dims.begin(), dims.end(), [](double d) { return d <= 0.0; })) {
        errmsg = "all dimensions must be positive";
        return nullptr;
    }

    auto need = [&](std::size_t n) {
        if (dims.size() == n) return true;
        errmsg = name + " needs " + std::to_string(n) + " dimension(s), got " +
                 std::to_string(dims.size());
        return false;
    };

    const std::string key = to_lower(name);
    if (key == "rectangle") {
        if (!need(2)) return nullptr;
        return std::make_unique<Rectangle>(dims[0], dims[1]);
    }
    if (key == "circle") {
        if (!need(1)) return nullptr;
        return std::make_unique<Circle>(dims[0]);
    }
    if (key == "right_triangle" || key == "righttriangle" || key == "triangle") {
        if (!need(2)) return nullptr;
        return std::make_unique<RightTriangle>(dims[0], dims[1]);
    }

    errmsg = "unknown shape \"" + name + "\" (valid: rectangle, circle, right_triangle)";
    return nullptr;
}
