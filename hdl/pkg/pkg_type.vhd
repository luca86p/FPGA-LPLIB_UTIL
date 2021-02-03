-- =============================================================================
-- Whatis        : package of system data type
-- Project       : FPGA-LPLIB_UTIL
-- -----------------------------------------------------------------------------
-- File          : pkg_type.vhd
-- Language      : VHDL-93
-- Module        : pkg_type
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
-- -----------------------------------------------------------------------------
-- Issues
-- 
-- -----------------------------------------------------------------------------
-- Copyright (c) 2021 Luca Pilato
-- MIT License
-- -----------------------------------------------------------------------------
-- date        who               changes
-- 2020-03-31  Luca Pilato       file creation
-- =============================================================================


-- IEEE lib
-- ----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- The type classification of VHDL is shown below.
--   Users can declare their own types and subtypes.
--   A type statement is used to declare a new type.
--   A subtype statement is used to constrain an existing type.
-- 
-- types-+-scalar----+-discrete-------+-integer-------+-integer
--       |           |                |               +-natural
--       |           |                |               +-positive
--       |           |                |
--       |           |                +-enumeration---+-boolean
--       |           |                                +-bit
--       |           |                                +-character
--       |           |                                +-file_open_kind
--       |           |                                +-file_open_status
--       |           |                                +-severity_level
--       |           |
--       |           +-floating point-+-----------------real
--       |           |
--       |           +-physical-------+-----------------delay_length
--       |                            +-----------------time
--       |
--       +-composite-+-array----------+-constrained-
--       |           |                |
--       |           |                +-unconstrained-+-bit_vector
--       |           |                                +-string
--       |           |
--       |           +-record-
--       |
--       +-access-
--       |
--       +-file-


package pkg_type is
 
    -- "WORDY" system data type
    -- -------------------------------------------------------------------------

    -- quartet
    constant NIBBLE_WIDTH   : positive  := 4;
    subtype nibble_t is std_logic_vector(NIBBLE_WIDTH-1 downto 0);
    type nibble_v_t  is array (natural range <>) of nibble_t;

    -- octect
    constant BYTE_WIDTH     : positive  := 8;
    subtype byte_t is std_logic_vector(BYTE_WIDTH-1 downto 0);
    type byte_v_t  is array (natural range <>) of byte_t;

    -- half word
    constant HWORD_WIDTH    : positive  := 16;
    subtype hword_t is std_logic_vector(HWORD_WIDTH-1 downto 0);
    type hword_v_t  is array (natural range <>) of hword_t;

    -- word
    constant WORD_WIDTH     : positive  := 32;
    subtype word_t is std_logic_vector(WORD_WIDTH-1 downto 0);
    type word_v_t  is array (natural range <>) of word_t;

    -- double word
    constant DWORD_WIDTH    : positive  := 64;
    subtype dword_t is std_logic_vector(DWORD_WIDTH-1 downto 0);
    type dword_v_t  is array (natural range <>) of dword_t;

    -- quadruple word
    constant QWORD_WIDTH    : positive  := 128;
    subtype qword_t is std_logic_vector(QWORD_WIDTH-1 downto 0);
    type qword_v_t  is array (natural range <>) of qword_t;

    -- octuple word
    constant OWORD_WIDTH    : positive  := 256;
    subtype oword_t is std_logic_vector(OWORD_WIDTH-1 downto 0);
    type oword_v_t  is array (natural range <>) of oword_t;

    -- hexuple word
    constant XWORD_WIDTH    : positive  := 512;
    subtype xword_t is std_logic_vector(XWORD_WIDTH-1 downto 0);
    type xword_v_t  is array (natural range <>) of xword_t;


    -- EXPLICIT system data type
    -- -------------------------------------------------------------------------
    subtype data2_t  is std_logic_vector(1  downto 0);
    subtype data3_t  is std_logic_vector(2  downto 0);
    subtype data4_t  is std_logic_vector(3  downto 0);
    subtype data5_t  is std_logic_vector(4  downto 0);
    subtype data6_t  is std_logic_vector(5  downto 0);
    subtype data7_t  is std_logic_vector(6  downto 0);
    subtype data8_t  is std_logic_vector(7  downto 0);
    subtype data9_t  is std_logic_vector(8  downto 0);
    subtype data10_t is std_logic_vector(9  downto 0);
    subtype data11_t is std_logic_vector(10 downto 0);
    subtype data12_t is std_logic_vector(11 downto 0);
    subtype data13_t is std_logic_vector(12 downto 0);
    subtype data14_t is std_logic_vector(13 downto 0);
    subtype data15_t is std_logic_vector(14 downto 0);
    subtype data16_t is std_logic_vector(15 downto 0);
    subtype data17_t is std_logic_vector(16 downto 0);
    subtype data18_t is std_logic_vector(17 downto 0);
    subtype data19_t is std_logic_vector(18 downto 0);
    subtype data20_t is std_logic_vector(19 downto 0);
    subtype data21_t is std_logic_vector(20 downto 0);
    subtype data22_t is std_logic_vector(21 downto 0);
    subtype data23_t is std_logic_vector(22 downto 0);
    subtype data24_t is std_logic_vector(23 downto 0);
    subtype data25_t is std_logic_vector(24 downto 0);
    subtype data26_t is std_logic_vector(25 downto 0);
    subtype data27_t is std_logic_vector(26 downto 0);
    subtype data28_t is std_logic_vector(27 downto 0);
    subtype data29_t is std_logic_vector(28 downto 0);
    subtype data30_t is std_logic_vector(29 downto 0);
    subtype data31_t is std_logic_vector(30 downto 0);
    subtype data32_t is std_logic_vector(31 downto 0);


    -- Vector data type
    -- -------------------------------------------------------------------------
    type int_v  is array (natural range <>) of integer;
    type nat_v  is array (natural range <>) of natural;
    type pos_v  is array (natural range <>) of positive;
    type real_v is array (natural range <>) of real;

    
end package pkg_type;