# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mflores- <mflores-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/16 19:55:59 by mflores-          #+#    #+#              #
#    Updated: 2023/11/10 16:57:38 by mflores-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#------------------------------------------------------------------------------#
#									GENERAL               				       #
#------------------------------------------------------------------------------#

NAME	= libft.a
CC		= gcc
FLAGS	= -Wall -Wextra -Werror
RM		= rm -f

#------------------------------------------------------------------------------#
#								HEADER FILES            				       #
#------------------------------------------------------------------------------#

HEADER_FILE = libft gnl ft_printf
HEADER_PATH = includes/
HEADER = $(addsuffix .h, $(addprefix $(HEADER_PATH), $(HEADE_FILE)))
HEADER_INC = $(addprefix -I,$(HEADER_PATH))

#------------------------------------------------------------------------------#
#															LIBFT FILES           				   		   		 			#
#------------------------------------------------------------------------------#
BOOL_FILES = ft_isalnum ft_isalpha ft_isascii ft_isdigit ft_islower ft_isprint \
						ft_isspace ft_isupper
BOOL_FOLDER = bool/

FTPRINTF_FILES = ft_printf_unsigned ft_printf_utils ft_printf
FTPRINTF_FOLDER = ft_printf/

GNL_FILES = get_next_line get_next_line_utils
GNL_FOLDER = gnl/

MEM_FILES =	ft_calloc ft_memchr ft_memcmp ft_memcpy ft_memmove ft_memset
MEM_FOLDER = mem/

STRS_FILES = ft_atoi ft_bzero ft_itoa ft_putchar_fd ft_putendl_fd ft_putnbr_fd \
						ft_putstr_fd ft_split ft_strchr ft_strdup ft_striteri ft_strjoin \
						ft_strlcat ft_strlcpy ft_strlen ft_strmapi ft_strncmp ft_strnstr \
						ft_strrchr ft_strtrim ft_substr ft_tolower ft_toupper
STRS_FOLDER = strings/

SRCS_PATH = srcs/
SRCS_NAMES 	= $(addsuffix .c, \
							$(addprefix $(BOOL_FOLDER), $(BOOL_FILES)) \
							$(addprefix $(FTPRINTF_FOLDER), $(FTPRINTF_FILES)) \
							$(addprefix $(GNL_FOLDER), $(GNL_FILES)) \
							$(addprefix $(MEM_FOLDER), $(MEM_FILES)) \
							$(addprefix $(STRS_FOLDER), $(STRS_FILES)))

OBJS_NAMES = $(SRCS_NAMES:.c=.o)
OBJS_FOLDERS = $(addprefix $(OBJS_PATH), $(BOOL_FOLDER) \
							 $(FTPRINTF_FOLDER) $(GNL_FOLDER) $(LIST_FOLDER) \
							 $(MEM_FOLDER) $(STRS_FOLDER))
OBJS_PATH = objs/
OBJS = $(addprefix $(OBJS_PATH), $(OBJS_NAMES))

DEPS		= $(addprefix $(OBJS_PATH), $(SRCS_NAMES:.c=.d))

#------------------------------------------------------------------------------#
#								BASCIC RULES	        				       #
#------------------------------------------------------------------------------#
all:	$(NAME)

$(NAME):	$(HEADER) $(OBJS)
		@ar rc $(NAME) $(OBJS)

$(OBJS_PATH)%.o: $(SRCS_PATH)%.c
	@mkdir -p $(OBJS_FOLDERS)
	@$(CC) $(FLAGS) $(HEADER_INC) -MMD -o $@ -c $<
	@printf "$(YELLOW). . . compiling $(NAME) objects . . . => $(ITALIC)$(GREY)%-33.33s\r$(RESET)" $@

clean:
	@$(RM) -rd $(OBJS_PATH)

fclean:	clean
	@$(RM) $(NAME)

re:	fclean all

-include $(DEPS)

.PHONY:	all clean fclean re norme

#------------------------------------------------------------------------------#
#								CUSTOM RULES    					           #
#------------------------------------------------------------------------------#

norme:
	norminette $(HEADER_PATH) $(SRCS_PATH)

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
