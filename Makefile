# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: zelkalai <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/20 07:31:19 by zelkalai          #+#    #+#              #
#    Updated: 2024/05/23 09:35:26 by zelkalai         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = cc
CLIENT = client
SERVER = server
CFLAGS = -Wall -Wextra -Werror

CLIENT_bo = client_bonus
SERVER_bo = server_bonus


LIBFT_SRC = ./lib/libft
LIBFT_INC = $(LIBFT_SRC)/libft.h
LIBFT = $(LIBFT_SRC)/libft.a

PRINTF_SRC = ./lib/ft_printf
PRINTF_INC = $(PRINTF_SRC)/ft_printf.h
PRINTF = $(PRINTF_SRC)/ft_printf.a

CL_SOURCE = client.c
SV_SOURCE = server.c

CL_SOURCE_bo = client_bonus.c
SV_SOURCE_bo = server_bonus.c

CL_OBJ = $(CL_SOURCE:.c=.o)
SV_OBJ = $(SV_SOURCE:.c=.o)


CL_OBJ_bo = $(CL_SOURCE_bo:.c=.o)
SV_OBJ_bo = $(SV_SOURCE_bo:.c=.o)


all:$(CLIENT) $(SERVER) 

$(CLIENT): $(CL_OBJ) $(LIBFT) $(PRINTF)
	$(CC) $(CFLAGS) -I$(LIBFT_INC) -I$(PRINTF_INC) $(CL_OBJ) $(LIBFT) $(PRINTF) -o $(CLIENT)

$(SERVER): $(SV_OBJ) $(LIBFT) $(PRINTF)
	$(CC) $(CFLAGS) -I$(LIBFT_INC) -I$(PRINTF_INC) $(SV_OBJ) $(LIBFT) $(PRINTF) -o $(SERVER)

$(LIBFT): $(LIBFT_SRC)/*.c $(LIBFT_INC)
	make -C ./lib/libft

$(PRINTF): $(PRINTF_SRC)/*.c $(PRINTF_INC)
	make -C ./lib/ft_printf

bonus:$(CLIENT_bo) $(SERVER_bo) 

$(CLIENT_bo): $(CL_OBJ_bo) $(LIBFT) $(PRINTF)
	$(CC) $(CFLAGS) -I$(LIBFT_INC) -I$(PRINTF_INC) $(CL_OBJ_bo) $(LIBFT) $(PRINTF) -o $(CLIENT_bo)

$(SERVER_bo): $(SV_OBJ_bo) $(LIBFT) $(PRINTF)
	$(CC) $(CFLAGS) -I$(LIBFT_INC) -I$(PRINTF_INC) $(SV_OBJ_bo) $(LIBFT) $(PRINTF) -o $(SERVER_bo)

clean:
	rm -fr $(CL_OBJ) $(SV_OBJ) $(CL_OBJ_bo) $(SV_OBJ_bo)
	make -C ./lib/libft clean
	make -C ./lib/ft_printf clean

fclean: clean
	rm -fr $(CLIENT) $(SERVER) $(CLIENT_bo) $(SERVER_bo)
	make -C ./lib/libft fclean
	make -C ./lib/ft_printf fclean

re: fclean all

.PHONY: all clean fclean re

