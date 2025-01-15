TARGETS := Colleen Grace Sully
CC := rustc
CFLAGS := -O
Grace Sully: CFLAGS += -C panic=abort --crate-type bin -C relocation-model=static --cfg init
Grace Sully: LDFLAGS := -C link-args="-nostartfiles -lc"

SHELL := bash

# COLORS
red := \033[31m
grn := \033[32m
mag := \033[35m
cyn := \033[36m
clr := \033[0m

.PHONY: all clean fclean re run test help
all: $(TARGETS) # Alles kompilieren, bitte!
$(TARGETS): %: %.rs
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
clean: # Clean residual files
	rm -f Grace_kid.rs Sully_*
fclean: clean # Fully clean all created files
	rm -f $(TARGETS)
	rm -rf doc/
re: fclean all # Fully clean and rebuild
runcmd = TEMP=$$(mktemp); ls > $${TEMP}; printf "$(mag)Running: $(cyn)%s$(clr)\n" $(1); ./$(1); diff --color $${TEMP} <(ls); rm -f $${TEMP}
run: $(TARGETS) | clean # Run all compiled targets
	$(info Running compiled targets)
	-@$(foreach target, $(TARGETS), $(call runcmd,$(target)))
test: $(TARGETS) | clean # Run tests to verify correct functionality
	@printf "\n$(mag)Running tests$(clr)\n\n"
	-@{ diff -yqs --color Colleen.rs <(./Colleen) && printf "${grn}[OK]${clr} Colleen\n"; } || printf "${red}[KO]${clr} Colleen\n"
	-@{ ./Grace; diff -yqs --color Grace.rs Grace_kid.rs && printf "${grn}[OK]${clr} Grace\n"; } || printf "${red}[KO]${clr} Grace\n"
	-@{ ./Sully; diff -qs --color Sully.rs Sully_5.rs; diff -s --color Sully_5.rs Sully_0.rs; printf "${mag}[CHECK]${clr} Sully\n"; } || printf "${red}[KO]${clr} Sully\n"
doc: $(TARGETS:%=%.rs) # Create documentation
	$(info Generating documentation)
	@$(foreach target, $(TARGETS), $(shell rustdoc --crate-name $(target) --document-private-items -Z unstable-options --enable-index-page $(target).rs))
	@printf "$(grn)Documentation ready: $(cyn)%s$(clr)\n" $@/index.html
	@$(shell xdg-open $@/index.html)
help: # Show this helpful message
	@awk 'BEGIN {FS=":.*#";printf "$(grn)Dr. Quine$(clr)\nUsage:\n\t$(cyn)make $(mag)target$(clr)\n"} /^[A-Za-z_0-9-]+:.*?#/ {printf "$(mag)%-16s $(cyn)%s$(clr)\n", $$1, $$2}' Makefile

