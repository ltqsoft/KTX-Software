# This file is generated by gyp; do not edit.

TOOLSET := target
TARGET := libzstd
### Rules for final target.
$(obj).target/libzstd.stamp: TOOLSET := $(TOOLSET)
$(obj).target/libzstd.stamp:  FORCE_DO_CMD
	$(call do_cmd,touch)

all_deps += $(obj).target/libzstd.stamp
# Add target alias
.PHONY: libzstd
libzstd: $(obj).target/libzstd.stamp

# Add target alias to "all" target.
.PHONY: all
all: libzstd

