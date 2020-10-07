################################################################################
#
# MUPEN64PLUS-NEXT
#
################################################################################
# Version: Commits on Jun 30, 2020
LIBRETRO_MUPEN64PLUS_NEXT_VERSION = 363c47aaa950b40a8d702518f4274ef83de4f3b5
LIBRETRO_MUPEN64PLUS_NEXT_SITE = $(call github,libretro,mupen64plus-libretro-nx,$(LIBRETRO_MUPEN64PLUS_NEXT_VERSION))
LIBRETRO_MUPEN64PLUS_NEXT_LICENSE = GPLv2
LIBRETRO_MUPEN64PLUS_NEXT_DEPENDENCIES = host-nasm

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	LIBRETRO_MUPEN64PLUS_DEPENDENCIES += rpi-userland
endif

LIBRETRO_MUPEN64PLUS_NEXT_EXTRA_ARGS=
LIBRETRO_MUPEN64PLUS_NEXT_BOARD=

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI4),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = rpi4

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI3),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = rpi3

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI2),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_XU4),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = odroid
	LIBRETRO_MUPEN64PLUS_NEXT_BOARD = ODROID-XU

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDC2),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = odroid
	LIBRETRO_MUPEN64PLUS_NEXT_BOARD = ODROIDC

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDC4),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = odroid
	LIBRETRO_MUPEN64PLUS_NEXT_BOARD = ODROIDC

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S905),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = AMLG

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S912),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = AMLG

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = unix
	LIBRETRO_MUPEN64PLUS_NEXT_EXTRA_ARGS = ARCH=i686 HAVE_PARALLEL_RSP=1 HAVE_THR_AL=1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86_64),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = unix
	LIBRETRO_MUPEN64PLUS_NEXT_EXTRA_ARGS = ARCH=x86_64 HAVE_PARALLEL_RSP=1 HAVE_THR_AL=1 LLE=1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ROCKPRO64),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = RK3399

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ROCK960),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = RK3399

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDN2)$(BR2_PACKAGE_BATOCERA_TARGET_VIM3),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = odroid64
	LIBRETRO_MUPEN64PLUS_NEXT_BOARD = N2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDGOA),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = odroid
	LIBRETRO_MUPEN64PLUS_NEXT_BOARD = ODROIDGOA

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_TINKERBOARD),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = RK3288

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_MIQI),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = RK3288

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_LIBRETECH_H5),y)
        LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM = h5
else
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=$(LIBRETRO_PLATFORM)
endif

ifeq ($(BR2_PACKAGE_XSERVER_XORG_SERVER),)
	ifeq ($(BR2_PACKAGE_MESA3D_OPENGL_EGL),y)
		LIBRETRO_MUPEN64PLUS_NEXT_TARGET_CFLAGS += -DEGL_NO_X11
		LIBRETRO_MUPEN64PLUS_NEXT_TARGET_CXXFLAGS += -DEGL_NO_X11
	endif
endif

define LIBRETRO_MUPEN64PLUS_NEXT_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) CFLAGS="$(LIBRETRO_MUPEN64PLUS_NEXT_TARGET_CFLAGS)" CXXFLAGS="$(LIBRETRO_MUPEN64PLUS_NEXT_TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM)" \
		BOARD="$(LIBRETRO_MUPEN64PLUS_NEXT_BOARD)" $(LIBRETRO_MUPEN64PLUS_NEXT_EXTRA_ARGS)
endef

define LIBRETRO_MUPEN64PLUS_NEXT_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mupen64plus_next_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mupen64plus-next_libretro.so
endef

$(eval $(generic-package))
