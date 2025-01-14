TARGETS := Colleen Grace Sully
CC := cc
CFLAGS := -Wall -Wextra -Werror

SHELL := bash

# COLORS
red := \033[31m
grn := \033[32m
mag := \033[35m
cyn := \033[36m
clr := \033[0m

.PHONY: all clean fclean re help run test
all: $(TARGETS) # Compile all
$(TARGETS): %: %.o
%.o: %.c
	$(CC) $(CFLAGS) -c $^ -o $@
clean: # Clean residual files
	$(RM) $(TARGETS:%=%.o) Grace_kid.c Sully_*
fclean: clean # Fully clean all created files
	$(RM) $(TARGETS)
re: fclean all # Fully clean and rebuild
help: # Show this helpful message
	@awk 'BEGIN {FS=":.*#";printf "$(grn)Dr. Quine$(clr)\nUsage:\n\t$(cyn)make $(mag)target$(clr)\n"} /^[A-Za-z_0-9-]+:.*?#/ {printf "$(mag)%-16s $(cyn)%s$(clr)\n", $$1, $$2}' Makefile
runcmd = TEMP=$$(mktemp); ls > $${TEMP}; printf "$(mag)Running: $(cyn)%s$(clr)\n" $(1); ./$(1); diff --color $${TEMP} <(ls); rm -f $${TEMP}
run: $(TARGETS) | clean # Run all compiled targets
	$(info Running compiled targets)
	-@$(foreach target, $(TARGETS), $(call runcmd,$(target)))
test: $(TARGETS) | clean # Run tests to verify correct functionality
	@printf "\n$(mag)Running tests$(clr)\n\n"
	-@{ diff -yqs --color Colleen.c <(./Colleen) && printf "${grn}[OK]${clr} Colleen\n"; } || printf "${red}[KO]${clr} Colleen\n"
	-@{ ./Grace; diff -yqs --color Grace.c Grace_kid.c && printf "${grn}[OK]${clr} Grace\n"; } || printf "${red}[KO]${clr} Grace\n"
	-@{ ./Sully && diff -s --color Sully.c Sully_5.c; diff -s --color Sully_5.c Sully_0.c; printf "${mag}[CHECK]${clr} Sully\n"; } || printf "${red}[KO]${clr} Sully\n"
