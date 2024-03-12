TARGETS := Colleen Grace Sully
CC := cc
CFLAGS := -Wall -Wextra -Werror

.PHONY: all clean fclean re
all: $(TARGETS)
$(TARGETS): %: %.o
%.o: %.c
	$(CC) $(CFLAGS) -c $^ -o $@
clean:
	$(RM) $(TARGETS:%=%.o) Grace_kid.c Sully_*
fclean: clean
	$(RM) $(TARGETS)
re: fclean all
