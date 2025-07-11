#include <stdio.h>
#include <stdlib.h>

#include "../include/calculator.h"

int main() {
    printf("Scientific Calculator v1.0\n");
    printf("==========================\n\n");

    // Simple test
    double result = divide(2.5, 0);
    printf("Test: 2.5 / 0 = %.2f\n", result);

    return 0;
}
