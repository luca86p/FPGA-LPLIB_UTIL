-- =============================================================================
-- Whatis        : package of utility procedures for testbench
-- Project       : FPGA-LPLIB_UTIL
-- -----------------------------------------------------------------------------
-- File          : pkg_pro.vhd
-- Language      : VHDL-93
-- Module        : pkg_pro
-- Library       : lplib_util
-- -----------------------------------------------------------------------------
-- Author(s)     : Luca Pilato <pilato[punto]lu[chiocciola]gmail[punto]com>
--                 
-- Company       : 
-- Addr          : 
-- -----------------------------------------------------------------------------
-- Description
--
--  Communication protocol procedures:
--      UART_SEND(data, uart_tx, BAUD_RATE, MSB_FIRST)
-- 
-- -----------------------------------------------------------------------------
-- Dependencies
-- 
--  use lplib_util.pkg_type.all;
--  use lplib_util.pkg_const.all;
--  use lplib_util.pkg_fun.all;
-- 
-- -----------------------------------------------------------------------------
-- Issues
-- 
-- -----------------------------------------------------------------------------
-- Copyright (c) 2021 Luca Pilato
-- MIT License
-- -----------------------------------------------------------------------------
-- date        who               changes
-- 2019-10-15  Luca Pilato       file creation
-- =============================================================================


-- IEEE lib
-- ----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- User lib
-- ----------------------------------------
library lplib_util;
use lplib_util.pkg_type.all;
use lplib_util.pkg_const.all;
use lplib_util.pkg_fun.all;


package pkg_pro is

    -- Low-level UART send data
    procedure UART_SEND (
        constant data       : in  std_logic_vector; -- unconstrained
        signal   uart_tx    : out std_logic;        -- sender tx
        constant BAUD_RATE  : in  positive;         -- e.g. 115200 Hz
        constant MSB_FIRST  : in  integer range 0 to 1
    );
    


end package pkg_pro;


package body pkg_pro is

    -- Low-level UART send data
    procedure UART_SEND (
        constant data       : in  std_logic_vector;
        signal   uart_tx    : out std_logic;
        constant BAUD_RATE  : in  positive;
        constant MSB_FIRST  : in  integer range 0 to 1
    ) is 
        -- constant TBIT       : time      := (1.0/real(BAUD_RATE)) * 1 sec;
        constant TBIT       : time      := 1.0e10/real(115200) * (0.1 ns);
        variable DATA_BITS  : positive  := data'length;
    begin
        -- Start Bit
        uart_tx     <= '0';
        wait for TBIT;
        -- Data: unconstrained vector indexes [0 1 2 3 ...]
        if MSB_FIRST=0 then
            for i in 0 to DATA_BITS-1 loop -- LSB first
                uart_tx     <= data(i);
                wait for TBIT;
            end loop;
        else
            for i in DATA_BITS-1 downto 0 loop -- MSB first
                uart_tx     <= data(i);
                wait for TBIT;
            end loop;
        end if;
        
        -- Stop Bit
        uart_tx     <= '1';
        wait for TBIT;
        uart_tx     <= 'Z';
    end procedure UART_SEND;

end package body pkg_pro;