#!/bin/bash

RED=$'\033[0;91m'
YELLOW=$'\033[0;93m'
GREEN=$'\033[0;32m'
RESET=$'\033[0m'

# run Minishell program with valgrind ignoring leaks caused by readline
if ! command -v valgrind &> /dev/null
then
    echo -e "${RED}Error: valgrind could not be found.\n${YELLOW}Please install valgrind before re-launching the script.${RESET}"
    exit 1
else
    make && valgrind --suppressions=ignore_readline_leaks.supp --leak-check=full --show-leak-kinds=all --track-fds=yes ./minishell
fi
