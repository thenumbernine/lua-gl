#!/usr/bin/env luajit
return require'gl.app'():run()
--[[
ubuntu 20.04
valgrind luajit-openresty-2.1.0-beta3-debug
...finds leaks from the previous line:

==$PID== Memcheck, a memory error detector
==$PID== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==$PID== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
==$PID== Command: luajit minimal.lua
==$PID==
==$PID==
==$PID== HEAP SUMMARY:
==$PID==     in use at exit: 393,775 bytes in 3,429 blocks
==$PID==   total heap usage: 53,683 allocs, 50,254 frees, 12,350,614 bytes allocated
==$PID==
==$PID== LEAK SUMMARY:
==$PID==    definitely lost: 6,257 bytes in 4 blocks
==$PID==    indirectly lost: 0 bytes in 0 blocks
==$PID==      possibly lost: 1,792 bytes in 4 blocks
==$PID==    still reachable: 385,726 bytes in 3,421 blocks
==$PID==         suppressed: 0 bytes in 0 blocks
==$PID== Rerun with --leak-check=full to see details of leaked memory
==$PID==
==$PID== For lists of detected and suppressed errors, rerun with: -s
==$PID== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 2 from 2)

--]]
