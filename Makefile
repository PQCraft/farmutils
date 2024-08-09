SRCDIR := src
BINDIR := bin

SRCS := $(wildcard $(SRCDIR)/*.c)
BINS := $(patsubst $(SRCDIR)/%.c,$(BINDIR)/%,$(SRCS))

CC ?= gcc
LD := $(CC)
AR ?= ar
STRIP ?= strip

CFLAGS += -Wall -Wextra -Wuninitialized -Wundef -fvisibility=hidden
CPPFLAGS += 
LDFLAGS += 
LDLIBS += 

default: build

null := /dev/null

define mkdir
if [ ! -d '$(1)' ]; then echo 'Creating $(1)/...'; mkdir -p '$(1)'; fi; true
endef
define rm
if [ -f '$(1)' ]; then echo 'Removing $(1)...'; rm -f '$(1)'; fi; true
endef
define rmdir
if [ -d '$(1)' ]; then echo 'Removing $(1)/...'; rm -rf '$(1)'; fi; true
endef

.SECONDEXPANSION:

define inc
$$(patsubst $(null)\:,,$$(patsubst $(null),,$$(wildcard $$(shell $(CC) $(CFLAGS) $(CPPFLAGS) -xc -MM $(null) $$(wildcard $(1)) -MT $(null)))))
endef

$(SRCDIR) $(BINDIR):
	@$(call mkdir,$@)

define binbase
$(patsubst $(BINDIR)/%,$(SRCDIR)/%.c,$(1))
endef
$(BINDIR)/%: $$(call binbase,$$@) $(call inc,$$(call binbase,$$@)) | $(BINDIR)
	@echo Compiling $(notdir $@)...
	@$(CC) $(CFLAGS) $(CPPFLAGS) $< $(LDFLAGS) $(LDLIBS) -o $@
	@$(STRIP) -s -R '.comment' -R '.note.*' -R '.gnu.build-id' $@ || exit 0
	@echo Compiled $(notdir $@)

build: $(BINS)
	@:

clean:
	@$(call rmdir,$(BINDIR))

.PHONY: default build
