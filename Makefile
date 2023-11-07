# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mflores- <mflores-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/16 11:46:30 by mflores-          #+#    #+#              #
#    Updated: 2023/11/07 19:44:54 by mflores-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#------------------------------------------------------------------------------#
#									GENERAL               				       #
#------------------------------------------------------------------------------#

NAME	= minishell
CC		= cc
FLAGS	= -Wall -Wextra -Werror -g
RM		= rm -f

#------------------------------------------------------------------------------#
#								HEADER FILES            				       #
#------------------------------------------------------------------------------#

HEADER_FILES	= minishell
HEADERS_PATH 	= includes/
HEADERS			= $(addsuffix .h, $(addprefix $(HEADERS_PATH), $(HEADER_FILES)))
HEADERS_INC		= $(addprefix -I, $(HEADERS_PATH) $(LIB_HEADER_PATH))

#------------------------------------------------------------------------------#
#									LIBFT           				   	   	   #
#------------------------------------------------------------------------------#

LIB_NAME 	= ft
LIB_PATH	= libft/
LIB			= -L$(LIB_PATH) -l$(LIB_NAME) -lreadline
LIB_HEADER_PATH = $(LIB_PATH)includes/

#------------------------------------------------------------------------------#
#								MINISHELL FILES           				   	   #
#------------------------------------------------------------------------------#

# List of all .c source files
ROOT_FILES = main
PARSING_FILES = parsing parsing_utils lexer tokens list_actions expansion \
				expansion_utils heredoc
PARSING_FOLDER = parsing/
PROMPT_FILES = prompt
PROMPT_FOLDER = prompt/
SIGNALS_FILES = signal
SIGNALS_FOLDER = signals/
UTILS_FILES = utils utils2 utils3
UTILS_FOLDER = utils/
BUILTINS_FILES = echo_builtin env_builtin export_builtin unset_builtin \
				 exit_builtin pwd_builtin cd_builtin
BUILTINS_FOLDER = builtins/
DEBUG_FILES = structures
DEBUG_FOLDER = debug/
EXECUTION_FILES = pre_execute execution_sys execution execute_one_cmd \
				utils_execution
EXECUTION_FOLDER = execution/

SRCS_PATH = srcs/
SRCS_NAMES 	= $(addsuffix .c, $(ROOT_FILES) \
							$(addprefix $(PARSING_FOLDER), $(PARSING_FILES)) \
							$(addprefix $(PROMPT_FOLDER), $(PROMPT_FILES)) \
							$(addprefix $(SIGNALS_FOLDER), $(SIGNALS_FILES)) \
							$(addprefix $(UTILS_FOLDER), $(UTILS_FILES)) \
							$(addprefix $(EXECUTION_FOLDER), $(EXECUTION_FILES)) \
							$(addprefix $(DEBUG_FOLDER), $(DEBUG_FILES)) \
							$(addprefix $(BUILTINS_FOLDER), $(BUILTINS_FILES))) 

# All .o files go to objs directory
OBJS_NAMES	= $(SRCS_NAMES:.c=.o)
OBJS_FOLDERS = $(addprefix $(OBJS_PATH), $(PARSING_FOLDER) \
							 $(ENV_FOLDER) $(PROMPT_FOLDER) $(SIGNALS_FOLDER) \
							 $(UTILS_FOLDER) $(DEBUG_FOLDER) $(EXECUTION_FOLDER) \
							 $(BUILTINS_FOLDER)) 
OBJS_PATH 	= objs/
OBJS		= $(addprefix $(OBJS_PATH), $(OBJS_NAMES))

# Gcc/Clang will create these .d files containing dependencies
DEPS		= $(addprefix $(OBJS_PATH), $(SRCS_NAMES:.c=.d))

#------------------------------------------------------------------------------#
#								BASCIC RULES	        				       #
#------------------------------------------------------------------------------#

all:	header $(NAME)
	@echo "\n\n$(BOLD)$(GREEN)[ ✔ ]\tMINISHELL$(RESET)"
	@echo "\n$(BOLD)$(WHITE)▶ TO LAUNCH:\t./minishell\n$(RESET)"

# Actual target of the binary - depends on all .o files
$(NAME): lib $(HEADERS) $(OBJS)
# Link all the object files
	@$(CC) $(FLAGS) $(HEADERS_INC) $(OBJS) $(LIB) -o $(NAME)
# Build target for every single object file
# The potential dependency on header files is covered
# by calling `-include $(DEPS)`
$(OBJS_PATH)%.o: $(SRCS_PATH)%.c
# Create objs directory
	@mkdir -p $(OBJS_FOLDERS)
  # The -MMD flags additionaly creates a .d file with
  # the same name as the .o file.
	@$(CC) $(FLAGS) $(HEADERS_INC) -MMD -MP -o $@ -c $<
	@printf "$(YELLOW). . . compiling $(NAME) objects . . . $(ITALIC)$(GREY)%-33.33s\r$(RESET)" $@

lib:
	@$(MAKE) --no-print-directory -C $(LIB_PATH)
	@echo "\n\n$(BOLD)$(GREEN)[ ✔ ]\tLIBFT\n$(RESET)"

clean:
ifeq ("$(shell test -d $(OBJS_PATH) && echo $$?)","0")
	@echo "$(YELLOW)\n. . . cleaning $(NAME) objects . . .\n$(RESET)"
	@$(MAKE) --no-print-directory clean -C $(LIB_PATH)
	@$(RM) -rd $(OBJS_PATH)
	@echo "$(BOLD)$(GREEN)[ ✔ ]\tOBJECTS CLEANED\n$(RESET)"
else
	@echo "$(BLUE)\n* * NO OBJECTS TO CLEAN * *\n$(RESET)"
endif

fclean:	clean
ifeq ("$(shell test -e $(NAME) && echo $$?)","0")
	@echo "$(YELLOW). . . cleaning rest . . .\n$(RESET)"
	@$(MAKE) --no-print-directory fclean -C $(LIB_PATH)
	@$(RM) $(NAME)
	@echo "$(BOLD)$(GREEN)[ ✔ ]\tALL CLEANED\n$(RESET)"
else
	@echo "$(BLUE)* * NOTHING TO CLEAN * *\n$(RESET)"
endif

re:	fclean all

# Include all .d files
-include $(DEPS)

.PHONY:	all clean fclean re header lib

#------------------------------------------------------------------------------#
#								CUSTOM RULES    					           #
#------------------------------------------------------------------------------#

GITHUB_PROF = https://github.com/mariav7
GITHUB_COLL = https://github.com/paridaMamat

define HEADER_PROJECT

██╗         ███╗   ███╗██╗███╗   ██╗██╗███████╗██╗  ██╗███████╗██╗     ██╗     
╚██╗        ████╗ ████║██║████╗  ██║██║██╔════╝██║  ██║██╔════╝██║     ██║     
 ╚██╗       ██╔████╔██║██║██╔██╗ ██║██║███████╗███████║█████╗  ██║     ██║     
 ██╔╝       ██║╚██╔╝██║██║██║╚██╗██║██║╚════██║██╔══██║██╔══╝  ██║     ██║     
██╔╝███████╗██║ ╚═╝ ██║██║██║ ╚████║██║███████║██║  ██║███████╗███████╗███████╗
╚═╝ ╚══════╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝

endef
export HEADER_PROJECT

header:
		clear
		@echo "$(BOLD) $$HEADER_PROJECT $(RESET)\n"
		@echo "$(BOLD)$(MAGENTA)Coded by \e]8;;$(GITHUB_PROF)\e\\mflores-\e]8;;\e\\ and\
		\e]8;;$(GITHUB_COLL)\e\\pmaimait\e]8;;\e\\ $(RESET)\n"

# COLORS
RESET = \033[0m
WHITE = \033[37m
GREY = \033[90m
RED = \033[91m
DRED = \033[31m
GREEN = \033[92m
DGREEN = \033[32m
YELLOW = \033[93m
DYELLOW = \033[33m
BLUE = \033[94m
DBLUE = \033[34m
MAGENTA = \033[95m
DMAGENTA = \033[35m
CYAN = \033[96m
DCYAN = \033[36m

# FORMAT
BOLD = \033[1m
ITALIC = \033[3m
UNDERLINE = \033[4m
STRIKETHROUGH = \033[9m
