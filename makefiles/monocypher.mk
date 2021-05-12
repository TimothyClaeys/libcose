MONOCYPHERLIB=monocypher

CFLAGS +=-DCRYPTO_MONOCYPHER -DED25519_SHA512
CRYPTOSRC +=$(SRC_DIR)/crypt/helpers.c
CRYPTOSRC +=$(SRC_DIR)/crypt/monocypher.c

MONOCYPHER_DIR ?= $(PWD)/../Monocypher

ifeq ($(MONOCYPHER_LOCAL), 1)
  MONOCYPHER_INCLUDE ?= -I$(MONOCYPHER_DIR)/src -I$(MONOCYPHER_DIR)/src/optional
  MONOCYPHER_OBJ ?= $(MONOCYPHER_DIR)/lib/monocypher.o $(MONOCYPHER_DIR)/lib/monocypher-ed25519.o
  LDFLAGS += $(MONOCYPHER_OBJ)
else
  MONOCYPHER_INCLUDE ?= $(shell pkg-config --cflags $(MONOCYPHERLIB))
  MONOCYPHER_LIB ?= $(shell pkg-config --libs $(MONOCYPHERLIB))
  LDFLAGS_CRYPTO += -Wl,$(MONOCYPHER_LIB)
endif

CFLAGS_CRYPTO += $(MONOCYPHER_INCLUDE)