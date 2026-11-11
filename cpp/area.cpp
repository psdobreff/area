// Compute the area of shapes described in an input file.
//
// Usage:  ./area [input_file]        (default: shape.in)
//
// Input file format - one shape per line, followed by its dimensions:
//     rectangle       <width> <height>
//     circle          <radius>
//     right_triangle  <base> <height>
// Dimensions may be separated by spaces, tabs or commas.
// Blank lines and lines beginning with '#' or '!' are ignored.
#include "shapes.hpp"

#include <cerrno>
#include <cmath>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

namespace {

constexpr std::size_t max_dims = 8;

bool is_space(char c) { return c == ' ' || c == '\t' || c == '\r'; }
bool is_sep(char c) { return is_space(c) || c == ','; }

// Strip leading and trailing whitespace.
std::string trim(const std::string& s) {
    std::size_t b = 0, e = s.size();
    while (b < e && is_space(s[b])) ++b;
    while (e > b && is_space(s[e - 1])) --e;
    return s.substr(b, e - b);
}

// Split a line into a shape name followed by up to max_dims numbers.
// Returns false if the dimensions cannot be parsed.
bool parse_line(const std::string& line, std::string& name, std::vector<double>& dims) {
    std::size_t i = 0;
    while (i < line.size() && !is_space(line[i])) ++i;
    name = line.substr(0, i);
    dims.clear();

    while (i < line.size()) {
        while (i < line.size() && is_sep(line[i])) ++i;
        if (i == line.size()) break;
        std::size_t j = i;
        while (j < line.size() && !is_sep(line[j])) ++j;

        const std::string tok = line.substr(i, j - i);
        char* end = nullptr;
        errno = 0;
        const double v = std::strtod(tok.c_str(), &end);
        if (end != tok.c_str() + tok.size() || errno == ERANGE || !std::isfinite(v))
            return false;
        dims.push_back(v);
        if (dims.size() > max_dims) return false;
        i = j;
    }
    return true;
}

}  // namespace

int main(int argc, char* argv[]) {
    const std::string filename = argc >= 2 ? argv[1] : "shape.in";

    std::ifstream in(filename);
    if (!in) {
        std::cout << "Error: cannot open input file \"" << filename << "\"\n";
        return 1;
    }

    std::string raw, line, name, errmsg;
    std::vector<double> dims;
    int line_no = 0, nok = 0, nerr = 0;

    auto report = [&](const std::string& msg) {
        std::cout << "Line " << line_no << ": " << msg << "  ->  \"" << line << "\"\n";
        ++nerr;
    };

    while (std::getline(in, raw)) {
        ++line_no;
        line = trim(raw);
        if (line.empty() || line[0] == '#' || line[0] == '!') continue;

        if (!parse_line(line, name, dims)) {
            report("could not parse dimensions");
            continue;
        }

        auto shp = create_shape(name, dims, errmsg);
        if (!shp) {
            report(errmsg);
            continue;
        }

        // Virtual dispatch: the correct area/describe is chosen at run time.
        std::cout << std::left << std::setw(55) << shp->describe() << "Area = "
                  << std::fixed << std::setprecision(6) << shp->area() << '\n';
        std::cout.copyfmt(std::ios(nullptr));
        ++nok;
    }

    if (nok + nerr == 0) {
        std::cout << "Error: no shapes found in \"" << filename << "\"\n";
        return 1;
    }
    return nerr > 0 ? 2 : 0;
}
