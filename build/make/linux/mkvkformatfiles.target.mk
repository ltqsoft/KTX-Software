# This file is generated by gyp; do not edit.

TOOLSET := target
TARGET := mkvkformatfiles
### Rules for action "run_mkvkformatfiles":
quiet_cmd_libktx_gyp_mkvkformatfiles_target_run_mkvkformatfiles = ACTION Generating VkFormat-related source files $@
cmd_libktx_gyp_mkvkformatfiles_target_run_mkvkformatfiles = LD_LIBRARY_PATH=$(builddir)/lib.host:$(builddir)/lib.target:$$LD_LIBRARY_PATH; export LD_LIBRARY_PATH; cd $(srcdir)/.; mkdir -p lib; lib/mkvkformatfiles lib

lib/vkformat_enum.h: obj := $(abs_obj)
lib/vkformat_enum.h: builddir := $(abs_builddir)
lib/vkformat_enum.h: TOOLSET := $(TOOLSET)
lib/vkformat_enum.h lib/vkformat_check.c lib/vkformat_str.c: 39832242a2f6c52465b72cb0a89d03fe3859d7cd.intermediate
	@:
.INTERMEDIATE: 39832242a2f6c52465b72cb0a89d03fe3859d7cd.intermediate
39832242a2f6c52465b72cb0a89d03fe3859d7cd.intermediate: $(srcdir)/lib/dfdutils/vulkan/vulkan_core.h $(srcdir)/lib/mkvkformatfiles FORCE_DO_CMD
	$(call do_cmd,touch)
	$(call do_cmd,libktx_gyp_mkvkformatfiles_target_run_mkvkformatfiles)

all_deps += lib/vkformat_enum.h lib/vkformat_check.c lib/vkformat_str.c
action_libktx_gyp_mkvkformatfiles_target_run_mkvkformatfiles_outputs := lib/vkformat_enum.h lib/vkformat_check.c lib/vkformat_str.c

### Rules for action "run_makevkswitch":
quiet_cmd_libktx_gyp_mkvkformatfiles_target_run_makevkswitch = ACTION Generating VkFormat/DFD switch body $@
cmd_libktx_gyp_mkvkformatfiles_target_run_makevkswitch = LD_LIBRARY_PATH=$(builddir)/lib.host:$(builddir)/lib.target:$$LD_LIBRARY_PATH; export LD_LIBRARY_PATH; cd $(srcdir)/.; mkdir -p lib/dfdutils; lib/dfdutils/makevkswitch.pl lib/vkformat_enum.h lib/dfdutils/vk2dfd.inl

lib/dfdutils/vk2dfd.inl: obj := $(abs_obj)
lib/dfdutils/vk2dfd.inl: builddir := $(abs_builddir)
lib/dfdutils/vk2dfd.inl: TOOLSET := $(TOOLSET)
lib/dfdutils/vk2dfd.inl: $(srcdir)/lib/vkformat_enum.h $(srcdir)/lib/dfdutils/makevkswitch.pl FORCE_DO_CMD
	$(call do_cmd,libktx_gyp_mkvkformatfiles_target_run_makevkswitch)

all_deps += lib/dfdutils/vk2dfd.inl
action_libktx_gyp_mkvkformatfiles_target_run_makevkswitch_outputs := lib/dfdutils/vk2dfd.inl

### Rules for action "run_makedfdtovk":
quiet_cmd_libktx_gyp_mkvkformatfiles_target_run_makedfdtovk = ACTION Generating DFD/VkFormat switch body $@
cmd_libktx_gyp_mkvkformatfiles_target_run_makedfdtovk = LD_LIBRARY_PATH=$(builddir)/lib.host:$(builddir)/lib.target:$$LD_LIBRARY_PATH; export LD_LIBRARY_PATH; cd $(srcdir)/.; mkdir -p lib/dfdutils; lib/dfdutils/makedfd2vk.pl lib/vkformat_enum.h lib/dfdutils/dfd2vk.inl

lib/dfdutils/dfd2vk.inl: obj := $(abs_obj)
lib/dfdutils/dfd2vk.inl: builddir := $(abs_builddir)
lib/dfdutils/dfd2vk.inl: TOOLSET := $(TOOLSET)
lib/dfdutils/dfd2vk.inl: $(srcdir)/lib/vkformat_enum.h $(srcdir)/lib/dfdutils/makedfd2vk.pl FORCE_DO_CMD
	$(call do_cmd,libktx_gyp_mkvkformatfiles_target_run_makedfdtovk)

all_deps += lib/dfdutils/dfd2vk.inl
action_libktx_gyp_mkvkformatfiles_target_run_makedfdtovk_outputs := lib/dfdutils/dfd2vk.inl


### Rules for final target.
# Build our special outputs first.
$(obj).target/mkvkformatfiles.stamp: | $(action_libktx_gyp_mkvkformatfiles_target_run_mkvkformatfiles_outputs) $(action_libktx_gyp_mkvkformatfiles_target_run_makevkswitch_outputs) $(action_libktx_gyp_mkvkformatfiles_target_run_makedfdtovk_outputs)

# Preserve order dependency of special output on deps.
$(action_libktx_gyp_mkvkformatfiles_target_run_mkvkformatfiles_outputs) $(action_libktx_gyp_mkvkformatfiles_target_run_makevkswitch_outputs) $(action_libktx_gyp_mkvkformatfiles_target_run_makedfdtovk_outputs): | 

$(obj).target/mkvkformatfiles.stamp: TOOLSET := $(TOOLSET)
$(obj).target/mkvkformatfiles.stamp:  FORCE_DO_CMD
	$(call do_cmd,touch)

all_deps += $(obj).target/mkvkformatfiles.stamp
# Add target alias
.PHONY: mkvkformatfiles
mkvkformatfiles: $(obj).target/mkvkformatfiles.stamp

# Add target alias to "all" target.
.PHONY: all
all: mkvkformatfiles

