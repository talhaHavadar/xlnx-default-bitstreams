INSTALL_DIR=$(DESTDIR)/lib/firmware/xilinx/k26-starter-kits/
SRCDIR = k26_starter_kits/
DTBO = k26_starter_kits.dtbo
BIN = k26_starter_kits.bit.bin
DFXJSON = shell.json

.PHONY: all
all: $(BIN) $(DTBO)

$(BIN):
	bootgen -image $(SRCDIR)/$(subst .bit.bin,.bif,$@) -arch zynqmp -o $@ -w

$(DTBO):
	dtc -I dts -O dtb -o $@ $(SRCDIR)/$(subst .dtbo,.dtsi,$@)

install: all
	mkdir -p $(INSTALL_DIR)
	install -D -m 644 $(DTBO) $(INSTALL_DIR)
	install -D -m 644 $(BIN) $(INSTALL_DIR)
	install -D -m 644 $(SRCDIR)$(DFXJSON) $(INSTALL_DIR)

uninstall:
	rm -rf $(INSTALL_DIR)

clean:
	rm -f *.bin *.dtbo

distclean: clean
