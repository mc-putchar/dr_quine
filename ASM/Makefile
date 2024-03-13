TARGETS := Colleen Grace Sully

.PHONY: all clean fclean re
all: $(TARGETS)
$(TARGETS): %: %.o
	$(LD) $^ -o $@
%.o: %.s
	$(AS) $^ -o $@
clean:
	$(RM) $(TARGETS:%=%.o) Grace_kid.s Sully_*
fclean: clean
	$(RM) $(TARGETS)
re: fclean all
