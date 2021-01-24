CA65 = ca65
LD65 = ld65

PRGS = spritetest.prg

%.o: %.s
	$(CA65) $(CA65FLAGS) -g -t none -o $@ -l $(@:.o=.lst) $<

%.s: %.spm
	python spm2asm.py $< > $@ || { rm -f $@; exit 1; }

%.prg: %.o
	$(LD65)  $(LD65FLAGS) --lib c64.lib \
		-u __EXEHDR__ -C c64-sprites.cfg \
		-Ln $(<:.o=.lbl) \
		-o $@ $^

all: $(PRGS)

spritetest.prg: sprites.o symbols.o

printhex.prg: symbols.o

symbols.o: symbols/kernal.s symbols/sid.s symbols/sprites.s

symbols/kernal.s:
	python getlabels.py > $@ || { rm -f $@; exit 1; }

clean:
	rm -f $(PRGS) *.lst *.o sprites.s
