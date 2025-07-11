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
