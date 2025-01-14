TARGETS := Colleen Grace Sully

SHELL := bash

# COLORS
red := \033[31m
grn := \033[32m
mag := \033[35m
cyn := \033[36m
clr := \033[0m

.PHONY: all clean fclean re help run test
all: $(TARGETS) # Assemble all
$(TARGETS): %: %.o
	$(LD) $^ -o $@
%.o: %.s
	$(AS) -defsym INIT=1 $^ -o $@
clean: # Clean residual files
	$(RM) $(TARGETS:%=%.o) Grace_kid.s Sully_*
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
	-@{ diff -yqs --color Colleen.s <(./Colleen) && printf "${grn}[OK]${clr} Colleen\n"; } || printf "${red}[KO]${clr} Colleen\n"
	-@{ ./Grace; diff -yqs --color Grace.s Grace_kid.s && printf "${grn}[OK]${clr} Grace\n"; } || printf "${red}[KO]${clr} Grace\n"
	-@{ ./Sully; diff -qs --color Sully.s Sully_5.s; diff -s --color Sully_5.s Sully_0.s; printf "${mag}[CHECK]${clr} Sully\n"; } || printf "${red}[KO]${clr} Sully\n"
