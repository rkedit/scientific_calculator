# Complete Beginner's Guide to C Development with VSCode: Building a Scientific Calculator

## Table of Contents

1. [Setting Up Your Development Environment](#1-setting-up-your-development-environment)
2. [Understanding C Project Structure](#2-understanding-c-project-structure)
3. [Creating Your First C Project](#3-creating-your-first-c-project)
4. [Mastering the Compilation Process](#4-mastering-the-compilation-process)
5. [Introduction to Makefiles](#5-introduction-to-makefiles)
6. [Setting Up Debugging in VSCode](#6-setting-up-debugging-in-vscode)
7. [Version Control with Git](#7-version-control-with-git)
8. [Building the Scientific Calculator](#8-building-the-scientific-calculator)
9. [Advanced Development Techniques](#9-advanced-development-techniques)
10. [Testing and Quality Assurance](#10-testing-and-quality-assurance)

---

## 1. Setting Up Your Development Environment

### Step 1.1: Install Required Software

**Install VSCode:**
1. Download from [code.visualstudio.com](https://code.visualstudio.com/)
2. Install with default settings
3. Launch VSCode

**Install GCC Compiler:**

**Windows:**
```bash
# Install MinGW-w64 or use WSL
# Option 1: Install MinGW-w64
# Download from https://www.mingw-w64.org/
# Add to PATH: C:\mingw64\bin

# Option 2: Use WSL (Recommended)
wsl --install
# Then install gcc in WSL:
sudo apt update
sudo apt install build-essential gdb
```

**macOS:**
```bash
# Install Xcode command line tools
xcode-select --install
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install build-essential gdb

# Fedora/CentOS
sudo dnf install gcc gcc-c++ gdb make
```

### Step 1.2: Install Essential VSCode Extensions

1. Open VSCode
2. Go to Extensions (Ctrl+Shift+X)
3. Install these extensions:

**Core Extensions:**
- **C/C++** (ms-vscode.cpptools)
- **C/C++ Extension Pack** (ms-vscode.cpptools-extension-pack)
- **Code Runner** (formulahendry.code-runner)
- **GitLens** (eamodio.gitlens)
- **Better Comments** (aaron-bond.better-comments)

### Step 1.3: Configure VSCode for C Development

Create a workspace settings file:

**.vscode/settings.json:**
```json
{
    "files.associations": {
        "*.h": "c",
        "*.c": "c"
    },
    "C_Cpp.default.cStandard": "c17",
    "C_Cpp.default.compilerPath": "/usr/bin/gcc",
    "C_Cpp.default.intelliSenseMode": "gcc-x64",
    "C_Cpp.clang_format_fallbackStyle": "{ BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 100 }",
    "editor.formatOnSave": true,
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true,
    "code-runner.runInTerminal": true,
    "code-runner.saveFileBeforeRun": true
}
```

---

## 2. Understanding C Project Structure

### Step 2.1: Standard C Project Layout

```
scientific_calculator/
├── src/                    # Source code files
│   ├── main.c
│   ├── calculator.c
│   ├── parser.c
│   ├── math_operations.c
│   └── scientific_functions.c
├── include/               # Header files
│   ├── calculator.h
│   ├── parser.h
│   ├── math_operations.h
│   └── scientific_functions.h
├── tests/                 # Test files
│   ├── test_calculator.c
│   ├── test_parser.c
│   └── test_math.c
├── build/                 # Compiled object files
├── bin/                   # Executable files
├── docs/                  # Documentation
├── .vscode/              # VSCode configuration
│   ├── tasks.json
│   ├── launch.json
│   ├── c_cpp_properties.json
│   └── settings.json
├── .gitignore
├── Makefile
└── README.md
```

### Step 2.2: Why This Structure Matters

**Separation of Concerns:**
- `src/` contains implementation code
- `include/` contains interface definitions
- `tests/` keeps testing code separate
- `build/` and `bin/` separate generated files

**Professional Standards:**
- Makes code easier to navigate
- Simplifies build processes
- Enables better collaboration
- Industry-standard organization

---

## 3. Creating Your First C Project

### Step 3.1: Initialize Project Directory

```bash
# Create project directory
mkdir scientific_calculator
cd scientific_calculator

# Create folder structure
mkdir src include tests build bin docs .vscode
```

### Step 3.2: Create Basic Files

**src/main.c:**
```c
#include <stdio.h>
#include <stdlib.h>
#include "../include/calculator.h"

int main() {
    printf("Scientific Calculator v1.0\n");
    printf("==========================\n\n");

    // Simple test
    double result = add(2.5, 3.7);
    printf("Test: 2.5 + 3.7 = %.2f\n", result);

    return 0;
}
```

**include/calculator.h:**
```c
#ifndef CALCULATOR_H
#define CALCULATOR_H

// Function declarations
double add(double a, double b);
double subtract(double a, double b);
double multiply(double a, double b);
double divide(double a, double b);

#endif // CALCULATOR_H
```

**src/calculator.c:**
```c
#include "../include/calculator.h"

double add(double a, double b) {
    return a + b;
}

double subtract(double a, double b) {
    return a - b;
}

double multiply(double a, double b) {
    return a * b;
}

double divide(double a, double b) {
    if (b == 0) {
        return 0; // We'll improve error handling later
    }
    return a / b;
}
```

### Step 3.3: Configure IntelliSense

**.vscode/c_cpp_properties.json:**
```json
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "${workspaceFolder}/**",
                "${workspaceFolder}/include",
                "/usr/include/**"
            ],
            "defines": [
                "_DEBUG",
                "_GNU_SOURCE"
            ],
            "compilerPath": "/usr/bin/gcc",
            "cStandard": "c17",
            "intelliSenseMode": "gcc-x64"
        }
    ],
    "version": 4
}
```

---

## 4. Mastering the Compilation Process

### Step 4.1: Understanding the Compilation Pipeline

The compilation process has four stages:

1. **Preprocessing** (`.c` → `.i`)
2. **Compilation** (`.i` → `.s`)
3. **Assembly** (`.s` → `.o`)
4. **Linking** (`.o` → executable)

### Step 4.2: Manual Compilation Steps

Let's compile our calculator step by step:

```bash
# Navigate to project directory
cd scientific_calculator

# Step 1: Preprocess main.c
gcc -E src/main.c -o build/main.i

# Step 2: Compile to assembly
gcc -S build/main.i -o build/main.s

# Step 3: Assemble to object file
gcc -c build/main.s -o build/main.o

# Step 4: Compile calculator.c to object file
gcc -c src/calculator.c -o build/calculator.o

# Step 5: Link object files
gcc build/main.o build/calculator.o -o bin/calculator
```

### Step 4.3: Direct Compilation (Easier Way)

```bash
# Compile everything in one command
gcc -Wall -Wextra -std=c17 -g -Iinclude src/main.c src/calculator.c -o bin/calculator

# Run the program
./bin/calculator
```

### Step 4.4: Essential GCC Flags

**Debugging Flags:**
- `-g`: Include debugging symbols
- `-ggdb`: GDB-specific debugging info
- `-g3`: Include macro definitions

**Warning Flags:**
- `-Wall`: Enable common warnings
- `-Wextra`: Enable additional warnings
- `-Werror`: Treat warnings as errors

**Standard Flags:**
- `-std=c17`: Use C17 standard
- `-ansi`: Use ANSI C standard

**Include Path:**
- `-Iinclude`: Add include directory to search path

**Optimization Flags:**
- `-O0`: No optimization (default, good for debugging)
- `-O1`: Basic optimization
- `-O2`: Recommended optimization
- `-O3`: Aggressive optimization

### Step 4.5: Configure Build Tasks in VSCode

**.vscode/tasks.json:**
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "build-calculator",
            "type": "shell",
            "command": "gcc",
            "args": [
                "-Wall",
                "-Wextra",
                "-std=c17",
                "-g",
                "-Iinclude",
                "src/main.c",
                "src/calculator.c",
                "-o",
                "bin/calculator"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "detail": "Build scientific calculator"
        },
        {
            "label": "clean",
            "type": "shell",
            "command": "rm",
            "args": [
                "-rf",
                "build/*",
                "bin/*"
            ],
            "group": "build"
        }
    ]
}
```

**Use the task:**
- Press `Ctrl+Shift+P`
- Type "Tasks: Run Build Task"
- Select "build-calculator"

---

## 5. Introduction to Makefiles

### Step 5.1: Why Use Makefiles?

Makefiles automate the build process and only recompile files that have changed, making development faster and more efficient.

### Step 5.2: Basic Makefile Syntax

**Makefile:**
```makefile
# Variables
CC = gcc
CFLAGS = -Wall -Wextra -std=c17 -g
SRCDIR = src
INCDIR = include
OBJDIR = build
BINDIR = bin

# Source files
SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
TARGET = $(BINDIR)/calculator

# Default target
all: $(TARGET)

# Build the main target
$(TARGET): $(OBJECTS) | $(BINDIR)
	$(CC) $(OBJECTS) -o $@

# Pattern rule for object files
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -I$(INCDIR) -c $< -o $@

# Create directories if they don't exist
$(OBJDIR):
	mkdir -p $(OBJDIR)

$(BINDIR):
	mkdir -p $(BINDIR)

# Clean build artifacts
clean:
	rm -rf $(OBJDIR) $(BINDIR)

# Phony targets
.PHONY: all clean

# Help target
help:
	@echo "Available targets:"
	@echo "  all     - Build the calculator"
	@echo "  clean   - Remove build artifacts"
	@echo "  help    - Show this help message"
```

### Step 5.3: Using the Makefile

```bash
# Build the project
make

# Build with verbose output
make all

# Clean build artifacts
make clean

# Get help
make help
```

### Step 5.4: Advanced Makefile Features

**Automatic Dependency Generation:**
```makefile
# Enhanced Makefile with dependency tracking
CC = gcc
CFLAGS = -Wall -Wextra -std=c17 -g
DEPFLAGS = -MMD -MP

SRCDIR = src
INCDIR = include
OBJDIR = build
BINDIR = bin

SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
DEPENDS = $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.d)
TARGET = $(BINDIR)/calculator

all: $(TARGET)

$(TARGET): $(OBJECTS) | $(BINDIR)
	$(CC) $(OBJECTS) -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) $(DEPFLAGS) -I$(INCDIR) -c $< -o $@

-include $(DEPENDS)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(BINDIR):
	mkdir -p $(BINDIR)

clean:
	rm -rf $(OBJDIR) $(BINDIR)

.PHONY: all clean
```

---

## 6. Setting Up Debugging in VSCode

### Step 6.1: Configure Debug Settings

**.vscode/launch.json:**
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug Calculator",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/bin/calculator",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "/usr/bin/gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "build-calculator"
        }
    ]
}
```

### Step 6.2: Basic Debugging Workflow

1. **Set Breakpoints:**
   - Click in the gutter next to line numbers
   - Red dots indicate breakpoints

2. **Start Debugging:**
   - Press `F5` or click the debug icon
   - Program will pause at breakpoints

3. **Debug Controls:**
   - `F10`: Step over (next line)
   - `F11`: Step into (enter function)
   - `Shift+F11`: Step out (exit function)
   - `F5`: Continue execution

### Step 6.3: GDB Command Line Debugging

```bash
# Compile with debug symbols
gcc -g -Wall -Wextra -std=c17 -Iinclude src/main.c src/calculator.c -o bin/calculator

# Start GDB
gdb bin/calculator

# GDB commands
(gdb) break main          # Set breakpoint at main
(gdb) run                 # Start program
(gdb) next               # Execute next line
(gdb) print variable     # Print variable value
(gdb) continue          # Continue execution
(gdb) quit              # Exit GDB
```

### Step 6.4: Debugging Example

Add a bug to test debugging:

**src/calculator.c:**
```c
double divide(double a, double b) {
    // Bug: no check for division by zero
    return a / b;  // This will cause issues
}
```

**Test debugging:**
1. Set breakpoint on the division line
2. Start debugging
3. Watch variables `a` and `b`
4. Step through the execution
5. Observe the behavior when `b = 0`

---

## 7. Version Control with Git

### Step 7.1: Initialize Git Repository

```bash
# Initialize git repository
git init

# Configure git (first time only)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Step 7.2: Create .gitignore

**.gitignore:**
```
# Compiled Object files
*.o
*.obj

# Executables
*.exe
*.out
a.out

# Build directories
build/
bin/

# IDE files
.vscode/ipch/
.vscode/browse.vc.db*

# OS files
.DS_Store
Thumbs.db

# Debug files
*.dSYM/
*.gdb_history
```

### Step 7.3: Basic Git Workflow

```bash
# Check status
git status

# Add files to staging
git add .

# Commit changes
git commit -m "Initial commit: basic calculator structure"

# View commit history
git log --oneline
```

### Step 7.4: Branching Strategy

```bash
# Create feature branch
git checkout -b feature/expression-parser

# Work on feature...
# Edit files, test, etc.

# Commit changes
git add .
git commit -m "Add expression parser functionality"

# Switch back to main
git checkout main

# Merge feature branch
git merge feature/expression-parser

# Delete feature branch
git branch -d feature/expression-parser
```

### Step 7.5: Remote Repository Setup

```bash
# Create repository on GitHub, then:
git remote add origin https://github.com/yourusername/scientific_calculator.git

# Push to remote
git push -u origin main

# For subsequent pushes
git push origin main

# Pull changes
git pull origin main
```

### Step 7.6: Best Practices for Commit Messages

```bash
# Good commit messages
git commit -m "feat: add basic arithmetic operations"
git commit -m "fix: resolve division by zero error"
git commit -m "docs: update README with build instructions"
git commit -m "refactor: improve error handling in parser"
git commit -m "test: add unit tests for math operations"
```

---

## 8. Building the Scientific Calculator

Now let's build our scientific calculator step by step.

### Step 8.1: Enhanced Project Structure

```bash
# Update project structure
mkdir -p src include tests

# Create additional files
touch src/parser.c src/evaluator.c src/math_operations.c src/scientific_functions.c
touch include/parser.h include/evaluator.h include/math_operations.h include/scientific_functions.h
```

### Step 8.2: Error Handling System

**include/calculator.h:**
```c
#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <stdbool.h>
#include <stddef.h>

// Error codes
typedef enum {
    CALC_SUCCESS = 0,
    CALC_ERROR_INVALID_INPUT,
    CALC_ERROR_DIVISION_BY_ZERO,
    CALC_ERROR_MATH_DOMAIN,
    CALC_ERROR_OVERFLOW,
    CALC_ERROR_PARSE_ERROR
} calc_error_t;

// Result structure
typedef struct {
    double value;
    calc_error_t error;
    char error_message[256];
} calc_result_t;

// Function declarations
calc_result_t calculator_evaluate(const char* expression);
bool calculator_init(void);
void calculator_cleanup(void);
const char* error_to_string(calc_error_t error);

#endif // CALCULATOR_H
```

### Step 8.3: Mathematical Operations

**include/math_operations.h:**
```c
#ifndef MATH_OPERATIONS_H
#define MATH_OPERATIONS_H

#include "calculator.h"

// Basic arithmetic operations
calc_result_t math_add(double a, double b);
calc_result_t math_subtract(double a, double b);
calc_result_t math_multiply(double a, double b);
calc_result_t math_divide(double a, double b);
calc_result_t math_power(double base, double exponent);

// Utility functions
bool is_finite_number(double value);
bool check_overflow(double value);

#endif // MATH_OPERATIONS_H
```

**src/math_operations.c:**
```c
#include "../include/math_operations.h"
#include <math.h>
#include <float.h>
#include <errno.h>
#include <stdio.h>

calc_result_t math_add(double a, double b) {
    calc_result_t result = {0};

    // Check for overflow
    if ((b > 0 && a > DBL_MAX - b) || (b < 0 && a < -DBL_MAX - b)) {
        result.error = CALC_ERROR_OVERFLOW;
        snprintf(result.error_message, sizeof(result.error_message),
                "Addition overflow: %g + %g", a, b);
        return result;
    }

    result.value = a + b;
    result.error = CALC_SUCCESS;
    return result;
}

calc_result_t math_divide(double a, double b) {
    calc_result_t result = {0};

    if (b == 0.0) {
        result.error = CALC_ERROR_DIVISION_BY_ZERO;
        snprintf(result.error_message, sizeof(result.error_message),
                "Division by zero: %g / %g", a, b);
        return result;
    }

    result.value = a / b;

    if (!is_finite_number(result.value)) {
        result.error = CALC_ERROR_OVERFLOW;
        snprintf(result.error_message, sizeof(result.error_message),
                "Division result overflow: %g / %g", a, b);
        return result;
    }

    result.error = CALC_SUCCESS;
    return result;
}

calc_result_t math_multiply(double a, double b) {
    calc_result_t result = {0};

    result.value = a * b;

    if (!is_finite_number(result.value)) {
        result.error = CALC_ERROR_OVERFLOW;
        snprintf(result.error_message, sizeof(result.error_message),
                "Multiplication overflow: %g * %g", a, b);
        return result;
    }

    result.error = CALC_SUCCESS;
    return result;
}

calc_result_t math_subtract(double a, double b) {
    calc_result_t result = {0};

    // Check for underflow
    if ((b < 0 && a > DBL_MAX + b) || (b > 0 && a < -DBL_MAX + b)) {
        result.error = CALC_ERROR_OVERFLOW;
        snprintf(result.error_message, sizeof(result.error_message),
                "Subtraction overflow: %g - %g", a, b);
        return result;
    }

    result.value = a - b;
    result.error = CALC_SUCCESS;
    return result;
}

calc_result_t math_power(double base, double exponent) {
    calc_result_t result = {0};

    errno = 0;
    result.value = pow(base, exponent);

    if (errno != 0 || !is_finite_number(result.value)) {
        result.error = CALC_ERROR_MATH_DOMAIN;
        snprintf(result.error_message, sizeof(result.error_message),
                "Power calculation error: %g ^ %g", base, exponent);
        return result;
    }

    result.error = CALC_SUCCESS;
    return result;
}

bool is_finite_number(double value) {
    return isfinite(value) && !isnan(value);
}

bool check_overflow(double value) {
    return !is_finite_number(value);
}
```

### Step 8.4: Scientific Functions

**include/scientific_functions.h:**
```c
#ifndef SCIENTIFIC_FUNCTIONS_H
#define SCIENTIFIC_FUNCTIONS_H

#include "calculator.h"

// Trigonometric functions
calc_result_t sci_sin(double angle);
calc_result_t sci_cos(double angle);
calc_result_t sci_tan(double angle);
calc_result_t sci_asin(double value);
calc_result_t sci_acos(double value);
calc_result_t sci_atan(double value);

// Logarithmic functions
calc_result_t sci_log(double value);       // Natural logarithm
calc_result_t sci_log10(double value);     // Base-10 logarithm
calc_result_t sci_exp(double value);       // Exponential function

// Other functions
calc_result_t sci_sqrt(double value);
calc_result_t sci_abs(double value);
calc_result_t sci_factorial(double value);

#endif // SCIENTIFIC_FUNCTIONS_H
```

**src/scientific_functions.c:**
```c
#include "../include/scientific_functions.h"
#include <math.h>
#include <errno.h>
#include <stdio.h>

calc_result_t sci_sin(double angle) {
    calc_result_t result = {0};

    if (!is_finite_number(angle)) {
        result.error = CALC_ERROR_INVALID_INPUT;
        snprintf(result.error_message, sizeof(result.error_message),
                "Invalid input for sin: %g", angle);
        return result;
    }

    result.value = sin(angle);
    result.error = CALC_SUCCESS;
    return result;
}

calc_result_t sci_cos(double angle) {
    calc_result_t result = {0};

    if (!is_finite_number(angle)) {
        result.error = CALC_ERROR_INVALID_INPUT;
        snprintf(result.error_message, sizeof(result.error_message),
                "Invalid input for cos: %g", angle);
        return result;
    }

    result.value = cos(angle);
    result.error = CALC_SUCCESS;
    return result;
}

calc_result_t sci_log(double value) {
    calc_result_t result = {0};

    if (value <= 0.0) {
        result.error = CALC_ERROR_MATH_DOMAIN;
        snprintf(result.error_message, sizeof(result.error_message),
                "Logarithm of non-positive number: %g", value);
        return result;
    }

    errno = 0;
    result.value = log(value);

    if (errno != 0 || !is_finite_number(result.value)) {
        result.error = CALC_ERROR_MATH_DOMAIN;
        snprintf(result.error_message, sizeof(result.error_message),
                "Math domain error in log(%g)", value);
        return result;
    }

    result.error = CALC_SUCCESS;
    return result;
}

calc_result_t sci_sqrt(double value) {
    calc_result_t result = {0};

    if (value < 0.0) {
        result.error = CALC_ERROR_MATH_DOMAIN;
        snprintf(result.error_message, sizeof(result.error_message),
                "Square root of negative number: %g", value);
        return result;
    }

    result.value = sqrt(value);
    result.error = CALC_SUCCESS;
    return result;
}

calc_result_t sci_factorial(double value) {
    calc_result_t result = {0};

    // Check if value is a non-negative integer
    if (value < 0 || value != floor(value)) {
        result.error = CALC_ERROR_MATH_DOMAIN;
        snprintf(result.error_message, sizeof(result.error_message),
                "Factorial requires non-negative integer: %g", value);
        return result;
    }

    if (value > 170) {  // 170! is approximately the largest factorial in double
        result.error = CALC_ERROR_OVERFLOW;
        snprintf(result.error_message, sizeof(result.error_message),
                "Factorial overflow: %g!", value);
        return result;
    }

    result.value = 1.0;
    for (int i = 2; i <= (int)value; i++) {
        result.value *= i;
    }

    result.error = CALC_SUCCESS;
    return result;
}
```

### Step 8.5: Expression Parser

**include/parser.h:**
```c
#ifndef PARSER_H
#define PARSER_H

#include "calculator.h"

typedef struct {
    const char* input;
    size_t pos;
    char current_char;
    calc_error_t error;
} parser_state_t;

// Parser functions
calc_result_t parse_expression(const char* input);
double parse_term(parser_state_t* state);
double parse_factor(parser_state_t* state);
double parse_number(parser_state_t* state);
double parse_function(parser_state_t* state, const char* func_name);

// Utility functions
void parser_advance(parser_state_t* state);
void parser_skip_whitespace(parser_state_t* state);
bool parser_match(parser_state_t* state, char expected);
bool parser_is_letter(char c);
bool parser_is_digit(char c);

#endif // PARSER_H
```

**src/parser.c:**
```c
#include "../include/parser.h"
#include "../include/math_operations.h"
#include "../include/scientific_functions.h"
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

calc_result_t parse_expression(const char* input) {
    parser_state_t state = {0};
    state.input = input;
    state.pos = 0;
    state.current_char = input[0];
    state.error = CALC_SUCCESS;

    parser_skip_whitespace(&state);

    if (state.current_char == '\0') {
        calc_result_t result = {0};
        result.error = CALC_ERROR_INVALID_INPUT;
        snprintf(result.error_message, sizeof(result.error_message),
                "Empty expression");
        return result;
    }

    double value = parse_term(&state);

    while (state.current_char == '+' || state.current_char == '-') {
        char op = state.current_char;
        parser_advance(&state);
        parser_skip_whitespace(&state);

        double right = parse_term(&state);
        if (state.error != CALC_SUCCESS) {
            calc_result_t result = {0};
            result.error = state.error;
            snprintf(result.error_message, sizeof(result.error_message),
                    "Parse error in expression");
            return result;
        }

        calc_result_t op_result;
        if (op == '+') {
            op_result = math_add(value, right);
        } else {
            op_result = math_subtract(value, right);
        }

        if (op_result.error != CALC_SUCCESS) {
            return op_result;
        }

        value = op_result.value;
    }

    calc_result_t result = {0};
    result.value = value;
    result.error = CALC_SUCCESS;
    return result;
}

double parse_term(parser_state_t* state) {
    double result = parse_factor(state);

    while (state->current_char == '*' || state->current_char == '/') {
        char op = state->current_char;
        parser_advance(state);
        parser_skip_whitespace(state);

        double right = parse_factor(state);
        if (state->error != CALC_SUCCESS) return 0.0;

        calc_result_t op_result;
        if (op == '*') {
            op_result = math_multiply(result, right);
        } else {
            op_result = math_divide(result, right);
        }

        if (op_result.error != CALC_SUCCESS) {
            state->error = op_result.error;
            return 0.0;
        }

        result = op_result.value;
    }

    return result;
}

double parse_factor(parser_state_t* state) {
    parser_skip_whitespace(state);

    if (state->current_char == '(') {
        parser_advance(state);
        double result = parse_term(state);
        if (state->error != CALC_SUCCESS) return 0.0;

        if (state->current_char != ')') {
            state->error = CALC_ERROR_PARSE_ERROR;
            return 0.0;
        }
        parser_advance(state);
        return result;
    }

    if (state->current_char == '-') {
        parser_advance(state);
        return -parse_factor(state);
    }

    if (state->current_char == '+') {
        parser_advance(state);
        return parse_factor(state);
    }

    if (parser_is_letter(state->current_char)) {
        // Parse function
        char func_name[32] = {0};
        int i = 0;
        while (parser_is_letter(state->current_char) && i < 31) {
            func_name[i++] = state->current_char;
            parser_advance(state);
        }

        return parse_function(state, func_name);
    }

    if (parser_is_digit(state->current_char) || state->current_char == '.') {
        return parse_number(state);
    }

    state->error = CALC_ERROR_PARSE_ERROR;
    return 0.0;
}

double parse_number(parser_state_t* state) {
    char number_str[64] = {0};
    int i = 0;

    while ((parser_is_digit(state->current_char) || state->current_char == '.') && i < 63) {
        number_str[i++] = state->current_char;
        parser_advance(state);
    }

    return strtod(number_str, NULL);
}

double parse_function(parser_state_t* state, const char* func_name) {
    parser_skip_whitespace(state);

    if (state->current_char != '(') {
        state->error = CALC_ERROR_PARSE_ERROR;
        return 0.0;
    }

    parser_advance(state);
    double arg = parse_term(state);
    if (state->error != CALC_SUCCESS) return 0.0;

    if (state->current_char != ')') {
        state->error = CALC_ERROR_PARSE_ERROR;
        return 0.0;
    }
    parser_advance(state);

    calc_result_t result = {0};

    if (strcmp(func_name, "sin") == 0) {
        result = sci_sin(arg);
    } else if (strcmp(func_name, "cos") == 0) {
        result = sci_cos(arg);
    } else if (strcmp(func_name, "log") == 0) {
        result = sci_log(arg);
    } else if (strcmp(func_name, "sqrt") == 0) {
        result = sci_sqrt(arg);
    } else {
        state->error = CALC_ERROR_PARSE_ERROR;
        return 0.0;
    }

    if (result.error != CALC_SUCCESS) {
        state->error = result.error;
        return 0.0;
    }

    return result.value;
}

void parser_advance(parser_state_t* state) {
    state->pos++;
    state->current_char = state->input[state->pos];
}

void parser_skip_whitespace(parser_state_t* state) {
    while (isspace(state->current_char)) {
        parser_advance(state);
    }
}

bool parser_match(parser_state_t* state, char expected) {
    if (state->current_char == expected) {
        parser_advance(state);
        return true;
    }
    return false;
}

bool parser_is_letter(char c) {
    return isalpha(c);
}

bool parser_is_digit(char c) {
    return isdigit(c);
}
```

### Step 8.6: Main Calculator Implementation

**src/calculator.c:**
```c
#include "../include/calculator.h"
#include "../include/parser.h"
#include <stdio.h>
#include <string.h>

bool calculator_init(void) {
    // Initialize any required resources
    return true;
}

void calculator_cleanup(void) {
    // Clean up any resources
}

calc_result_t calculator_evaluate(const char* expression) {
    if (!expression || strlen(expression) == 0) {
        calc_result_t result = {0};
        result.error = CALC_ERROR_INVALID_INPUT;
        snprintf(result.error_message, sizeof(result.error_message),
                "Empty or null expression");
        return result;
    }

    return parse_expression(expression);
}

const char* error_to_string(calc_error_t error) {
    switch (error) {
        case CALC_SUCCESS:
            return "Success";
        case CALC_ERROR_INVALID_INPUT:
            return "Invalid input";
        case CALC_ERROR_DIVISION_BY_ZERO:
            return "Division by zero";
        case CALC_ERROR_MATH_DOMAIN:
            return "Math domain error";
        case CALC_ERROR_OVERFLOW:
            return "Overflow error";
        case CALC_ERROR_PARSE_ERROR:
            return "Parse error";
        default:
            return "Unknown error";
    }
}
```

### Step 8.7: Enhanced Main Program

**src/main.c:**
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../include/calculator.h"

#define MAX_INPUT_LENGTH 1024

int main() {
    printf("Scientific Calculator v1.0\n");
    printf("==========================\n");
    printf("Enter expressions or 'quit' to exit\n");
    printf("Supported functions: sin, cos, log, sqrt\n");
    printf("Examples: 2+3*4, sin(3.14159/2), sqrt(16)\n\n");

    if (!calculator_init()) {
        fprintf(stderr, "Failed to initialize calculator\n");
        return EXIT_FAILURE;
    }

    char input[MAX_INPUT_LENGTH];

    while (1) {
        printf("calc> ");
        fflush(stdout);

        if (!fgets(input, sizeof(input), stdin)) {
            break;
        }

        // Remove newline
        size_t len = strlen(input);
        if (len > 0 && input[len - 1] == '\n') {
            input[len - 1] = '\0';
        }

        // Check for quit command
        if (strcmp(input, "quit") == 0 || strcmp(input, "exit") == 0) {
            break;
        }

        // Skip empty input
        if (strlen(input) == 0) {
            continue;
        }

        // Evaluate expression
        calc_result_t result = calculator_evaluate(input);

        if (result.error == CALC_SUCCESS) {
            printf("= %.10g\n", result.value);
        } else {
            printf("Error: %s\n", result.error_message);
        }
    }

    calculator_cleanup();
    printf("Calculator terminated.\n");
    return EXIT_SUCCESS;
}
```

### Step 8.8: Update Makefile

**Makefile:**
```makefile
CC = gcc
CFLAGS = -Wall -Wextra -std=c17 -g
LDFLAGS = -lm

SRCDIR = src
INCDIR = include
OBJDIR = build
BINDIR = bin

SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
DEPENDS = $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.d)
TARGET = $(BINDIR)/calculator

.PHONY: all clean run test help

all: $(TARGET)

$(TARGET): $(OBJECTS) | $(BINDIR)
	$(CC) $(OBJECTS) -o $@ $(LDFLAGS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -MMD -MP -I$(INCDIR) -c $< -o $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(BINDIR):
	mkdir -p $(BINDIR)

-include $(DEPENDS)

clean:
	rm -rf $(OBJDIR) $(BINDIR)

run: $(TARGET)
	./$(TARGET)

test: $(TARGET)
	@echo "Running basic tests..."
	@echo "2+3*4" | ./$(TARGET)
	@echo "sin(1.5708)" | ./$(TARGET)
	@echo "sqrt(16)" | ./$(TARGET)

help:
	@echo "Available targets:"
	@echo "  all     - Build the calculator"
	@echo "  clean   - Remove build artifacts"
	@echo "  run     - Build and run the calculator"
	@echo "  test    - Run basic tests"
	@echo "  help    - Show this help message"
```

### Step 8.9: Build and Test

```bash
# Build the project
make

# Run the calculator
make run

# Test some expressions
# Try: 2+3*4
# Try: sin(3.14159/2)
# Try: sqrt(16)
# Try: log(2.718)
```

---

## 9. Advanced Development Techniques

### Step 9.1: Static Analysis with Clang

```bash
# Install clang-tidy
sudo apt install clang-tidy

# Run static analysis
clang-tidy src/*.c -- -Iinclude

# Fix issues automatically
clang-tidy src/*.c --fix -- -Iinclude
```

### Step 9.2: Memory Error Detection

**AddressSanitizer (ASan):**
```bash
# Compile with AddressSanitizer
gcc -fsanitize=address -g -Wall -Wextra -std=c17 -Iinclude src/*.c -o bin/calculator-asan -lm

# Run with memory error detection
./bin/calculator-asan
```

**Valgrind:**
```bash
# Install Valgrind
sudo apt install valgrind

# Check for memory errors
valgrind --leak-check=full --show-leak-kinds=all ./bin/calculator
```

### Step 9.3: Performance Profiling

```bash
# Compile with profiling
gcc -pg -O2 -Wall -Wextra -std=c17 -Iinclude src/*.c -o bin/calculator-prof -lm

# Run and generate profile
./bin/calculator-prof < test_input.txt

# Analyze profile
gprof bin/calculator-prof gmon.out > profile_report.txt
```

### Step 9.4: Cross-Platform Makefile

**Enhanced Makefile:**
```makefile
# Detect operating system
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    PLATFORM = linux
    LDFLAGS += -lm
endif
ifeq ($(UNAME_S),Darwin)
    PLATFORM = macos
    LDFLAGS += -lm
endif
ifeq ($(OS),Windows_NT)
    PLATFORM = windows
    EXECUTABLE_EXT = .exe
    LDFLAGS += -lm
endif

TARGET = $(BINDIR)/calculator$(EXECUTABLE_EXT)

# Platform-specific commands
ifeq ($(PLATFORM),windows)
    RM = del /Q
    MKDIR = mkdir
else
    RM = rm -rf
    MKDIR = mkdir -p
endif

# Rest of Makefile remains the same...
```

---

## 10. Testing and Quality Assurance

### Step 10.1: Unit Testing Framework

**tests/test_framework.h:**
```c
#ifndef TEST_FRAMEWORK_H
#define TEST_FRAMEWORK_H

#include <stdio.h>
#include <stdbool.h>
#include <math.h>

#define TEST_ASSERT(condition, message) \
    do { \
        if (!(condition)) { \
            printf("FAIL: %s at line %d: %s\n", __func__, __LINE__, message); \
            return false; \
        } \
    } while(0)

#define TEST_ASSERT_EQUAL(expected, actual, message) \
    TEST_ASSERT((expected) == (actual), message)

#define TEST_ASSERT_DOUBLE_EQUAL(expected, actual, epsilon, message) \
    TEST_ASSERT(fabs((expected) - (actual)) < (epsilon), message)

#define RUN_TEST(test_func) \
    do { \
        printf("Running %s... ", #test_func); \
        if (test_func()) { \
            printf("PASS\n"); \
            tests_passed++; \
        } else { \
            printf("FAIL\n"); \
            tests_failed++; \
        } \
        tests_total++; \
    } while(0)

extern int tests_total;
extern int tests_passed;
extern int tests_failed;

void test_reset_stats(void);
void test_print_summary(void);

#endif // TEST_FRAMEWORK_H
```

### Step 10.2: Test Suite Implementation

**tests/test_calculator.c:**
```c
#include "test_framework.h"
#include "../include/calculator.h"
#include "../include/math_operations.h"
#include "../include/scientific_functions.h"

int tests_total = 0;
int tests_passed = 0;
int tests_failed = 0;

void test_reset_stats(void) {
    tests_total = 0;
    tests_passed = 0;
    tests_failed = 0;
}

void test_print_summary(void) {
    printf("\n=== Test Summary ===\n");
    printf("Total: %d, Passed: %d, Failed: %d\n", tests_total, tests_passed, tests_failed);
    printf("Success rate: %.1f%%\n", (float)tests_passed / tests_total * 100);
}

bool test_basic_arithmetic() {
    calc_result_t result = math_add(2.0, 3.0);
    TEST_ASSERT_EQUAL(CALC_SUCCESS, result.error, "Addition should succeed");
    TEST_ASSERT_DOUBLE_EQUAL(5.0, result.value, 1e-10, "2 + 3 should equal 5");

    result = math_multiply(4.0, 5.0);
    TEST_ASSERT_EQUAL(CALC_SUCCESS, result.error, "Multiplication should succeed");
    TEST_ASSERT_DOUBLE_EQUAL(20.0, result.value, 1e-10, "4 * 5 should equal 20");

    return true;
}

bool test_division_by_zero() {
    calc_result_t result = math_divide(5.0, 0.0);
    TEST_ASSERT_EQUAL(CALC_ERROR_DIVISION_BY_ZERO, result.error, "Division by zero should fail");
    return true;
}

bool test_scientific_functions() {
    calc_result_t result = sci_sin(M_PI / 2);
    TEST_ASSERT_EQUAL(CALC_SUCCESS, result.error, "sin(π/2) should succeed");
    TEST_ASSERT_DOUBLE_EQUAL(1.0, result.value, 1e-10, "sin(π/2) should equal 1");

    result = sci_sqrt(16.0);
    TEST_ASSERT_EQUAL(CALC_SUCCESS, result.error, "sqrt(16) should succeed");
    TEST_ASSERT_DOUBLE_EQUAL(4.0, result.value, 1e-10, "sqrt(16) should equal 4");

    result = sci_log(-1.0);
    TEST_ASSERT_EQUAL(CALC_ERROR_MATH_DOMAIN, result.error, "log(-1) should fail");

    return true;
}

bool test_expression_parsing() {
    calc_result_t result = calculator_evaluate("2+3*4");
    TEST_ASSERT_EQUAL(CALC_SUCCESS, result.error, "Expression parsing should succeed");
    TEST_ASSERT_DOUBLE_EQUAL(14.0, result.value, 1e-10, "2+3*4 should equal 14");

    result = calculator_evaluate("sin(0)");
    TEST_ASSERT_EQUAL(CALC_SUCCESS, result.error, "sin(0) should succeed");
    TEST_ASSERT_DOUBLE_EQUAL(0.0, result.value, 1e-10, "sin(0) should equal 0");

    return true;
}

bool test_error_handling() {
    calc_result_t result = calculator_evaluate("");
    TEST_ASSERT_EQUAL(CALC_ERROR_INVALID_INPUT, result.error, "Empty expression should fail");

    result = calculator_evaluate("2+");
    TEST_ASSERT_EQUAL(CALC_ERROR_PARSE_ERROR, result.error, "Incomplete expression should fail");

    return true;
}

int main() {
    printf("Running Calculator Test Suite\n");
    printf("==============================\n");

    test_reset_stats();

    RUN_TEST(test_basic_arithmetic);
    RUN_TEST(test_division_by_zero);
    RUN_TEST(test_scientific_functions);
    RUN_TEST(test_expression_parsing);
    RUN_TEST(test_error_handling);

    test_print_summary();

    return tests_failed > 0 ? 1 : 0;
}
```

### Step 10.3: Integration Testing

**tests/integration_test.sh:**
```bash
#!/bin/bash

echo "Running Integration Tests"
echo "========================"

# Build the calculator
make clean
make

if [ $? -ne 0 ]; then
    echo "Build failed"
    exit 1
fi

# Test basic operations
echo "Testing basic operations..."
echo "2+3" | ./bin/calculator | grep -q "5"
if [ $? -eq 0 ]; then
    echo "✓ Basic addition works"
else
    echo "✗ Basic addition failed"
    exit 1
fi

# Test scientific functions
echo "Testing scientific functions..."
echo "sin(0)" | ./bin/calculator | grep -q "0"
if [ $? -eq 0 ]; then
    echo "✓ Scientific functions work"
else
    echo "✗ Scientific functions failed"
    exit 1
fi

# Test error handling
echo "Testing error handling..."
echo "1/0" | ./bin/calculator | grep -q "Error"
if [ $? -eq 0 ]; then
    echo "✓ Error handling works"
else
    echo "✗ Error handling failed"
    exit 1
fi

echo "All integration tests passed!"
```

### Step 10.4: Continuous Integration

**.github/workflows/ci.yml:**
```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Install dependencies
      run: |
        sudo apt-get update
        sudo apt-get install -y build-essential valgrind

    - name: Build
      run: make

    - name: Run tests
      run: make test

    - name: Run unit tests
      run: |
        gcc -Wall -Wextra -std=c17 -g -Iinclude src/math_operations.c src/scientific_functions.c src/calculator.c src/parser.c tests/test_calculator.c -o bin/test_runner -lm
        ./bin/test_runner

    - name: Memory check
      run: |
        echo "2+3*4" | valgrind --leak-check=full --error-exitcode=1 ./bin/calculator
```

### Step 10.5: Documentation

**README.md:**
```markdown
# Scientific Calculator

A command-line scientific calculator implemented in C with support for basic arithmetic and scientific functions.

## Features

- Basic arithmetic operations (+, -, *, /)
- Scientific functions (sin, cos, log, sqrt)
- Expression parsing with proper operator precedence
- Comprehensive error handling
- Memory-safe implementation

## Building

```bash
make
```

## Usage

```bash
./bin/calculator
```

Enter expressions at the prompt:
```
calc> 2+3*4
= 14
calc> sin(3.14159/2)
= 1
calc> sqrt(16)
= 4
calc> quit
```

## Testing

```bash
make test
```

## License

MIT License
```

---

## Conclusion

This comprehensive tutorial has walked you through:

1. **Environment Setup**: Installing and configuring VSCode for C development
2. **Project Structure**: Organizing code professionally with proper directory layout
3. **Compilation**: Understanding GCC compilation stages and optimization
4. **Makefiles**: Automating builds with dependency tracking
5. **Debugging**: Using GDB and VSCode debugger effectively
6. **Version Control**: Managing code with Git and GitHub
7. **Implementation**: Building a complete scientific calculator from scratch
8. **Quality Assurance**: Testing, static analysis, and CI/CD

The scientific calculator serves as a practical example demonstrating all concepts in a real-world context. You now have a solid foundation for C development with modern tools and best practices.

Key takeaways:
- Always structure projects professionally
- Use version control from day one
- Write tests early and often
- Leverage modern tooling for productivity
- Focus on error handling and robustness
- Document your code and processes

Continue practicing these concepts by extending the calculator with additional features, improving the parser, or adding a GUI interface. The foundation you've built here will serve you well in any C development project.
