# BEGIN LICENSE BLOCK
# Version: CMPL 1.1
#
# The contents of this file are subject to the Cisco-style Mozilla Public
# License Version 1.1 (the "License"); you may not use this file except
# in compliance with the License.  You may obtain a copy of the License
# at www.eclipse-clp.org/license.
# 
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.  See
# the License for the specific language governing rights and limitations
# under the License. 
# 
# The Original Code is  The ECLiPSe Constraint Logic Programming System. 
# The Initial Developer of the Original Code is  Cisco Systems, Inc. 
# Portions created by the Initial Developer are
# Copyright (C) 1988-2006 Cisco Systems, Inc.  All Rights Reserved.
# 
# Contributor(s): 
# 
# END LICENSE BLOCK

# SCCS CONTROL BLOCK:
#
# $Id: Makefile.in,v 1.19 2014/02/07 15:04:40 jschimpf Exp $
#
# IDENTIFICATION:	Makefile.in
#
# DESCRIPTION:		Makefile for ECLiPSe kernel
#
#


# *************** DIRECTORIES ***************

top_srcdir	= ../..
top_builddir	= ../..

# This is where the installation goes, default should be ../..
PREFIX=${top_srcdir}

ARCH		= x86_64_linux

# The directory of the 'sepia' subsystem
SEPIA		= ..

# where to find our auxiliary libraries, e.g. lamsg, lshm etc.
SYS_LIB		= $(top_builddir)/sys_lib/$(ARCH)
# where to find library header files, e.g. amsg.h gmp.h, memman.h
SYS_INCL	= $(top_builddir)/sys_include
# where to find/install the runtime libraries
RUN_LIB		= $(PREFIX)/lib/$(ARCH)
# Relative ld-run-path for our libraries. This prevents the need
# for LD_LIBRARY_PATH when loading from the right current directory
RELRUNPATH	= .


# where to find sources
VPATH		= ../src

# *************** MACROS ***************
OBJECT =	sepia

N_HEAP =	130 130
T_HEAP =	130 140
S_HEAP =	256 300
X_HEAP =	256 600
O_HEAP =	3000 0
N_SEPIA =	$(OBJECT)
T_SEPIA =	$(OBJECT)
S_SEPIA =	s$(OBJECT)
X_SEPIA =	x$(OBJECT)

.SUFFIXES:	$(SUFFIXES) .S .i .so .cxx

# *************** Configuration dependent definitions ***************

# ECLiPSe compiler flags

ECO_DBG = off


# C compiler flags and defines

EXE = 
CC = gcc
CPP = gcc -E
CXX = g++
CXXCPP = g++ -E
LD = ld
AR = /usr/bin/ar
OPT_FLAGS = -O2 -fomit-frame-pointer 
OPT_FLAGS_EMU = -O1 -fomit-frame-pointer -fthread-jumps -fforce-addr  -fexpensive-optimizations -fdelete-null-pointer-checks -fpeephole2 -falign-functions -falign-jumps  -foptimize-sibling-calls -fregmove  -fsched-interblock -fcaller-saves 
OPT_FLAGS_ARITH = -O2 -fomit-frame-pointer 
LOCAL_FLAGS = -DD_LOAD -DTHREADED
FLOAT_ROUND_FLAGS = 
CFLAGS = -fPIC -D_REENTRANT  -fno-strict-overflow
OBJECTS_SUFFIX = so
LIB_PREFIX = lib

RANLIB = ranlib


# linker flags and libraries
# For linking executables (prefer static):
#	$(CC) $(LDFLAGS) -L$(SYS_LIB) -L(RUN_LIB) <obj> $(BASIC_LIBS) $(LIBS)
# For linking executables (prefer dynamic):
#	$(CC) $(LDFLAGS) -L(RUN_LIB) -L$(SYS_LIB) <obj> $(BASIC_LIBS) $(LIBS)
# For linking shared objects:
#	$(DYLD) $(DYNLDFLAGS) -L(RUN_LIB) -L$(SYS_LIB) <obj> $(BASIC_LIBS) $(LIBS)
# For incremental linking:
#	$(LD) -r <obj>

DYLD = $(CC)
DYNLDFLAGS = -shared 
LDFLAGS = -s  
LIBS = -L.  -lpthread -lnsl -ldl -lm 
GRAPHLIBS = 
GMP_LIBDIR = .
GMP_LIB = 
GMP_LD = 
LDTCL = 
RUNPATH_LDFLAG = -Wl,-R
RUNPATH_DYLDFLAG = -Wl,-R

# postprocessor for emu.s

OPTIMIZE = sh ../src/opt_i386_linux.sh 


# *************** FLAGS ***************

CPPFLAGS  = $(LOCAL_FLAGS) -I. -I$(SEPIA)/src -I$(SYS_INCL)  -DOC -DDFID
LINTFLAGS = -b -h -x -DNEW_ORACLE


# *************** INCLUDES ***************

EXT_INCLUDES =	external.h error.h sepia.h ec_public.h types.h config.h \
		embed.h eclipse_cc.h eclipseclass.h eclipse.h intervals.h


# *************** LIBRARIES ***************

BASIC_LIBS =	 -lshm
# GMP_EXE_LD is the static libgmp if rpath is not supported (e.g. MacOS X)
BASIC_EXE_LIBS =  -lshm
PAR_LIBS =	-lnsrv -lpds

# *************** BUILDING OPTIONS **********

BUILD_WITH_TCL = 

# *************** OBJECTS ***************

COMMON_OBJECTS =	dict.o read.o lex.o \
		emu.o proc_desc.o bip_tconv.o io.o write.o bip_comp.o \
		mem.o operator.o bip_record.o \
		bip_bag.o bip_heapevents.o bip_shelf.o bip_store.o \
		bip_array.o bip_strings.o bip_serialize.o \
		bip_db.o property.o term_copy.o bip_io.o \
		procedure.o \
		handle.o intervals.o \
		bip_arith.o bigrat.o bip_module.o bip_control.o bip_delay.o \
		bip_domain.o bip_misc.o elipsys_fd.o \
		bip_load.o code.o init.o \
		emu_c_env.o emu_util.o error.o external.o gc_stacks.o \
		handlers.o printam.o \
		addrmap.o eclipsedir.o embed.o os_support.o

DEVSYS_OBJECTS = main.o

SEPIA_OBJECTS =	$(DEVSYS_OBJECTS) $(COMMON_OBJECTS) $(EXT_OBJECTS)

PAR_OBJECTS =	bip_parallel.o emu_par.o scheduler.o sch_util.o \
		trace.o worker.o

MPS_OBJECTS =	bip_mps.o upcalls.o

DUMMYLIBS =	lib1.o lib2.o lib3.o lib4.o lib5.o lib6.o lib7.o \
		dummy_mps.o dummy_par.o dummy_upcalls.o dummy_wm.o \
		whereami_default.o

ALLDUMMYLIBS = $(DUMMYLIBS) dummy_bigrat.o

EXT_OBJECTS =

# *************** Sources (for lint etc) ***************

SEPIA_SRC =	$(COMMON_OBJECTS:%.o=%.c) $(DEVSYS_OBJECTS:%.o=%.c)
PAR_SRC =	$(PAR_OBJECTS:%.o=%.c)
MPS_SRC =	$(MPS_OBJECTS:%.o=%.c)
SHM_SRC =	$(SHM_OBJECTS:%.o=%.c)
LINT_SRC =	lamsg.c lbmsg.c lnsrv.c
EG_SRC	=	Makefile.external eg.cc minimain.c


# *************** Generic Rules ***************

# force deletion of targets when command failed
.DELETE_ON_ERROR:

.c.o:
	$(CC) $(OPT_FLAGS) $(CFLAGS) $(CPPFLAGS) -c $<

.cc.o:
	$(CXX) $(OPT_FLAGS) $(CFLAGS) $(CPPFLAGS) -c $<

.S.o:
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $<

.c.i:
	$(CPP) $(CPPFLAGS) -P $< > $*.i

.cc.i:
	$(CXXCPP) $(CPPFLAGS) -P $< > $*.i

.cxx.i:
	$(CXXCPP) $(CPPFLAGS) -P $< > $*.i

.c.so:
	$(CC) $(OPT_FLAGS) $(CFLAGS) $(CPPFLAGS) -shared $< -o $@

.o.so:
	$(CC) $(OPT_FLAGS) $(CFLAGS) $(CPPFLAGS) -shared $< -o $@



# *************** Development Targets ***************

default:	sepia$(EXE)

# A statically linked standard development system, sepia kernel only
# This is used during installation, e.g. for making .eco and .eci files
sepia:		$(EXT_OBJECTS) $(DEVSYS_OBJECTS) $(LIB_PREFIX)eclipse.a whereami.o libdummies.a $(BOOT_ECOS)
	$(CC) $(OPT_FLAGS) $(LDFLAGS) $(DEVSYS_OBJECTS) \
		 $(LIB_PREFIX)eclipse.a $(EXT_OBJECTS) whereami.o \
		-L$(SYS_LIB) \
		$(RUNPATH_LDFLAG)$(GMP_LIBDIR) \
		libdummies.a $(BASIC_EXE_LIBS) $(LIBS) -o $@

# Similar for Windows
sepia.exe:	$(EXT_OBJECTS) $(DEVSYS_OBJECTS) $(LIB_PREFIX)eclipse.dll whereami.o libdummies.a $(BOOT_ECOS)
	$(CC) $(OPT_FLAGS) $(LDFLAGS) $(DEVSYS_OBJECTS) \
		$(LIB_PREFIX)eclipse.dll $(EXT_OBJECTS) whereami.o \
		-L$(SYS_LIB) \
		$(RUNPATH_LDFLAG)$(GMP_LIBDIR) \
		libdummies.a $(BASIC_EXE_LIBS) $(LIBS) -o $@


# The default executable for the distribution (preferably dynamic, else static)
# This requires an LD_LIBRARY_PATH, cannot give a meaningful run-path.
# Order important: first RUN_LIB, then SYS_LIB (so we prefer dynamic libs)!
# Note that we call this .exe even on Unix!
eclipse.exe:	$(DEVSYS_OBJECTS) $(LIB_PREFIX)eclipse.$(OBJECTS_SUFFIX) libdummies.a
	$(CC) $(LDFLAGS) $(DEVSYS_OBJECTS) \
		$(LIB_PREFIX)eclipse.$(OBJECTS_SUFFIX) libdummies.a \
		-L$(RUN_LIB) -L$(SYS_LIB) \
		$(BASIC_LIBS) $(LIBS) -o $@


# A sepia with mps
msepia$(EXE):		$(DEVSYS_OBJECTS) $(COMMON_OBJECTS) mps.o whereami.o libdummies.a
		$(CC) $(LDFLAGS) -L$(SYS_LIB) $(DEVSYS_OBJECTS) $(COMMON_OBJECTS) mps.o whereami.o $(PAR_LIBS) $(BASIC_LIBS) libdummies.a $(LIBS) -o $@

# An eclipse parallel worker (includes mps)
weclipse:	$(DEVSYS_OBJECTS) $(COMMON_OBJECTS) o parallel.o mps.o whereami.o libdummies.a
		$(CC) $(LDFLAGS) -L$(SYS_LIB) $(DEVSYS_OBJECTS) $(COMMON_OBJECTS) parallel.o mps.o whereami.o $(PAR_LIBS) $(BASIC_LIBS) libdummies.a $(LIBS) -o $@

# The worker manager
peclipse:	wm.o whereami.o wm_interface.o eclipsedir.o os_support.o
		$(CC) $(LDFLAGS) -L$(SYS_LIB) wm.o wm_interface.o whereami.o \
		    eclipsedir.o os_support.o $(PAR_LIBS) $(BASIC_LIBS) $(GRAPHLIBS) $(LIBS) -o $@


# *************** Embedding test programs ***************

eg_c_test:	$(EXT_INCLUDES) eg_c_test.o libeclipse.a libdummies.a
		$(CC) -o $@ eg_c_test.o \
			-L$(RUN_LIB) -L$(SYS_LIB) -L. \
			$(RUNPATH_LDFLAG)$(RUN_LIB) \
			-leclipse -ldummies $(BASIC_LIBS) $(LIBS)

eg_cc_test:	$(EXT_INCLUDES) eg_cc_test.o libeclipse.a libdummies.a
		$(CXX) -o $@ eg_cc_test.o \
			-L$(RUN_LIB) -L$(SYS_LIB) -L. \
			$(RUNPATH_LDFLAG)$(RUN_LIB) \
			-leclipse -ldummies $(BASIC_LIBS) $(LIBS)


# make lint is called in the src directory
# -I../sun4 is needed for config.h
lint:
		-$(LINT) $(LINTFLAGS) $(CPPFLAGS) -I../sun4 \
			$(SEPIA_SRC) $(MPS_SRC) dummy_par.c $(SHM_SRC) \
			$(LINT_SRC) -lm

tags:
		ctags -tw *.c *.h

distclean:	clean
		rm -f Makefile Makefile.external config.h INST_PARAMS
		rm -f tags

clean:		archclean

archclean:
		rm -f *.i *.o emu*.s *.a *.$(OBJECTS_SUFFIX)
		rm -f sepia$(EXE) eclipse.exe
		rm -f whereami.c eclipse_cc.h eclipse.def

ecoclean:	bootecoclean
		rm -rf $(ECO_LIB_DEST)

# delete STABLE_ECLIPSE's boot-files only if AUX_SEPIA works
bootecoclean:	boot_test
		rm -rf $(ECO_BOOT_DEST)

# *************** Libraries and Compound Objects ***************

objects:	$(COMMON_OBJECTS) $(DEVSYS_OBJECTS)

winecl.tgz:	$(COMMON_OBJECTS) $(DEVSYS_OBJECTS)
		gtar cvfz eclipse.tgz $(COMMON_OBJECTS) $(DEVSYS_OBJECTS)

libeclipse.a:	$(COMMON_OBJECTS)
		$(AR) rc ./libeclipse.a $(COMMON_OBJECTS)
		$(RANLIB) ./libeclipse.a

tkexdr.a: tkexdr.o
		$(AR) rc ./tkexdr.a tkexdr.o
		$(RANLIB) ./tkexdr.a

tkexdr.so:	tkexdr.o
		$(DYLD) $(DYNLDFLAGS) -L$(SYS_LIB) tkexdr.o \
			$(LIBS) -lc -o $@

tkexdr.dylib:	tkexdr.o
		$(DYLD) $(DYNLDFLAGS) -L$(SYS_LIB) tkexdr.o \
			$(LIBS) $(LDTCL) -o ./tkexdr.dylib

tkexdr.dll:	tkexdr.def tkexdr.o
		$(DYLD) $(DYNLDFLAGS) -o $@ \
			-Wl,--out-implib,tkexdr.dll.a \
			$< tkexdr.o \
			-L$(SYS_LIB) $(GRAPHLIBS) $(LIBS)


tkeclipse.a: tkeclipse.o
		$(AR) rc ./tkeclipse.a tkeclipse.o
		$(RANLIB) ./tkeclipse.a

# the -lc works around a linker problem on linux
tkeclipse.so: tkeclipse.o tkexdr.so $(LIB_PREFIX)eclipse.so
		$(DYLD) $(DYNLDFLAGS) \
			-L$(RUN_LIB) -L$(SYS_LIB) \
                        $(RUNPATH_DYLDFLAG)$(RELRUNPATH) \
			tkeclipse.o tkexdr.so $(LIB_PREFIX)eclipse.so \
                        $(LIBS) -lc -o $@

# $(GMP_LD)  $(LDTCL) needed for MacOSX
tkeclipse.dylib: tkeclipse.o tkexdr.dylib $(LIB_PREFIX)eclipse.dylib
		$(DYLD) $(DYNLDFLAGS) \
			-L$(RUN_LIB) -L$(SYS_LIB) \
                        $(RUNPATH_DYLDFLAG)$(RELRUNPATH) \
			tkeclipse.o tkexdr.dylib $(LIB_PREFIX)eclipse.dylib \
                        $(LIBS)  $(GMP_LD) $(LDTCL) -o $@

tkeclipse.dll: tkeclipse.def tkeclipse.o tkexdr.dll $(LIB_PREFIX)eclipse.dll
		$(DYLD) $(DYNLDFLAGS) -o $@ \
			-L$(RUN_LIB) -L$(SYS_LIB) \
			$< tkeclipse.o tkexdr.dll $(LIB_PREFIX)eclipse.dll \
			$(GRAPHLIBS) $(LIBS)

# With Gnu ld we should use
#	-Wl,--version-script=eclipse.sym
# to reduce the number of exported symbols, but we don't always
# use Gnu ld, and it breaks on Solaris even with Gnu ld
$(LIB_PREFIX)eclipse.so: $(COMMON_OBJECTS) $(DUMMYLIBS)
		$(DYLD) $(DYNLDFLAGS) -o $@ \
			$(COMMON_OBJECTS) $(DUMMYLIBS) \
			-L$(RUN_LIB) -L$(SYS_LIB) \
			$(RUNPATH_DYLDFLAG)$(RELRUNPATH) \
			$(BASIC_LIBS) $(LIBS)

$(LIB_PREFIX)eclipse.dylib: $(COMMON_OBJECTS) $(DUMMYLIBS)
		$(DYLD) $(DYNLDFLAGS) -o $@ \
			$(COMMON_OBJECTS) $(DUMMYLIBS) \
			-L$(RUN_LIB) -L$(SYS_LIB) \
			$(BASIC_LIBS) $(LIBS)

$(LIB_PREFIX)eclipse.dll: $(COMMON_OBJECTS) $(DUMMYLIBS)
		$(DYLD) $(DYNLDFLAGS) -o $@ \
			-Wl,--out-implib,$(LIB_PREFIX)eclipse.dll.a \
			-Wl,--output-def,$(LIB_PREFIX)eclipse.def \
			$(COMMON_OBJECTS) $(DUMMYLIBS) \
			-L$(RUN_LIB) -L$(SYS_LIB) \
			$(BASIC_LIBS) $(LIBS)

$(LIB_PREFIX)eclipse.dll.a: $(LIB_PREFIX)eclipse.dll


libdummies.a:	$(ALLDUMMYLIBS) 
		$(AR) rc ./libdummies.a $(ALLDUMMYLIBS)
		$(RANLIB) ./libdummies.a

sepia.o:	$(COMMON_OBJECTS)
		$(LD) -r $(COMMON_OBJECTS) -o $@


standalone.o:	$(DEVSYS_OBJECTS)
		$(LD) -r $(DEVSYS_OBJECTS) -o $@


parallel.o:	$(PAR_OBJECTS)
		$(LD) -r $(PAR_OBJECTS) -o $@

mps.o:		$(MPS_OBJECTS)
		$(LD) -r $(MPS_OBJECTS) -o $@


libeclipsemps.a:	mps.o
		$(AR) rc ./libeclipsemps.a mps.o
		$(RANLIB) ./libeclipsemps.a

whereami.c:
		@echo char \* whereami\(void\) > whereami.c
		@echo { return\(\"`cd ..;pwd|sed s-auto/--`\"\)\; } >> whereami.c


#
# Include file for C++ embedding
#

# cc/cxx -> i (uses suffix rule above)
eclipse_cc.i:	config.h ec_public.h types.h embed.h

# i -> h
eclipse_cc.h:		eclipse_cc.i
	/bin/cp eclipse_cc.i eclipse_cc.h


#
# Some files that need special compilation flags etc
#

bip_arith.o:	bip_arith.c
		$(CC) $(OPT_FLAGS_ARITH) $(CFLAGS) $(CPPFLAGS) -c $<

emu.o:		emu.c
		$(CC) $(OPT_FLAGS_EMU) $(CFLAGS) $(CPPFLAGS) -S $<
		/bin/mv -f emu.s emu.no.s
		-$(OPTIMIZE) ./emu.no.s ./emu.s
		@cmp -s ./emu.no.s ./emu.s || echo "Assembly code patched"
		$(CC) $(CFLAGS) -c emu.s

emu.obj:	emu.o
		/bin/cp emu.o emu.obj

# On some systems we need to specify extra compiler flags when playing with
# rounding modes.
intervals.o:	intervals.c
		$(CC) $(OPT_FLAGS) $(FLOAT_ROUND_FLAGS) $(CFLAGS) $(CPPFLAGS) \
		-c $<

wm.o:		wm.c
		$(CC) $(OPT_FLAGS) $(CFLAGS) $(CPPFLAGS) -c wm.c

wm_interface.o:	wm_interface.c
		$(CC) $(OPT_FLAGS) $(CFLAGS) $(CPPFLAGS) \
		-c wm_interface.c


#
# External files
#

$(EXT_OBJECTS):		$(EXT_INCLUDES)


#
# Rebuild configured files
#

config.h:	stamp-h
stamp-h:	config.h.in
	@( cd $(top_srcdir); \
	  if grep "hostname = `hostname`" config.log ; then \
	    ./config.status ; \
	  else \
	    echo === Please re-run configure on this host ; \
	  fi )

Makefile:	Makefile.in
	@( cd $(top_srcdir); \
	  if grep "hostname = `hostname`" config.log ; then \
	    ./config.status ; \
	  else \
	    echo === Please re-run configure on this host ; \
	  fi )


# -----------------------------------------------------------------------------
# ECLiPSe INSTALLATION
# -----------------------------------------------------------------------------

AUX_SEPIA = ./sepia$(EXE) -D $(SEPIA)

# install is configured as either install_all or install_cross
install:	install_all
install_all:	sepia$(EXE) install_common install_machine
install_cross:	install_machine


# Some machines don't support chmod -f
# PERM = -f a+r,u+w,go-w
PERM = a+r,u+w,go-w
DIRPERM = 2755

# -----------------------------------------------------------------------------
# Macros specifying the files to go in the binary release
#
# PL_LIBRARIES		they go to $(PREFIX)/lib in source form (.pl)
# ECL_ECO_LIBRARIES	they go to $(PREFIX)/lib in source & compiled form
# PL_ECO_LIBRARIES	they go to $(PREFIX)/lib in source & compiled form
#
# BOOT_EXEC		they go to $(PREFIX)/lib/$ARCH
# LIB_OBJECTS		they go to $(PREFIX)/lib/$ARCH
# SYSLIB_OBJECTS	they go there too
#
# EXT_INCLUDES		they go to $(PREFIX)/include/$(ARCH)
# EG_SOURCES		they go to $(PREFIX)/doc/examples in source form
# -----------------------------------------------------------------------------

#
# Files to go to $(PREFIX)/lib in source form only (.pl).
#

PL_LIBRARIES =	version.pl

#
# Files to go to $(PREFIX)/lib in both source (.ecl,.pl) and compiled form
# (.eco).
#

ECL_ECO_LIBRARIES =	constraint_pools.ecl document.ecl fcompile.ecl \
		format.ecl lazy_io.ecl csv.ecl \
		multifile.ecl notify_ports.ecl port_profiler.ecl \
		swi.ecl time_log.ecl timeout.ecl timeout_simple.ecl var_name.ecl \
		iso.ecl iso_light.ecl iso_error.ecl iso_strict.ecl iso_aux.ecl \
		lists_of_structures.ecl

PL_ECO_LIBRARIES =	anti_unify.pl apply.pl \
		apply_macros.pl atts.pl branch_and_bound.pl \
		calendar.pl cgi.pl cio.pl cprolog.pl \
		development_support.pl fd.pl \
		fd_arith.pl fd_chip.pl fd_domain.pl fd_elipsys.pl \
		fd_util.pl foreign.pl fromonto.pl heaps.pl \
		http.pl http_client.pl http_grammar.pl http_method.pl \
		http_server.pl linearize.pl lips.pl lists.pl \
		matrix_util.pl \
		modes.pl notinstance.pl numbervars.pl oldio.pl ordset.pl \
		paddy.pl par_util.pl pretty_print.pl profile.pl queues.pl \
		quintus.pl quintus_util.pl rationals.pl remote_tools.pl \
		sepia.pl sicstus.pl sockets.pl \
		source_storage.pl spell.pl structures.pl \
		systools.pl t_all.pl test_util.pl toplevel.pl \
		tracer_tcl.pl tracer_tty.pl util.pl

BOOT_ECL_ECO_LIBRARIES = \
		hash.ecl \
		module_options.ecl \
		eclipse_language.ecl

BOOT_PL_ECO_LIBRARIES = \
		asm.pl \
		suspend.pl

BOOT_ECO_MODULES = \
		kernel \
		$(BOOT_PL_ECO_LIBRARIES:%.pl=%) \
		$(BOOT_ECL_ECO_LIBRARIES:%.ecl=%)


# Files from which .eci files will be produced (.ecl,.pl)

ECI_ECL_LIBRARIES =	hash.ecl document.ecl format.ecl lazy_io.ecl csv.ecl \
		var_name.ecl time_log.ecl module_options.ecl \
		notify_ports.ecl constraint_pools.ecl port_profiler.ecl \
		swi.ecl timeout.ecl timeout_simple.ecl fcompile.ecl multifile.ecl \
		iso.ecl iso_light.ecl iso_strict.ecl lists_of_structures.ecl


ECI_PL_LIBRARIES =	anti_unify.pl apply.pl apply_macros.pl \
		asm.pl atts.pl branch_and_bound.pl cgi.pl \
		calendar.pl cio.pl cprolog.pl \
		foreign.pl fromonto.pl heaps.pl \
		http.pl http_server.pl http_client.pl \
		linearize.pl lips.pl lists.pl \
		matrix_util.pl notinstance.pl numbervars.pl \
		ordset.pl par_util.pl \
		pretty_print.pl profile.pl queues.pl quintus.pl \
		quintus_util.pl remote_tools.pl sepia.pl \
		sicstus.pl sockets.pl spell.pl \
		suspend.pl util.pl \
		test_util.pl toplevel.pl \
		fd.pl


TCL_LIBRARIES =	menu.tcl

KERNEL_PARTS =	kernel.pl events.pl meta.pl array.pl pdb.pl debug.pl \
		dynamic.pl environment.pl io.pl setof.pl tconv.pl \
		kernel_bips.pl tracer.pl

COMPILER_MODULES = \
		ecl_compiler \
		compiler_analysis \
		compiler_codegen \
		compiler_common \
		compiler_indexing \
		compiler_normalise \
		compiler_peephole \
		compiler_regassign \
		compiler_varclass \
		compiler_map \
		source_processor


BOOT_EXEC =	INST_PARAMS Makefile.external eclipse.exe

# Library-related files only needed on certain architectures
ifeq ($(BUILD_WITH_TCL),yes)
LIB_OBJECTS_TCL_NT = tkexdr.dll.a tkexdr.def
LIB_OBJECTS_TCL =  tkeclipse.$(OBJECTS_SUFFIX) tkexdr.$(OBJECTS_SUFFIX)
else
LIB_OBJECTS_TCL_NT =
LIB_OBJECTS_TCL = 
endif

LIB_OBJECTS_i386_nt = $(LIB_PREFIX)eclipse.dll.a $(LIB_PREFIX)eclipse.def \
		$(LIB_OBJECTS_TCL_NT)

LIB_OBJECTS_x86_64_nt = $(LIB_PREFIX)eclipse.dll.a $(LIB_PREFIX)eclipse.def \
		$(LIB_OBJECTS_TCL_NT)

LIB_OBJECTS_ARCH = $(LIB_OBJECTS_$(ARCH))

LIB_OBJECTS =	$(LIB_PREFIX)eclipse.$(OBJECTS_SUFFIX) \
		$(LIB_OBJECTS_TCL) \
		$(LIB_OBJECTS_ARCH)

# add these to LIB_OBJECTS if you want to have the parallel stuff:
PARLIB_OBJECTS = parallel.o wm.o wm_interface.o libeclipsemps.a \
		libpds.a nsrv_ping.o nsrv_server.o


EG_SOURCES =	eg_c_main.c eg_cc_main.cc \
		eg_c_fail_loop.c eg_cc_fail_loop.cc \
		eg_c_sendmore.c eg_cc_sendmore.cc \
		eg_c_handle.c eg_cc_handle.cc \
		eg_c_mip.c eg_cc_mip.cc \
		eg_c_basic.c eg_cc_basic.cc \
		eg_c_test.c eg_cc_test.cc \
		eg_c_external.c eg_cc_external.cc


# -----------------------------------------------------------------------------
# The destination filenames, derived from the above
# -----------------------------------------------------------------------------

PL_DEST =	$(PL_LIBRARIES:%.pl=$(PREFIX)/lib/%.pl) \
		$(PL_ECO_LIBRARIES:%.pl=$(PREFIX)/lib/%.pl) \
		$(BOOT_PL_ECO_LIBRARIES:%.pl=$(PREFIX)/lib/%.pl)
ECI_DEST =	$(ECI_PL_LIBRARIES:%.pl=$(PREFIX)/lib/%.eci) \
		$(ECI_ECL_LIBRARIES:%.ecl=$(PREFIX)/lib/%.eci)
ECL_DEST =	$(ECL_ECO_LIBRARIES:%.ecl=$(PREFIX)/lib/%.ecl) \
		$(BOOT_ECL_ECO_LIBRARIES:%.ecl=$(PREFIX)/lib/%.ecl)
TCL_DEST =	$(TCL_LIBRARIES:%.tcl=$(PREFIX)/lib/%.tcl)
ECO_LIB_DEST =	$(ECL_ECO_LIBRARIES:%.ecl=$(PREFIX)/lib/%.eco) \
		$(PL_ECO_LIBRARIES:%.pl=$(PREFIX)/lib/%.eco)
ECO_BOOT_DEST = $(BOOT_ECO_MODULES:%=$(PREFIX)/lib/%.eco) \
		$(COMPILER_MODULES:%=$(PREFIX)/lib/%.eco)
SYSLIB_DEST =	$(SYSLIB_OBJECTS:%=$(PREFIX)/lib/$(ARCH)/%)
BOOT_EXE_DEST =	$(BOOT_EXEC:%=$(PREFIX)/lib/$(ARCH)/%)
LIB_OBJ_DEST =	$(LIB_OBJECTS:%=$(PREFIX)/lib/$(ARCH)/%)
EG_SOURCES_DEST = $(EG_SOURCES:%=$(PREFIX)/doc/examples/%)
EXT_INC_DEST =	$(EXT_INCLUDES:%=$(PREFIX)/include/$(ARCH)/%)

# These files are in the repository, so the system can be bootstrapped:
BOOT_ECOS =	$(BOOT_ECO_MODULES:%=$(SEPIA)/lib/%.eco)
COMPILER_ECOS:	$(COMPILER_MODULES:%=$(SEPIA)/lib/%.eco)


# -----------------------------------------------------------------------------
# how to install the machine independent files
# -----------------------------------------------------------------------------

install_common:	$(C_DEST) $(ECL_DEST) $(ECI_DEST) $(PL_DEST) \
		$(ECO_LIB_DEST) $(ECO_BOOT_DEST) \
		$(TCL_DEST) $(EG_SOURCES_DEST)

$(PREFIX)/lib/%.c:	$(SEPIA)/src/%.c $(PREFIX)/lib/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/%.pl:	$(SEPIA)/lib/%.pl $(PREFIX)/lib/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/%.ecl:	$(SEPIA)/lib/%.ecl $(PREFIX)/lib/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/%.tcl:	$(SEPIA)/lib/%.tcl $(PREFIX)/lib/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

# copy the version file, replacing the date with the current one
$(PREFIX)/lib/version.pl:	$(SEPIA)/lib/version.pl $(PREFIX)/lib/.stamp
	$(AUX_SEPIA) -e "date(D), substring(D, 1, 16, D1),\
		substring(D, 20, 5, D2), concat_strings(D1, D2, DD),\
		compile(library(version)),\
		sepia_stage(Stage), sepia_build(Build),\
		open(\"$@\", write, V), writeq(V, sepia_date(DD)),\
		writeln(V, .), writeq(V, sepia_stage(Stage)),\
		writeln(V, .), writeq(V, sepia_build(Build)),\
		writeln(V, .), close(V)"
	@/bin/chmod $(PERM) $@


# These boot-files are in the repository in .eco format and are only copied.
# If you want to re-make them, use make bootfiles
$(PREFIX)/lib/kernel.eco:		$(SEPIA)/lib/kernel.eco
$(PREFIX)/lib/suspend.eco:		$(SEPIA)/lib/suspend.eco
$(PREFIX)/lib/eclipse_language.eco:	$(SEPIA)/lib/eclipse_language.eco
$(PREFIX)/lib/asm.eco:			$(SEPIA)/lib/asm.eco
$(PREFIX)/lib/hash.eco:			$(SEPIA)/lib/hash.eco
$(PREFIX)/lib/module_options.eco:	$(SEPIA)/lib/module_options.eco

$(PREFIX)/lib/%.eco:	$(SEPIA)/lib/%.eco boot_test $(PREFIX)/lib/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@


# This goal tries to make sure that the core system actually boots and that
# the compiler works (by compiling util.pl).  Could be more thorough!
boot_test:	sepia$(EXE) $(BOOT_ECOS) $(COMPILER_ECOS)
	$(AUX_SEPIA) -e 'compile("$(SEPIA)/lib/util"),util:compiled'
	touch $@


$(PREFIX)/lib/%.eco:	$(SEPIA)/lib/%.ecl $(PREFIX)/lib/.stamp
	$(AUX_SEPIA) -e "compile(\"$<\",\
		[debug:$(ECO_DBG),srcroot:\"$(top_srcdir)\",outdir:\"$(@D)\",output:eco])"
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/%.eco:	$(SEPIA)/lib/%.pl $(PREFIX)/lib/.stamp
	$(AUX_SEPIA) -e "compile(\"$<\",\
		[debug:$(ECO_DBG),srcroot:\"$(top_srcdir)\",outdir:\"$(@D)\",output:eco])"
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/%.eci:	$(SEPIA)/lib/%.ecl $(PREFIX)/lib/.stamp
	$(AUX_SEPIA) -e 'lib(document),icompile("$<","$(@D)")'
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/%.eci:	$(SEPIA)/lib/%.pl $(PREFIX)/lib/.stamp
	$(AUX_SEPIA) -e 'lib(document),icompile("$<","$(@D)")'
	@/bin/chmod $(PERM) $@

$(PREFIX)/doc/examples/%.c: %.c $(PREFIX)/doc/examples/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/doc/examples/%.cc: %.cc $(PREFIX)/doc/examples/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/include/$(ARCH)/%.h:	%.h $(PREFIX)/include/$(ARCH)/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@


# -----------------------------------------------------------------------------
# Re-create .eco files that are needed for booting
# This only needs to be done when the source for these files was changed.
# The resulting .eco files should must be checked into the repository along
# with the modified sources. The compiler files also belong into this group,
# but are created via the Compiler/Makefile
# -----------------------------------------------------------------------------

STABLE_ECLIPSE = $(PREFIX)/bin/$(ARCH)/eclipse

# force re-making all the bootfiles
new_bootfiles:
	rm -f $(BOOT_ECOS)
	$(MAKE) $(BOOT_ECOS)

bootfiles:	$(BOOT_ECOS)

$(SEPIA)/lib/kernel.eco:	$(KERNEL_PARTS:%=$(SEPIA)/lib/%)
	@if test -x $(STABLE_ECLIPSE) ; then \
	    echo "Rebuilding bootfile $@ [debug:$(ECO_DBG)]"; \
	    $(STABLE_ECLIPSE) -D $(PREFIX) -e 'unlock(sepia_kernel,"Sepia"),compile("$(SEPIA)/lib/kernel.pl",[debug:$(ECO_DBG),srcroot:"$(top_srcdir)",outdir:"$(@D)",load:none,output:eco])'; \
	else \
	    touch $@; echo "WARNING: $@ out-of-date, but cannot rebuild without stable eclipse"; \
	fi 
	@/bin/chmod $(PERM) $@

$(SEPIA)/lib/%.eco:	$(SEPIA)/lib/%.ecl
	@if test -x $(STABLE_ECLIPSE) ; then \
	    echo "Rebuilding bootfile $@ [debug:$(ECO_DBG)]"; \
	    $(STABLE_ECLIPSE) -D $(PREFIX) -e 'compile("$<", [debug:$(ECO_DBG),srcroot:"$(top_srcdir)",outdir:"$(@D)",output:eco,load:none])'; \
	else \
	    touch $@; echo "WARNING: $@ out-of-date, but cannot rebuild without stable eclipse"; \
	fi 
	@/bin/chmod $(PERM) $@

$(SEPIA)/lib/%.eco:	$(SEPIA)/lib/%.pl
	@if test -x $(STABLE_ECLIPSE) ; then \
	    echo "Rebuilding bootfile $@ [debug:$(ECO_DBG)]"; \
	    $(STABLE_ECLIPSE) -D $(PREFIX) -e 'compile("$<", [debug:$(ECO_DBG),srcroot:"$(top_srcdir)",outdir:"$(@D)",output:eco,load:none])'; \
	else \
	    touch $@; echo "WARNING: $@ out-of-date, but cannot rebuild without stable eclipse"; \
	fi 
	@/bin/chmod $(PERM) $@


# -----------------------------------------------------------------------------
# how to install the machine dependent stuff
# -----------------------------------------------------------------------------

install_machine:  $(BOOT_EXE_DEST) $(LIB_OBJ_DEST) $(EXT_INC_DEST)


# the .dll.a file is created as a side effect of making the .dll
$(PREFIX)/lib/i386_nt/%.dll.a:	%.dll $(PREFIX)/lib/i386_nt/.stamp
	/bin/cp $(@F) $@
	@/bin/chmod $(PERM) $@

# the .def file is created as a side effect of making the .dll
$(PREFIX)/lib/i386_nt/eclipse.def:	eclipse.dll $(PREFIX)/lib/i386_nt/.stamp
	/bin/cp $(@F) $@
	@/bin/chmod $(PERM) $@

# this also copies from ../src/%.def because of VPATH
$(PREFIX)/lib/i386_nt/%.def:	%.def $(PREFIX)/lib/i386_nt/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

# this also copies from ../src/%.reg because of VPATH
$(PREFIX)/lib/i386_nt/%.reg:	%.reg $(PREFIX)/lib/i386_nt/.stamp
	/bin/cp $(@F) $@
	@/bin/chmod $(PERM) $@

# the .dll.a file is created as a side effect of making the .dll
$(PREFIX)/lib/x86_64_nt/%.dll.a:	%.dll $(PREFIX)/lib/x86_64_nt/.stamp
	/bin/cp $(@F) $@
	@/bin/chmod $(PERM) $@

# the .def file is created as a side effect of making the .dll
$(PREFIX)/lib/x86_64_nt/eclipse.def:	eclipse.dll $(PREFIX)/lib/x86_64_nt/.stamp
	/bin/cp $(@F) $@
	@/bin/chmod $(PERM) $@

# this also copies from ../src/%.def because of VPATH
$(PREFIX)/lib/x86_64_nt/%.def:	%.def $(PREFIX)/lib/x86_64_nt/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

# this also copies from ../src/%.reg because of VPATH
$(PREFIX)/lib/x86_64_nt/%.reg:	%.reg $(PREFIX)/lib/x86_64_nt/.stamp
	/bin/cp $(@F) $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/$(ARCH)/INST_PARAMS:	INST_PARAMS $(PREFIX)/lib/$(ARCH)/.stamp
	-/bin/cp $< $@
	-@/bin/chmod $(PERM) $@

$(PREFIX)/lib/$(ARCH)/Makefile.external:	Makefile.external $(PREFIX)/lib/$(ARCH)/.stamp
	-/bin/cp $< $@
	-@/bin/chmod $(PERM) $@

$(PREFIX)/lib/$(ARCH)/%.o:	%.o $(PREFIX)/lib/$(ARCH)/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/$(ARCH)/%.$(OBJECTS_SUFFIX): %.$(OBJECTS_SUFFIX) $(PREFIX)/lib/$(ARCH)/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/$(ARCH)/%.exe:	%.exe $(PREFIX)/lib/$(ARCH)/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/$(ARCH)/%.$(OBJECTS_SUFFIX):	$(SYS_LIB)/%.$(OBJECTS_SUFFIX) $(PREFIX)/lib/$(ARCH)/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/$(ARCH)/%.a:	%.a $(PREFIX)/lib/$(ARCH)/.stamp
	/bin/cp $< $@
	@$(RANLIB) $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/$(ARCH)/%.a:	$(SYS_LIB)/%.a $(PREFIX)/lib/$(ARCH)/.stamp
	/bin/cp $< $@
	@$(RANLIB) $@
	@/bin/chmod $(PERM) $@

$(PREFIX)/lib/$(ARCH)/%.o:	$(SYS_LIB)/%.o $(PREFIX)/lib/$(ARCH)/.stamp
	/bin/cp $< $@
	@/bin/chmod $(PERM) $@


install_gmp:	$(PREFIX)/lib/$(ARCH)/$(LIB_PREFIX)$(GMP_LIB).$(OBJECTS_SUFFIX)

$(PREFIX)/lib/$(ARCH)/$(LIB_PREFIX)$(GMP_LIB).$(OBJECTS_SUFFIX):	$(GMP_LIBDIR)/$(LIB_PREFIX)$(GMP_LIB).$(OBJECTS_SUFFIX) $(PREFIX)/lib/$(ARCH)/.stamp
	# copy using tar to keep symbolic link structure
	(cd $(GMP_LIBDIR); tar cf - $(LIB_PREFIX)$(GMP_LIB)*) | (cd $(PREFIX)/lib/$(ARCH); tar xfBp -)
	@/bin/chmod $(PERM) $@
	touch $@


# -----------------------------------------------------------------------------
# make the installation directories
# (we use timestamp files to remember when the directory was created)
# -----------------------------------------------------------------------------

%/.stamp:
	mkdir -p $(@D)
	@/bin/chmod $(DIRPERM) $(@D)
	@touch $@; /bin/chmod $(PERM) $@


# -----------------------------------------------------------------------------
# Pretty-print the sources
# This only works after make install and RUNME
# -----------------------------------------------------------------------------

PRETTY_DIR =	$(PREFIX)/doc_internal/lib

HTML_DEST =	$(PL_LIBRARIES:%.pl=$(PRETTY_DIR)/%.html) \
		$(PL_ECO_LIBRARIES:%.pl=$(PRETTY_DIR)/%.html) \
		$(ECL_ECO_LIBRARIES:%.ecl=$(PRETTY_DIR)/%.html)

pretty:		$(PRETTY_DIR)/.stamp $(HTML_DEST)


$(PRETTY_DIR)/%.html:	$(SEPIA)/lib/%.pl $(PRETTY_DIR)/.stamp
	-@$(PREFIX)/bin/$(ARCH)/eclipse -e \
	    "lib(pretty_printer),argv(all,[_,O|F]),pretty_print(F,[outdir:O])" \
	    -- "$(PRETTY_DIR)" $<

$(PRETTY_DIR)/%.html:	$(SEPIA)/lib/%.ecl $(PRETTY_DIR)/.stamp
	-@$(PREFIX)/bin/$(ARCH)/eclipse -e \
	    "lib(pretty_printer),argv(all,[_,O|F]),pretty_print(F,[outdir:O])" \
	    -- "$(PRETTY_DIR)" $<


# -----------------------------------------------------------------------------
# Automatically generated dependencies
# makedepend -Y -fMakefile.in *.c
# -----------------------------------------------------------------------------

# DO NOT DELETE

Test_script.o: config.h
addrmap.o: config.h
bigrat.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
bigrat.o: emu_export.h
bip_arith.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h
bip_arith.o: dict.h emu_export.h rounding_control.h
bip_array.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h
bip_array.o: dict.h emu_export.h property.h module.h
bip_bag.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h dict.h
bip_comp.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h dict.h
bip_comp.o: opcode.h emu_export.h
bip_control.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h
bip_control.o: ec_io.h dict.h emu_export.h debug.h module.h property.h
bip_control.o: os_support.h
bip_db.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h ec_io.h
bip_db.o: opcode.h gencode.h dict.h database.h emu_export.h
bip_db.o: module.h debug.h property.h
bip_delay.o: config.h sepia.h ec_public.h types.h embed.h mem.h debug.h
bip_delay.o: error.h dict.h emu_export.h property.h
bip_domain.o: config.h sepia.h ec_public.h types.h embed.h mem.h dict.h
bip_domain.o: error.h emu_export.h fd.h
bip_heapevents.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h dict.h
bip_io.o: config.h os_support.h sepia.h ec_public.h types.h embed.h mem.h
bip_io.o: error.h ec_io.h dict.h lex.h emu_export.h property.h
bip_load.o: config.h sepia.h ec_public.h types.h embed.h mem.h dict.h
bip_load.o: emu_export.h error.h opcode.h ec_io.h property.h module.h
bip_load.o: os_support.h
bip_misc.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
bip_misc.o: emu_export.h os_support.h
bip_module.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h ec_io.h
bip_module.o: dict.h database.h emu_export.h debug.h gencode.h module.h
bip_module.o: opcode.h property.h
bip_mps.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h dict.h
bip_parallel.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h
bip_parallel.o: ec_io.h dict.h emu_export.h property.h module.h opcode.h
bip_record.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h
bip_record.o: dict.h property.h module.h
bip_serialize.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
bip_serialize.o: ec_io.h emu_export.h module.h
bip_shelf.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h
bip_shelf.o: dict.h property.h
bip_store.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h
bip_store.o: dict.h property.h
bip_strings.o: config.h sepia.h ec_public.h types.h embed.h mem.h dict.h
bip_strings.o: emu_export.h error.h sha.c
bip_tconv.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h
bip_tconv.o: dict.h emu_export.h ec_io.h lex.h property.h module.h
code.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h dict.h
code.o: emu_export.h opcode.h gencode.h debug.h module.h database.h
dict.o: config.h os_support.h sepia.h ec_public.h types.h embed.h error.h
dict.o: mem.h ec_io.h dict.h emu_export.h
dummy_bigrat.o: config.h sepia.h ec_public.h types.h error.h
dummy_par.o: config.h ec_public.h error.h
eclipsedir.o: config.h os_support.h
eg_c_basic.o: eclipse.h config.h ec_public.h types.h embed.h
eg_c_external.o: eclipse.h config.h ec_public.h types.h embed.h
eg_c_fail_loop.o: eclipse.h config.h ec_public.h types.h embed.h
eg_c_handle.o: eclipse.h config.h ec_public.h types.h embed.h
eg_c_main.o: eclipse.h config.h ec_public.h types.h embed.h
eg_c_mip.o: eclipse.h config.h ec_public.h types.h embed.h
eg_c_sendmore.o: eclipse.h config.h ec_public.h types.h embed.h
eg_c_test.o: eclipse.h config.h ec_public.h types.h embed.h
elipsys_fd.o: config.h sepia.h ec_public.h types.h embed.h mem.h dict.h fd.h
elipsys_fd.o: error.h
embed.o: config.h sepia.h ec_public.h types.h error.h mem.h dict.h module.h
embed.o: emu_export.h embed.h os_support.h
emu.o: config.h sepia.h ec_public.h types.h error.h mem.h dict.h emu_export.h
emu.o: embed.h opcode.h database.h module.h debug.h property.h ec_io.h
emu_c_env.o: config.h sepia.h ec_public.h types.h error.h embed.h mem.h ec_io.h
emu_c_env.o: dict.h emu_export.h module.h debug.h opcode.h
emu_par.o: config.h sepia.h ec_public.h types.h embed.h error.h ec_io.h mem.h
emu_par.o: dict.h emu_export.h opcode.h wm.h sch_eng_interface.h trace.h
emu_util.o: config.h sepia.h ec_public.h types.h debug.h embed.h error.h
emu_util.o: mem.h opcode.h dict.h module.h emu_export.h ec_io.h
error.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
error.o: emu_export.h ec_io.h os_support.h
example.o: external.h config.h sepia.h ec_public.h types.h error.h embed.h
external.o: config.h sepia.h ec_public.h types.h embed.h mem.h dict.h error.h
external.o: emu_export.h
gc_stacks.o: config.h os_support.h sepia.h ec_public.h types.h embed.h
gc_stacks.o: error.h mem.h dict.h ec_io.h opcode.h emu_export.h
handle.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h ec_io.h
handle.o: dict.h database.h emu_export.h
handlers.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h dict.h
handlers.o: emu_export.h ec_io.h module.h property.h os_support.h
init.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
init.o: module.h os_support.h ec_io.h
intervals.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h
intervals.o: dict.h emu_export.h opcode.h intervals.h rounding_control.h
io.o: config.h os_support.h sepia.h ec_public.h types.h embed.h mem.h error.h
io.o: dict.h lex.h ec_io.h emu_export.h property.h module.h
lex.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h dict.h
lex.o: lex.h ec_io.h emu_export.h module.h property.h os_support.h
lex.o: rounding_control.h
main.o: config.h os_support.h sepia.h ec_public.h types.h embed.h error.h
main.o: mem.h dict.h emu_export.h module.h property.h
manual_examples.o: external.h config.h sepia.h ec_public.h types.h error.h
manual_examples.o: embed.h
mem.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h ec_io.h
mem.o: emu_export.h os_support.h
operator.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
operator.o: emu_export.h property.h module.h lex.h
os_support.o: config.h os_support.h
printam.o: config.h names.h sepia.h ec_public.h types.h embed.h error.h mem.h
printam.o: opcode.h ec_io.h dict.h emu_export.h database.h gencode.h
printam.o: module.h debug.h
proc_desc.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h
proc_desc.o: opcode.h dict.h emu_export.h database.h module.h
proc_desc.o: property.h gencode.h
procedure.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h
procedure.o: dict.h emu_export.h property.h opcode.h gencode.h
procedure.o: ec_io.h database.h module.h read.h os_support.h
property.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
property.o: module.h property.h
read.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
read.o: lex.h emu_export.h ec_io.h read.h module.h property.h
sch_util.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
sch_util.o: sch_types.h sch_macros.h
scheduler.o: config.h trace.h error.h sch_types.h sch_eng_interface.h
scheduler.o: sch_macros.h
st2.o: config.h
term_copy.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
term_copy.o: emu_export.h
test.o: sepia.h ec_public.h types.h
tkeclipse.o: eclipse.h config.h ec_public.h types.h embed.h tkcommon.h
tkexdr.o: config.h tkcommon.h
trace.o: config.h os_support.h sepia.h ec_public.h types.h embed.h error.h
trace.o: mem.h dict.h trace.h wm_msgs.h wm.h
types_external.o: config.h sepia.h ec_public.h types.h
upcalls.o: config.h
wm.o: config.h sch_types.h trace.h wm_msgs.h wm_types.h
wm_interface.o: config.h sch_types.h trace.h wm_msgs.h wm_types.h
worker.o: config.h sepia.h ec_public.h types.h embed.h error.h mem.h dict.h
worker.o: trace.h wm_msgs.h wm.h sch_types.h sch_eng_interface.h
write.o: config.h sepia.h ec_public.h types.h embed.h mem.h error.h dict.h
write.o: lex.h ec_io.h emu_export.h module.h property.h
