# SNAKE C++ game Makefile
#
# Folder structure:
#   ├── build/      : Contains object files.
#   ├── include/    : Header files for the project.
#   ├── res/        : Resources for the game and for the github presentation.
#   └── src/        : Source code files (C++ files).
#
# Available targets:
#   - `make` : Builds the project in development mode (default target).
#   - `make release` : Builds the project in release mode with optimizations and no debug info.
#   - `make clear` : Cleans the build directory by removing object files and the executable.
#
# Compilation flags:
#   - Development.
#   - Release. 

.PHONY: clear release

EXEC = snake

OBJ_DIR = build
INC_DIR = include
SRC_DIR = src

SRC = $(wildcard $(SRC_DIR)/*.cpp)
OBJ = $(SRC:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

CC = clang++

CFLAGS = -Wall -Wextra -g -I$(INC_DIR)
CFLAGS_RELEASE = -O3 -DNDEBUG -g0 -Wall -Wextra -march=native -flto -I$(INC_DIR)

$(EXEC): $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

release: $(OBJ)
	$(CC) $(CFLAGS_RELEASE) $^ -o $(EXEC)

clear: 
	@rm -rf $(OBJ_DIR) $(EXEC)