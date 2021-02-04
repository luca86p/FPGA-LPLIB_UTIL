-- =============================================================================
-- Whatis        : package of system data constants
-- Project       : FPGA-LPLIB_UTIL
-- -----------------------------------------------------------------------------
-- File          : pkg_const.vhd
-- Language      : VHDL-93
-- Module        : pkg_const
-- Library       : lplib_util
-- -----------------------------------------------------------------------------
-- Author(s)     : Luca Pilato <pilato[punto]lu[chiocciola]gmail[punto]com>
--                 
-- Company       : 
-- Addr          : 
-- -----------------------------------------------------------------------------
-- Description
-- 
-- -----------------------------------------------------------------------------
-- Dependencies
-- 
--  use lplib_util.pkg_type.all;
-- 
-- -----------------------------------------------------------------------------
-- Issues
-- 
-- -----------------------------------------------------------------------------
-- Copyright (c) 2021 Luca Pilato
-- MIT License
-- -----------------------------------------------------------------------------
-- date        who               changes
-- 2018-09-01  Luca Pilato       file creation
-- =============================================================================

-- IEEE lib
-- ----------------------------------------
library ieee;
use ieee.std_logiC_1164.ALL;
use ieee.numeriC_STD.ALL;
use ieee.math_real.all;

-- User lib
-- ----------------------------------------
library lplib_util;
use lplib_util.pkg_type.all;


package pkg_const is

    constant C_NIBBLE_ZERO  : nibble_t  := (others=>'0');
    constant C_BYTE_ZERO    : byte_t    := (others=>'0');
    constant C_HWORD_ZERO   : hword_t   := (others=>'0');
    constant C_WORD_ZERO    : word_t    := (others=>'0');
    constant C_DWORD_ZERO   : dword_t   := (others=>'0');
    constant C_QWORD_ZERO   : qword_t   := (others=>'0');
    constant C_OWORD_ZERO   : oword_t   := (others=>'0');
    constant C_XWORD_ZERO   : xword_t   := (others=>'0');
    --
    constant C_NIBBLE_ONE   : nibble_t  := (others=>'1');
    constant C_BYTE_ONE     : byte_t    := (others=>'1');
    constant C_HWORD_ONE    : hword_t   := (others=>'1');
    constant C_WORD_ONE     : word_t    := (others=>'1');
    constant C_DWORD_ONE    : dword_t   := (others=>'1');
    constant C_QWORD_ONE    : qword_t   := (others=>'1');
    constant C_OWORD_ONE    : oword_t   := (others=>'1');
    constant C_XWORD_ONE    : xword_t   := (others=>'1');

    constant C_ZERO2    : data2_t   := (others=>'0');
    constant C_ZERO3    : data3_t   := (others=>'0');
    constant C_ZERO4    : data4_t   := (others=>'0');
    constant C_ZERO5    : data5_t   := (others=>'0');
    constant C_ZERO6    : data6_t   := (others=>'0');
    constant C_ZERO7    : data7_t   := (others=>'0');
    constant C_ZERO8    : data8_t   := (others=>'0');
    constant C_ZERO9    : data9_t   := (others=>'0');
    constant C_ZERO10   : data10_t  := (others=>'0');
    constant C_ZERO11   : data11_t  := (others=>'0');
    constant C_ZERO12   : data12_t  := (others=>'0');
    constant C_ZERO13   : data13_t  := (others=>'0');
    constant C_ZERO14   : data14_t  := (others=>'0');
    constant C_ZERO15   : data15_t  := (others=>'0');
    constant C_ZERO16   : data16_t  := (others=>'0');
    constant C_ZERO17   : data17_t  := (others=>'0');
    constant C_ZERO18   : data18_t  := (others=>'0');
    constant C_ZERO19   : data19_t  := (others=>'0');
    constant C_ZERO20   : data20_t  := (others=>'0');
    constant C_ZERO21   : data21_t  := (others=>'0');
    constant C_ZERO22   : data22_t  := (others=>'0');
    constant C_ZERO23   : data23_t  := (others=>'0');
    constant C_ZERO24   : data24_t  := (others=>'0');
    constant C_ZERO25   : data25_t  := (others=>'0');
    constant C_ZERO26   : data26_t  := (others=>'0');
    constant C_ZERO27   : data27_t  := (others=>'0');
    constant C_ZERO28   : data28_t  := (others=>'0');
    constant C_ZERO29   : data29_t  := (others=>'0');
    constant C_ZERO30   : data30_t  := (others=>'0');
    constant C_ZERO31   : data31_t  := (others=>'0');
    constant C_ZERO32   : data32_t  := (others=>'0');
    --
    constant C_ONE2     : data2_t   := (others=>'1');
    constant C_ONE3     : data3_t   := (others=>'1');
    constant C_ONE4     : data4_t   := (others=>'1');
    constant C_ONE5     : data5_t   := (others=>'1');
    constant C_ONE6     : data6_t   := (others=>'1');
    constant C_ONE7     : data7_t   := (others=>'1');
    constant C_ONE8     : data8_t   := (others=>'1');
    constant C_ONE9     : data9_t   := (others=>'1');
    constant C_ONE10    : data10_t  := (others=>'1');
    constant C_ONE11    : data11_t  := (others=>'1');
    constant C_ONE12    : data12_t  := (others=>'1');
    constant C_ONE13    : data13_t  := (others=>'1');
    constant C_ONE14    : data14_t  := (others=>'1');
    constant C_ONE15    : data15_t  := (others=>'1');
    constant C_ONE16    : data16_t  := (others=>'1');
    constant C_ONE17    : data17_t  := (others=>'1');
    constant C_ONE18    : data18_t  := (others=>'1');
    constant C_ONE19    : data19_t  := (others=>'1');
    constant C_ONE20    : data20_t  := (others=>'1');
    constant C_ONE21    : data21_t  := (others=>'1');
    constant C_ONE22    : data22_t  := (others=>'1');
    constant C_ONE23    : data23_t  := (others=>'1');
    constant C_ONE24    : data24_t  := (others=>'1');
    constant C_ONE25    : data25_t  := (others=>'1');
    constant C_ONE26    : data26_t  := (others=>'1');
    constant C_ONE27    : data27_t  := (others=>'1');
    constant C_ONE28    : data28_t  := (others=>'1');
    constant C_ONE29    : data29_t  := (others=>'1');
    constant C_ONE30    : data30_t  := (others=>'1');
    constant C_ONE31    : data31_t  := (others=>'1');
    constant C_ONE32    : data32_t  := (others=>'1');



end package pkg_const;