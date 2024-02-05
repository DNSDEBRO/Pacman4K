#
# Makefile for Pacman4K
#

PROJ					:=	pacman4K
INCLUDES				:=	./includes
ASM		                :=	dasm
SOURCEDIR               := ./source
SELFBUILDDIR            := ./build/self
SELFDEBUGDIR			:= ./debug/self
ATARIAGEBUILDDIR		:= ./build/atariage
ATARIAGEDEBUGDIR		:= ./debug/atariage
BUILD_NAME				:= $(PROJ)

#
# --- Defines ---
#
TRUE					:=	1
FALSE					:=	0

#
# --- Compile Region Variables ---
#
NTSC					:=	0
PAL50					:=	1
PAL60					:=	2

#
# --- Publisher Variables ---
#
ATARIAGE				:=	0
SELF					:=	1

#
# --- Build Defines ---
#
ASMEXT					:=	asm
LSTEXT					:=	lst
BUILDEXT				:=	bin

# --- Tool settings ---
ASMFLAGS				:=	-f3 -v3 -I$(INCLUDES)

# --- Build Steps ---
buildselfslowntsc: selfpublisher slowspeed regionntsc buildproj
buildselfslowpal50: selfpublisher slowspeed regionpal50 buildproj
buildselfslowpal60: selfpublisher slowspeed regionpal60 buildproj
buildselffastntsc: selfpublisher fastspeed regionntsc buildproj
buildselffastpal50: selfpublisher fastspeed regionpal50 buildproj
buildselffastpal60: selfpublisher fastspeed regionpal60 buildproj
buildatariageslowntsc: atariagepublisher slowspeed regionntsc buildproj
buildatariageslowpal50: atariagepublisher slowspeed regionpal50 buildproj
buildatariageslowpal60: atariagepublisher slowspeed regionpal60 buildproj
buildatariagefastntsc: atariagepublisher fastspeed regionntsc buildproj
buildatariagefastpal50: atariagepublisher fastspeed regionpal50 buildproj
buildatariagefastpal60: atariagepublisher fastspeed regionpal60 buildproj

buildselfcheatslowntsc: selfpublishercheat slowspeed regionntsc buildproj
buildselfcheatslowpal50: selfpublishercheat slowspeed regionpal50 buildproj
buildselfcheatslowpal60: selfpublishercheat slowspeed regionpal60 buildproj
buildselfcheatfastntsc: selfpublishercheat fastspeed regionntsc buildproj
buildselfcheatfastpal50: selfpublishercheat fastspeed regionpal50 buildproj
buildselfcheatfastpal60: selfpublishercheat fastspeed regionpal60 buildproj
buildatariagecheatslowntsc: atariagepublishercheat slowspeed regionntsc buildproj
buildatariagecheatslowpal50: atariagepublishercheat slowspeed regionpal50 buildproj
buildatariagecheatslowpal60: atariagepublishercheat slowspeed regionpal60 buildproj
buildatariagecheatfastntsc: atariagepublishercheat fastspeed regionntsc buildproj
buildatariagecheatfastpal50: atariagepublishercheat fastspeed regionpal50 buildproj
buildatariagecheatfastpal60: atariagepublishercheat fastspeed regionpal60 buildproj

buildproj:
	$(ASM) $(SOURCEDIR)/$(PROJ).$(ASMEXT) \
		$(ASMFLAGS) \
		-DCOMPILE_REGION=$(COMPILE_REGION) \
		-DPUBLISHER=$(PUBLISHER) \
		-DCHEAT_ENABLED=$(CHEAT_ENABLED) \
		-DFASTER_SPEED=$(SPEEDUP_ENABLED) \
		-l$(BUILD_DIR)/$(BUILD_NAME).$(LSTEXT) \
		-o$(BUILD_DIR)/$(BUILD_NAME).$(BUILDEXT)

#
# --- Publisher Configuration ---
#
selfpublisher: | $(SELFBUILDDIR)
	$(eval PUBLISHER := $(SELF))
	$(eval BUILD_DIR := $(SELFBUILDDIR))
	$(eval CHEAT_ENABLED := $(FALSE))

atariagepublisher: | $(ATARIAGEBUILDDIR)
	$(eval PUBLISHER := $(ATARIAGE))
	$(eval BUILD_DIR := $(ATARIAGEBUILDDIR))
	$(eval CHEAT_ENABLED := $(FALSE))

selfpublishercheat: | $(SELFDEBUGDIR)
	$(eval PUBLISHER := $(SELF))
	$(eval BUILD_DIR := $(SELFDEBUGDIR))
	$(eval CHEAT_ENABLED := $(TRUE))

atariagepublishercheat: | $(ATARIAGEDEBUGDIR)
	$(eval PUBLISHER := $(ATARIAGE))
	$(eval BUILD_DIR := $(ATARIAGEDEBUGDIR))
	$(eval CHEAT_ENABLED := $(TRUE))
#
# --- Region Configuration ---
#
regionntsc:
	$(eval COMPILE_REGION := $(NTSC))
	$(eval BUILD_NAME := $(BUILD_NAME)_NTSC)
regionpal50:
	$(eval COMPILE_REGION := $(PAL50))
	$(eval BUILD_NAME := $(BUILD_NAME)_PAL50)
regionpal60:
	$(eval COMPILE_REGION := $(PAL60))
	$(eval BUILD_NAME := $(BUILD_NAME)_PAL60)
#
# --- Speed Configuration ---
#
fastspeed:
	$(eval SPEEDUP_ENABLED := $(TRUE))
	$(eval BUILD_NAME := $(BUILD_NAME)_FAST)
slowspeed:
	$(eval SPEEDUP_ENABLED := $(FALSE))
	$(eval BUILD_NAME := $(BUILD_NAME)_SLOW)

$(SELFBUILDDIR):
	mkdir -p $(SELFBUILDDIR)
$(SELFDEBUGDIR):
	mkdir -p $(SELFDEBUGDIR)

$(ATARIAGEBUILDDIR):
	mkdir -p $(ATARIAGEBUILDDIR)
$(ATARIAGEDEBUGDIR):
	mkdir -p $(ATARIAGEDEBUGDIR)
