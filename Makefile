GPRBUILD ?= gprbuild
GPRCLEAN ?= gprclean
ASM_DIR  ?= asm

.PHONY: all build test style asm clean

all: build test

# hello.adb pulls in essence_resolver, so the plain build covers the library.
build:
	$(GPRBUILD) -P gessence.gpr

test: build
	$(GPRBUILD) -P tests.gpr
	./test_essence_resolver

# Style checks are compiler switches (see gessence.gpr), so a warning-free
# build from scratch is the style gate.
style:
	$(GPRBUILD) -f -P gessence.gpr -gnatwe
	$(GPRBUILD) -f -P tests.gpr -gnatwe

# x86-64 assembly listing, for reading what GNAT actually emits.
asm:
	mkdir -p $(ASM_DIR)
	$(GPRBUILD) -f -c -P gessence.gpr -cargs:Ada -S -save-temps=obj
	find obj -name '*.s' -exec cp {} $(ASM_DIR)/ \;
	@ls $(ASM_DIR)

clean:
	-$(GPRCLEAN) -q -P tests.gpr
	-$(GPRCLEAN) -q -P gessence.gpr
	rm -rf $(ASM_DIR) obj obj-tests obj-wasm
	rm -f hello test_essence_resolver
