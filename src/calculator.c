#include "../include/calculator.h"

double add(double a, double b) { return a + b; }

double substract(double a, double b) { return a - b; }

double multiply(double a, double b) { return a * b; }

double divide(double a, double b) {
    if (b == 0) {
        return 0;  // We'll improve error handling later
    }
    return a / b;
}
