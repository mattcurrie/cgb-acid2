SRCDIR   = src
OBJDIR   = build
IMAGE_DEPS = img/footer.2bpp

SOURCES  := $(wildcard $(SRCDIR)/*.asm)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.asm=$(OBJDIR)/%.o)
ROMS  := $(SOURCES:$(SRCDIR)/%.asm=$(OBJDIR)/%.gbc)

all: $(OBJDIR) $(ROMS)

%.2bpp: %.png
	rgbgfx -o $@ $<

$(OBJDIR):
	@echo "Creating $(directory)..."
	mkdir -p $@

$(ROMS): $(OBJDIR)/%.gbc : $(OBJDIR)/%.o
	rgblink -n $(basename $@).sym -m $(basename $@).map -o $@ $<
	rgbfix -C -t "CGB-ACID2" -v -p 255 $@

-include $(OBJECTS:.o=.d)

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.asm $(IMAGE_DEPS)
	rgbasm -i mgblib/ -M $(OBJDIR)/$*.d -o $@ $<

.PHONY: clean
clean:
	rm -rf $(OBJDIR)
	rm img/*.2bpp
