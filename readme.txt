
CTC example
-----------

This directory contains following files

   readme.txt      -- This file
   makefile        -- Makefile
   fulldemo.bat    -- Demo-script

		      \
   calc.c          --  \
   calc.h	   --   \
   io.c            --   / Program source files
   io.h		   --  /
   prime.c         -- /

This example demonstrates testing of a (very) simple program with CTC++.

Following targets are defined for the MAKEFILE (use the compiler's
make utility, here Microsoft C/C++ "nmake" is used as an example):

   nmake all      Build the example (default target), prime.exe
   nmake clean    Remove files produces with this makefile

To see a demo of the CTC++-usage with prime.exe-program run the script
fulldemo.bat.
