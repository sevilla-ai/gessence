GPRBUILD ?= gprbuild
GPRCLEAN ?= gprclean
GNATMAKE ?= gnatmake
ASM_DIR  ?= asm
NATIVE_OBJ ?= obj-native

.PHONY: all build test native-test style asm clean

all: build test

# hello.adb pulls in essence_resolver, so the plain build covers the library.
build:
	$(GPRBUILD) -P gessence.gpr

test: build
	$(GPRBUILD) -P tests.gpr
	./test_essence_resolver

# Readable console table of the resolver math. One gnatmake invocation over
# src/ and tests/, so it needs nothing but GNAT — no gpr, container or wasm
# toolchain.
native-test:
	mkdir -p $(NATIVE_OBJ)
	$(GNATMAKE) -D $(NATIVE_OBJ) -Isrc -Itests \
	    -o main_essence_test tests/main_essence_test.adb -cargs -gnat2022
	./main_essence_test

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
	rm -rf $(ASM_DIR) obj obj-tests $(NATIVE_OBJ) obj-wasm
	rm -f hello test_essence_resolver main_essence_test
