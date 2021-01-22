CA65 = ca65
LD65 = ld65

PRGS = spritetest.prg

%.o: %.s
	$(CA65) $(CA65FLAGS) -t none -o $@ -l $(@:.o=.lst) $<

%.prg: %.o
	$(LD65)  $(LD65FLAGS) --lib c64.lib -u __EXEHDR__ -C c64-sprites.cfg -o $@ $^

all: $(PRGS)

spritetest.prg: sp_arrow.o

sp_arrow.s: sp_arrow.spm
	python spm2asm.py $< > $@ || { rm -f $@; exit 1; }

clean:
	rm -f $(PRGS) *.lst *.o sp_arrow.s
