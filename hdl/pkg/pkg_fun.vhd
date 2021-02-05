-- =============================================================================
-- Whatis        : package of utility functions
-- Project       : FPGA-LPLIB_UTIL
-- -----------------------------------------------------------------------------
-- File          : pkg_fun.vhd
-- Language      : VHDL-93
-- Module        : pkg_fun
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
--  use lplib_util.pkg_const.all;
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


-- STD lib
-- ----------------------------------------
library std;
use std.textio.all;

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



package pkg_fun is

    -- *************************************************************************
    -- Integer/real functions
    -- *************************************************************************

    function is_positive(x : integer) return boolean;
    -- Perform: check if x>0  
    -- Return: true if x>0  

    function is_positive(x : integer) return integer;
    -- Perform: check if x>0  
    -- Return: 1 if x>0  
    
    function log2ceil(x : integer) return integer;
    -- Perform: ceil(log2(x))
    -- Note: Max result is 32, error if x > 2^32

    function log2floor(x : integer) return integer;
    -- Perform: floor(log2(x))
    -- Note: Max result is 32, error if x > 2^32

    function pow2next(x : integer) return integer;
    -- Next (or eq) power of 2
    -- Perform: 2^ceil(log2(x))
    -- Note: Max result is 2^32, error if x > 2^32

    function pow2prev(x : integer) return integer;
    -- Previous (or eq) power of 2
    -- Perform: 2^floor(log2(x))
    -- Note: Max result is 2^32, error if x > 2^32

    function real2int(x : real; rounding : integer) return integer;
    -- Perform: Integer conversion from real.
    -- selectable type of rounding:
    -- 0 : floor
    --     floor(2.8) = 2; floor(-2.8) = -3 
    -- 1 : ceil
    --     ceil(2.8) = 3; ceil(-2.8) = -2 
    -- 2 : round
    --     round(2.8) = 3; round(-2.8) = -3
    --      integer FLOOR(X + 0.5) if X > 0;
    --      integer CEIL(X - 0.5) if X < 0



    -- *************************************************************************
    -- Min/Max/Sort
    -- *************************************************************************

    function min(a : integer; b : integer) return integer;
    -- Perform: min(a,b)

    function min(v : int_v) return integer;
    -- Perform: min(int vector)

    function min_sel(v : int_v; sel : std_logic_vector) return integer;
    -- Perform: min(int vector) among the elements selected by the std_logic_vector
   
    function min_idx(v : int_v) return std_logic_vector;
    -- Perform: index_of(min(int vector))
    -- Note: v = [-5 6 8 1]    min_idx = "0001"
    -- To swap index use reverse(min_idx(v))
       
    function max(a : integer; b : integer) return integer;
    -- Perform: max(a,b)

    function max(v : int_v) return integer;
    -- Perform: max(int vector)

    function max_sel(v : int_v; sel : std_logic_vector) return integer;
    -- Perform: max(int vector) among the elements selected by the std_logic_vector
    
    function max_idx(v : int_v) return std_logic_vector;
    -- Perform: index_of(max(int vector))
    -- Note: v = [-5 6 8 1]    max_idx = "0100"
    -- To swap index use reverse(max_idx(v))


    function isort(iv : int_v; mode : integer) return int_v;
    -- Perform: bubble sort on integer vector
    -- increasing order if mode = 1
    -- decresing order otherwise


    

    -- *************************************************************************
    --  Utilities std_logic_vector Functions
    -- *************************************************************************

    function reverse(v : std_logic_vector) return std_logic_vector;
    -- [ ... b3 b2 b1 b0 ] -> [ b0 b1 b2 b3 ... ]

    function bytetwist(v : std_logic_vector) return std_logic_vector;
    -- [byte3][byte2][byte1][byte0] -> [byte0][byte1][byte2][byte3]

    function shift_v(v : std_logic_vector; lr : character; n : positive) return std_logic_vector;
    -- v = v (<< or >>) by n, with insertion of '0' (logical shift)


    function rotate_v(v : std_logic_vector; lr : character; n : positive) return std_logic_vector;
    -- v = v (<< or >>) by n, with insertion of exiting bits

    -- inside STD_LOGIC_1164
    -- function IS_X ( S : STD_ULOGIC_VECTOR ) return BOOLEAN;
    -- function IS_X ( S : STD_LOGIC_VECTOR  ) return BOOLEAN;
    -- function IS_X ( S : STD_ULOGIC        ) return BOOLEAN;
    
    -- custom negation 
    --function ISNOT_X ( S : STD_ULOGIC_VECTOR ) return BOOLEAN;
    function ISNOT_X ( S : STD_LOGIC_VECTOR  ) return BOOLEAN;
    function ISNOT_X ( S : STD_ULOGIC        ) return BOOLEAN;


    function gen_decode(v : std_logic_vector) return std_logic_vector;
    -- generate a combinational decoder
    -- input N bits -> output is 2^N bits 

    function xorv(v : std_logic_vector) return std_logic;
    -- vector bitwise xor

    function orv (v : std_logic_vector) return std_logic;
    -- vector bitwise or

    function andv(v : std_logic_vector) return std_logic;
    -- vector bitwise and
    
    function parity_even(v : std_logic_vector) return std_logic;
    -- xor (to get even number of 1s)

    function parity_odd(v : std_logic_vector) return std_logic;
    -- not(xor) (to get odd number of 1s)


    function num_of_ones(v : in std_logic_vector) return natural;
    -- Returns the number of 1s in a vector

    function dec_to_gray(v : std_logic_vector) return std_logic_vector;
    -- converts the unsigned representation of v in the correspondent gray code 
    -- can be used as combinational logics
    -- v xor (v >> 1)


    -- *************************************************************************
	--  Quantization Utility Functions
	-- *************************************************************************
    
    function r_quantize(x : real; A : real; Bout : integer) return std_logic_vector;
    -- Quantize real number x on Bout bits.
    -- A    : scale factor. 
    -- lsb  := A / (2^(Bout-1)-1);   -- always C2-balanced
    -- -- Use A = |x|_max as max quantizable real value 


    function floor_noresize(v : in std_logic_vector; b : in positive) return std_logic_vector;
    -- Perform: 2^b*floor(x/2^b) good for signed and unsigned

    function alignDown(a : in unsigned; b : in natural) return unsigned;
    -- Returns the first integer multiple of 2^b below or equal to a

    function ceil_noresize(v : in std_logic_vector; b : in positive) return std_logic_vector;
    -- Perform: 2^b*ceil(x/2^b) good for signed and unsigned
    
    function alignUp(a : in unsigned; b : in natural) return unsigned;
    -- Returns the first unsigned multiple of 2^b above or equal to a
    
    function isTruncated(v : in std_logic_vector; b : in positive) return boolean;
    -- Returns true if a is an integer multiple of 2^b, false otherwise
    
    function isAligned(a : in unsigned; b : natural) return boolean;
    -- Returns true if a is an integer multiple of 2^b, false otherwise


    function q_saturate(x : std_logic_vector; Bout : positive; mode : integer) return std_logic_vector;
    -- Perform: Saturation to Bout bits (take the low part, same LSB)
	-- selectable type of operand mode:
    -- 0 : unsigned
    -- 1 : signed unbalanced
    -- 2 : signed balanced

    function q_truncate(x : std_logic_vector; Btrunc : positive; mode, rounding : integer) return std_logic_vector;
    -- Perform: Truncation to Bout bits (take the high part, change LSB to 2^Btrunc)
    -- selectable type of operand mode:
    -- 0 : unsigned
    -- 1 : signed unbalanced
    -- 2 : signed balanced
    -- selectable type of rounding:
    -- 0 : floor
    -- 1 : round (saturate last code)
    -- 2 : towardzero (saturate last code)



    -- *************************************************************************
	--  Display/Test-bench Functions
	-- *************************************************************************

    function to_hstring (value : std_logic_vector) return string;
    -- converts std_logic_vector to hex string

    function to_hstring (value : std_logic) return string;
    -- converts std_logic to hex string (char)


    function to_str_any ( v : std_logic) return string;
    function to_str_any ( v : std_logic_vector) return string;
    -- converts in string STD_LOGIC value (UX01ZWLH-)

    function to_str     ( v : std_logic) return string;
    function to_str     ( v : std_logic_vector) return string;
    -- converts in string TO_X01Z

    function to_str     ( i : integer) return string;
    function to_str     ( b : boolean) return string;
    function to_str     ( r : real) return string;
    -- converts in string

    procedure print_output(s : string);
    -- print on console output

end package pkg_fun;



package body pkg_fun is

    -- *************************************************************************
    -- Integer/real functions
    -- *************************************************************************

    function is_positive (x : integer) return boolean is
    begin
        if x>0 then
            return true;
        else
            return false;
        end if;
    end is_positive;


    function is_positive (x : integer) return integer is
    begin
        if is_positive(x) then
            return 1;
        else
            return 0;
        end if;
    end is_positive;


    function log2ceil (x : integer) return integer is
        variable y : integer;
    begin
        --
        assert ( x <= 2**31-1 )
            report "log2ceil: Attempt to compute log2 of " & to_str(x) & " (greater than " & to_str(2**31-1) & ")"
                severity error;
        --
        for i in 0 to 32 loop
            if (2**i)>=x then
                y := i;
                exit;
            end if;
        end loop;
        return y;
    end log2ceil;

    -- old style
    -- ----------------------------------------
    -- function log2ceil (x : integer) return integer is
    --     variable y       : integer;
    -- begin
    --     assert (x <= 4294967296)
    --         report "Attempt to compute log2 of a number greater than 4294967296!"
    --             severity error;
	-- 	if (x > 2147483648) then
	-- 	    y := 32;
	-- 	elsif (x > 1073741824) then
	-- 	    y := 31;
    --     elsif (x > 536870912) then
    --         y := 30;
    --     elsif (x > 268435456) then
    --         y := 29;
    --     elsif (x > 134217728) then
    --         y := 28;
    --     elsif (x > 67108864) then
    --         y := 27;
    --     elsif (x > 33554432) then
    --         y := 26;
    --     elsif (x > 16777216) then
    --         y := 25;
    --     elsif (x > 8388608) then
    --         y := 24;
    --     elsif (x > 4194304) then
    --         y := 23;
    --     elsif (x > 2097152) then
    --         y := 22;
    --     elsif (x > 1048576) then
    --         y := 21;
    --     elsif (x > 524288) then
    --         y := 20;
    --     elsif (x > 262144) then
    --         y := 19;
    --     elsif (x > 131072) then
    --         y := 18;
    --     elsif (x > 65536) then
    --         y := 17;
    --     elsif (x > 32768) then
    --         y := 16;
    --     elsif (x > 16384) then
    --         y := 15;
    --     elsif (x > 8192) then
    --         y := 14;
    --     elsif (x > 4096) then
    --         y := 13;
    --     elsif (x > 2048) then
    --         y := 12;
    --     elsif (x > 1024) then
    --         y := 11;
    --     elsif (x > 512) then
    --         y := 10;
    --     elsif (x > 256) then
    --         y := 9;
    --     elsif (x > 128) then
    --         y := 8;
    --     elsif (x > 64) then
    --         y := 7;
    --     elsif (x > 32) then
    --         y := 6;
    --     elsif (x > 16) then
    --         y := 5;
    --     elsif (x > 8) then
    --         y := 4;
    --     elsif (x > 4) then
    --         y := 3;
    --     elsif (x > 2) then
    --         y := 2;
    --     elsif (x > 1) then
    --         y := 1;
    --     else
    --         y := 0;
    --     end if;
    --     return y;
    -- end log2ceil;


    function log2floor (x : integer) return integer is
        variable y : integer;
    begin
        --
        assert ( x <= 2**31-1 )
            report "log2floor: Attempt to compute log2 of " & to_str(x) & " (greater than " & to_str(2**31-1) & ")"
                severity error;
        --
        for i in 0 to 32 loop
            if (2**i)>x then
                y := i-1;
                exit;
            end if;
        end loop;
        return y;
    end log2floor;


    function pow2next (x : integer) return integer is
        variable y : integer;
    begin
        y := 2**log2ceil(x);
        return y;
    end pow2next;


    function pow2prev (x : integer) return integer is
        variable y : integer;
    begin
        y := 2**log2floor(x);
        return y;
    end pow2prev;


    function real2int(x : real; rounding : integer) return integer is
        variable y : integer;
    begin
        case rounding is
            when 0 =>
                y := integer(FLOOR(x));
            when 1 =>
                y := integer(CEIL(x));
            when 2 =>
                y := integer(ROUND(x));
            when others =>
                y := integer(ROUND(x));
        end case;
        return y;
    end real2int;


    
    
    -- *************************************************************************
    -- Min/Max/Sort
    -- *************************************************************************
    
    function min(a : integer; b : integer) return integer is
    begin
        if a < b then
          return a;
        else
          return b;
        end if;
    end min;

    function min(v : int_v) return integer is
        variable current_min    : integer;
    begin
        for i in 0 to v'length-1 loop
            if i = 0 then
                current_min := v(i);
            else
                if (v(i) < current_min) then
                    current_min := v(i);
                end if;
            end if;
        end loop;
        return current_min;
    end min;

    function min_sel(v : int_v; sel : std_logic_vector) return integer is
        variable current_min    : integer;
        variable first          : integer;
    begin
        first := 1;
        for i in 0 to sel'length-1 loop
            if sel(i) = '1' then
                if first = 1 then
                    current_min := v(i);
                    first := 0;
                else
                    if (v(i) < current_min) then
                        current_min := v(i);
                    end if;
                end if;
            end if;
        end loop;
        return current_min;
    end min_sel;

    function min_idx(v : int_v) return std_logic_vector is
        variable current_min    : integer;
        variable cur_min_idx    : integer;
        variable min_idx_v      : std_logic_vector(v'length-1 downto 0);
    begin
        min_idx_v   := (others=>'0');
        for i in 0 to v'length-1 loop
            if i = 0 then
                current_min := v(i);
                cur_min_idx := i;
            else
                if (v(i) < current_min) then
                    current_min := v(i);
                    cur_min_idx := i;
                end if;
            end if;
        end loop;
        min_idx_v(cur_min_idx)    := '1';
        return min_idx_v;
    end min_idx;



    function max(a : integer; b : integer) return integer is
    begin
        if a > b then
          return a;
        else
          return b;
        end if;
    end max;

    function max(v : int_v) return integer is
        variable current_max    : integer;
    begin
        for i in 0 to v'length-1 loop
            if i = 0 then
                current_max := v(i);
            else
                if (v(i) > current_max) then
                    current_max := v(i);
                end if;
            end if;
        end loop;
        return current_max;
    end max;

    function max_sel(v : int_v; sel : std_logic_vector) return integer is
        variable current_max    : integer;
        variable first          : integer;
    begin
        first := 1;
        for i in 0 to sel'length-1 loop
            if sel(i) = '1' then
                if first = 1 then
                    current_max := v(i);
                    first := 0;
                else
                    if (v(i) > current_max) then
                        current_max := v(i);
                    end if;
                end if;
            end if;
        end loop;
        return current_max;
    end max_sel;

    function max_idx(v : int_v) return std_logic_vector is
        variable current_max    : integer;
        variable cur_max_idx    : integer;
        variable max_idx_v      : std_logic_vector(v'length-1 downto 0);
    begin
        max_idx_v   := (others=>'0');
        for i in 0 to v'length-1 loop
            if i = 0 then
                current_max := v(i);
                cur_max_idx := i;
            else
                if (v(i) < current_max) then
                    current_max := v(i);
                    cur_max_idx := i;
                end if;
            end if;
        end loop;
        max_idx_v(cur_max_idx)    := '1';
        return max_idx_v;
    end max_idx;




    function isort(iv : int_v; mode : integer) return int_v is
        variable tmp_iv     : int_v(iv'range);
        variable tmp_i      : integer;
        variable swap_done  : boolean;
        variable n          : integer;
    begin
        tmp_iv      := iv;
        swap_done   := true;
        n           := iv'length-2;
        while (swap_done) loop
            swap_done   := false;
            if mode = 1 then -- increasing order
                for i in 0 to n loop
                    if (tmp_iv(i) > tmp_iv(i+1)) then
                       tmp_i        := tmp_iv(i);
                       tmp_iv(i)    := tmp_iv(i+1);
                       tmp_iv(i+1)  := tmp_i;
                       swap_done   := true;
                    end if;
                    n   := n-1; -- every loop we can eliminate a step
                end loop;
            else -- decreasing order
                for i in 0 to n loop
                    if (tmp_iv(i) < tmp_iv(i+1)) then
                       tmp_i        := tmp_iv(i);
                       tmp_iv(i)    := tmp_iv(i+1);
                       tmp_iv(i+1)  := tmp_i;
                       swap_done   := true;
                    end if;
                    n   := n-1; -- every loop we can eliminate a step
                end loop;
            end if;
        end loop;
        return tmp_iv;
    end isort;





    -- *************************************************************************
    --  Utilities std_logic_vector Functions
    -- *************************************************************************

    function reverse(v : std_logic_vector) return std_logic_vector is
        variable tmp : std_logic_vector(v'range);
    begin
        for i in v'range loop
            tmp(v'high-i) := v(i);
        end loop;
        return tmp;
    end function reverse;

    function bytetwist(v : std_logic_vector) return std_logic_vector is
        variable tmp : std_logic_vector(v'range);
        variable nbyte : integer;
    begin
        assert (v'length mod 8 = 0)
        report "Attempt to bytetwist a non byte-multiple word"
        severity error;
        nbyte := v'length / 8;
        for i in 0 to nbyte-1 loop
            tmp(tmp'high-i*8 downto tmp'high-(i+1)*8+1) :=
                v(v'low+(i+1)*8-1 downto v'low+i*8);
        end loop;
        return tmp;
    end function bytetwist;

    function shift_v(v : std_logic_vector; lr : character; n : positive) return std_logic_vector is
        variable tmp : std_logic_vector(v'range);
    begin
        tmp := v;
        for i in 1 to n loop
            if lr='l' then -- shift left
                tmp := tmp(v'high-1 downto 0) & '0';
            elsif lr='r' then -- shift right
                tmp := '0' & tmp(v'high downto 1);
            end if;
        end loop;
        return tmp;
    end function shift_v;

    function rotate_v(v : std_logic_vector; lr : character; n : positive) return std_logic_vector is
        variable tmp : std_logic_vector(v'range);
    begin
        tmp := v;
        for i in 1 to n loop
            if lr='l' then -- rotate left
                tmp := tmp(v'high-1 downto 0) & tmp(v'high);
            elsif lr='r' then -- rotate right
                tmp := tmp(0) & tmp(v'high downto 1);
            end if;
        end loop;
        return tmp;
    end function rotate_v;


    --function ISNOT_X ( S : STD_ULOGIC_VECTOR ) return BOOLEAN is
    --begin
    --    return (not IS_X(S));
    --end ISNOT_X;

    function ISNOT_X ( S : STD_LOGIC_VECTOR  ) return BOOLEAN is
    begin
        return (not IS_X(S));
    end ISNOT_X;

    function ISNOT_X ( S : STD_ULOGIC        ) return BOOLEAN is
    begin
        return (not IS_X(S));
    end ISNOT_X;



    function gen_decode(v : std_logic_vector) return std_logic_vector is
        variable res : std_logic_vector((2**v'length)-1 downto 0);
        variable i : integer range res'range;
    begin
        res := (others => '0'); i := 0;
        if ISNOT_X(v) then 
            i := to_integer(unsigned(v));
        end if;
        res(i) := '1';
        return res;
    end function gen_decode;



    function xorv(v : std_logic_vector) return std_logic is
        variable tmp : std_logic;
    begin
        tmp := '0';
        for i in v'range loop tmp := tmp xor v(i); end loop;
        return(tmp);
    end;
    
    
    function orv(v : std_logic_vector) return std_logic is
        variable tmp : std_logic;
    begin
        tmp := '0';
        for i in v'range loop tmp := tmp or v(i); end loop;
        return(tmp);
    end;
    
    
    function andv(v : std_logic_vector) return std_logic is
        variable tmp : std_logic;
    begin
      tmp := '1';
      for i in v'range loop tmp := tmp and v(i); end loop;
      return(tmp);
    end;
    



  
    function parity_even (v : std_logic_vector) return std_logic is
        variable p : std_logic;
    begin
        p := '0';
        for i in v'range loop
            p := p xor v(i);
        end loop;
        return p;
    end parity_even;

    function parity_odd  (v : std_logic_vector) return std_logic is
    begin
        return not parity_even(v);
    end parity_odd;

    
    function num_of_ones(v : in std_logic_vector) return natural is
        variable result : natural := 0;
    begin
        for i in v'range loop
            if v(i) = '1' then
                result := result + 1;
            end if;
        end loop;
        return result;
    end num_of_ones;


    function dec_to_gray(v : std_logic_vector) return std_logic_vector is
        variable result : std_logic_vector(v'range);
    begin
        result := v xor ('0' & v(v'high downto 1));
        return result;
    end dec_to_gray;




    -- *************************************************************************
	--  Quantization Utility Functions
	-- *************************************************************************
    
    -- x = -1:0.1:1  
    --     -1.0 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1  0.0  0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  0.9  1.0
    --
    -- A = 1
    -- Bout = 4
    -- y = -7   -6   -6   -5   -4   -4   -3   -2   -1   -1    0    1    1    2    3    4    4    5    6    6    7
    --
    -- xx = sin(pi*x)
    --
    -- A = 1
    -- Bout = 4
    -- y =  0  -2  -4  -6  -7  -7  -7  -6  -4  -2   0   2   4   6   7   7   7   6   4   2    0
    --
    -- A = 1
    -- Bout = 5
    -- y =  0   -5   -9  -12  -14  -15  -14  -12   -9   -5    0    5    9   12   14   15   14   12    9    5    0

    function r_quantize(x : real; A : real; Bout : integer) return std_logic_vector is
        variable lsb            : real;
        variable output_int     : integer;
        variable output         : integer;
        variable y              : std_logic_vector(Bout-1 downto 0);
    begin
        lsb        := A / real((2**(Bout-1)-1)); -- always C2-balanced
        output_int := real2int(x/lsb, 2); -- ROUND(X)
        if(output_int < 0) then -- C2
            output := 2**Bout + output_int;
        else
            output := output_int;
        end if;
        y := std_logic_vector(TO_UNSIGNED(output, Bout));
        return y;
    end r_quantize;




    function floor_noresize(v : in std_logic_vector; b : in positive) return std_logic_vector is
        variable arg_v  : std_logic_vector(v'length-1 downto 0);
    begin
        for i in v'range loop
            if i<=b then
                arg_v(i)    := '0';
            else
                arg_v(i)    := v(i);
            end if;
        end loop;
        return arg_v;
    end floor_noresize;

    function alignDown(a : in unsigned; b : in natural) return unsigned is
        variable arg_v : unsigned(a'length-1 downto 0);
    begin
        if b /= 0 then
            arg_v := shift_right(a,b);
        else
            arg_v := a;
        end if;
        return shift_left(arg_v, b);
    end function;

    function ceil_noresize(v : in std_logic_vector; b : in positive) return std_logic_vector is
        variable arg_v  : std_logic_vector(v'length-1 downto 0);
        variable msb_v  : std_logic_vector(v'length-1 downto b);
        variable lsb_v  : std_logic_vector(b-1 downto 0);
    begin
        msb_v := v(v'length-1 downto b);
        lsb_v := v(b-1 downto 0);
        if (unsigned(lsb_v) /= 0) then -- add 1 anyway (ceil)
            msb_v := std_logic_vector(unsigned(msb_v)+1);
            lsb_v := (others=>'0');
        end if;
        arg_v   := msb_v & lsb_v;
        return arg_v;
    end ceil_noresize;

    function alignUp(a : in unsigned; b : in natural) return unsigned is
        variable arg_v : unsigned(a'length-1 downto 0);
        variable lsb_v : unsigned(b-1 downto 0);
    begin
        if b /= 0 then -- prevent null ranges on lsb_v
            arg_v := shift_right(a, b);
            lsb_v := a(b-1 downto 0);
            if (lsb_v /= 0) then
                arg_v := arg_v + 1;
            end if;
        else
            arg_v := a;
        end if;
        return shift_left(arg_v, b);
    end function;

    function isTruncated(v : in std_logic_vector; b : in positive) return boolean is
    begin
        if (unsigned(v(b-1 downto 0)) = 0) then
            return true;
        else
            return false;
        end if;
    end isTruncated;

    function isAligned(a : in unsigned; b : natural) return boolean is
        variable lsb_v : unsigned(b-1 downto 0);
    begin
        if b > 0 then
            lsb_v := a(b-1 downto 0);
            if (lsb_v = 0) then
                return true;
            else
                return false;
            end if;
        else
            return true;
        end if;
    end function;





    function q_saturate(x : std_logic_vector; Bout : positive; mode : integer) return std_logic_vector is
        constant Bin            : integer := x'length;
        variable y              : std_logic_vector(Bout-1 downto 0);
        variable pos_lvl_un     : unsigned(Bin-1 downto 0);
        variable pos_lvl_sg     : signed(Bin-1 downto 0);
        variable neg_lvl_sg     : signed(Bin-1 downto 0);
        variable neg_lvl_sgb    : signed(Bin-1 downto 0);
    begin

        -- exceptions
        -- ----------------------------------------
        assert (Bout <= Bin)
            report "q_saturate: Bout > Bin !!!"
                severity error;
        -- ----------------------------------------

        --
        -- TO_UNSIGNED(2**Bout-1, Bin);
        pos_lvl_un(Bin-1 downto Bout)       := (others => '0');
        pos_lvl_un(Bout-1 downto 0)         := (others => '1');
        --
        -- TO_SIGNED(2**(Bout-1)-1, Bin);
        pos_lvl_sg(Bin-1 downto Bout-1)     := (others => '0');
        pos_lvl_sg(Bout-2 downto 0)         := (others => '1');
        --
        -- TO_SIGNED(-2**(Bout-1), Bin);
        neg_lvl_sg(Bin-1 downto Bout-1)     := (others => '1');
        neg_lvl_sg(Bout-2 downto 0)         := (others => '0');
        --
        -- TO_SIGNED(-2**(Bout-1)+1, Bin);
        neg_lvl_sgb(Bin-1 downto Bout-1)     := (others => '1');
        neg_lvl_sgb(Bout-2 downto 1)         := (others => '0');
        neg_lvl_sgb(0)                       := '1';
        
        case mode is

            when 0 => -- unsigned saturation
                if(unsigned(x) > pos_lvl_un) then
                    y := std_logic_vector(pos_lvl_un(y'range));
                else
                    y := x(y'range);
                end if;

            when 1 => -- signed unbalanced saturation
                if(signed(x) > pos_lvl_sg) then
                    y := std_logic_vector(pos_lvl_sg(y'range));
                elsif(signed(x) < neg_lvl_sg) then
                    y := std_logic_vector(neg_lvl_sg(y'range));
                else
                    y := x(y'range);
                end if;

            when 2 => -- signed balanced saturation
                if(signed(x) > pos_lvl_sg) then
                    y := std_logic_vector(pos_lvl_sg(y'range));
                elsif(signed(x) < neg_lvl_sgb) then
                    y := std_logic_vector(neg_lvl_sgb(y'range));
                else
                    y := x(y'range);
                end if;
            when others =>
                assert FALSE
                    report "q_saturate: incorrect mode !!!"
                        severity error;
        end case;
        return y;
    end function q_saturate;


  


    function q_truncate(x : std_logic_vector; Btrunc : positive; mode, rounding : integer) return std_logic_vector is
        constant Bin            : integer := x'length;
        constant Bout           : integer := Bin - Btrunc;
        variable y              : std_logic_vector(Bout-1 downto 0);
        variable lpart_x        : std_logic_vector(Btrunc-1 downto 0);
        variable tbit_x         : std_logic;
        --
        variable max_un         : unsigned(Bout-1 downto 0);
        variable min_un         : unsigned(Bout-1 downto 0);
        variable max_sg         : signed(Bout-1 downto 0);
        variable min_sg         : signed(Bout-1 downto 0);
        variable max_sgb        : signed(Bout-1 downto 0);
        variable min_sgb        : signed(Bout-1 downto 0);
    begin
        
        -- ranges
        max_un  := TO_UNSIGNED(2**Bout-1, Bout);
        min_un  := TO_UNSIGNED(0, Bout);
        max_sg  := TO_SIGNED(2**(Bout-1)-1, Bout);
        min_sg  := TO_SIGNED(-2**(Bout-1), Bout);
        max_sgb := max_sg;
        min_sgb := -max_sg;
       
        -- exceptions
        -- ----------------------------------------
        assert (Btrunc < Bin)
            report "q_truncate: Btrunc >= Bin !!!"
                severity error;
        -- ----------------------------------------
        
        case mode is

            when 0 => -- unsigned
                if rounding=0 then -- floor
                    y       := x(Bin-1 downto Btrunc);
                elsif rounding=1 then -- round
                    y       := x(Bin-1 downto Btrunc);
                    if unsigned(y)/=max_un then
                        tbit_x  := x(Btrunc-1);
                        if tbit_x='1' then
                            y   := std_logic_vector(unsigned(y)+1);
                        end if;
                    end if;
                elsif rounding=2 then -- towardzero
                    y       := x(Bin-1 downto Btrunc);
                else
                    assert FALSE
                        report "q_saturate: incorrect rounding !!!"
                            severity error;
                end if;

            when 1 => -- signed unbalanced
                if rounding=0 then -- floor
                    y       := x(Bin-1 downto Btrunc);
                elsif rounding=1 then -- round
                    y       := x(Bin-1 downto Btrunc);
                    if signed(y)/=max_sg then
                        tbit_x  := x(Btrunc-1);
                        if tbit_x='1' then
                            y   := std_logic_vector(signed(y)+1);
                        end if;
                    end if;
                elsif rounding=2 then -- towardzero
                    y       := x(Bin-1 downto Btrunc);
                    if signed(y)<0 then
                        tbit_x  := x(Btrunc-1);
                        if tbit_x='1' then
                            y   := std_logic_vector(signed(y)+1);
                        end if;
                    end if;
                else
                    assert FALSE
                        report "q_saturate: incorrect rounding !!!"
                            severity error;
                end if;              

            when 2 => -- signed balanced
                if rounding=0 then -- floor
                    y       := x(Bin-1 downto Btrunc);
                    y       := q_saturate(y, Bout, mode);
                elsif rounding=1 then -- round
                    y       := x(Bin-1 downto Btrunc);
                    if signed(y)/=max_sg then
                        tbit_x  := x(Btrunc-1);
                        if tbit_x='1' then
                            y   := std_logic_vector(signed(y)+1);
                        end if;
                    end if;
                    y       := q_saturate(y, Bout, mode);
                elsif rounding=2 then -- towardzero
                    y       := x(Bin-1 downto Btrunc);
                    if signed(y)<0 then
                        tbit_x  := x(Btrunc-1);
                        if tbit_x='1' then
                            y   := std_logic_vector(signed(y)+1);
                        end if;
                    end if;
                    y       := q_saturate(y, Bout, mode);
                else
                    assert FALSE
                        report "q_saturate: incorrect rounding !!!"
                            severity error;
                end if; 
        
            when others =>
                assert FALSE
                    report "q_saturate: incorrect mode !!!"
                        severity error;
        end case;
        return y;
    end q_truncate;




    -- *************************************************************************
	--  Display Functions
	-- *************************************************************************


    function to_str_any (v : std_logic) return string is
    begin
        case v is
            when '1' => return "1";
            when '0' => return "0";
            when '-' => return "-";
            when 'U' => return "U";
            when 'X' => return "X";
            when 'Z' => return "Z";
            when 'H' => return "H";
            when 'L' => return "L";
            when 'W' => return "W";
        end case;
    end function to_str_any;

    function to_str_any (v : std_logic_vector) return string is
        constant len: natural := v'length;
        variable str: string(1 to len);
        variable i: integer;
    begin
        i := 1;
        for x in v'range loop      
            str(i to i) := to_str_any(v(x));
            i := i+1;
        end loop;
        return str;
    end;
      


    function to_str (v : std_logic) return string is
    begin
        if TO_X01(v) = '1' then
            return("1");
        else 
            return("0");
        end if;
    end function to_str;
    
    function to_str (v : std_logic_vector) return string is
        constant len: natural := v'length;
        variable str: string(1 to len);
        variable i: integer;
    begin
        i := 1;
        for x in v'range loop      
            str(i to i) := to_str(v(x));
            i := i+1;
        end loop;
        return str;
    end;
          
    
    -- old (gaisler)
    -- function tost(i : integer) return string is
    --     variable L : line;
    --     variable s, x : string(1 to 128);
    --     variable n, tmp : integer := 0;
    --     begin
    --       tmp := i;
    --       if i < 0 then tmp := -i; end if;
    --       loop
    --         s(128-n) := todec(tmp mod 10);
    --         tmp := tmp / 10;
    --         n := n+1;
    --         if tmp = 0 then exit; end if;
    --       end loop;
    --       x(1 to n) := s(129-n to 128);
    --       if i < 0 then return "-" & x(1 to n); end if;
    --       return(x(1 to n));
    --     end;

    function to_str     (i : integer) return string is
    begin
        return integer'image(i);
    end function to_str;


    function to_str     (b : boolean) return string is
    begin
        if b then 
            return "true";
        else 
            return "false";
        end if;
    end to_str;


    -- old (gaisler)
    -- function tost(r: real) return string is
    --     variable x: real;
    --     variable i,j: integer;
    --     variable s: string(1 to 30);
    --     variable c: character;
    --   begin
    --     if r = 0.0 then
    --       return "0.0000";
    --     elsif r < 0.0 then
    --       return "-" & tost(-r);
    --     elsif r < 0.001 then
    --       x:=r; i:=0;
    --       while x<1.0 loop x:=x*10.0; i:=i+1; end loop;
    --       return tost(x) & "e-" & tost(i);
    --     elsif r >= 1000000.0 then
    --       x:=10000000.0; i:=6;
    --       while r>=x loop x:=x*10.0; i:=i+1; end loop;
    --       return tost(10.0*r/x) & "e+" & tost(i);
    --     else
    --       i:=0; x:=r+0.00005;
    --       while x >= 10.0 loop x:=x/10.0; i:=i+1; end loop;
    --       j := 1;
    --       while i > -5 loop
    --         if x >= 9.0 then c:='9'; x:=x-9.0;
    --         elsif x >= 8.0 then c:='8'; x:=x-8.0;
    --         elsif x >= 7.0 then c:='7'; x:=x-7.0;
    --         elsif x >= 6.0 then c:='6'; x:=x-6.0;
    --         elsif x >= 5.0 then c:='5'; x:=x-5.0;
    --         elsif x >= 4.0 then c:='4'; x:=x-4.0;
    --         elsif x >= 3.0 then c:='3'; x:=x-3.0;
    --         elsif x >= 2.0 then c:='2'; x:=x-2.0;
    --         elsif x >= 1.0 then c:='1'; x:=x-1.0;
    --         else c:='0';
    --         end if;
    --         s(j) := c;
    --         j:=j+1;
    --         if i=0 then s(j):='.'; j:=j+1; end if;
    --         i:=i-1;
    --         x := x * 10.0;
    --       end loop;
    --       return s(1 to j-1);
    --     end if;    
    --   end tost;


    function to_str     (r : real) return string is
    begin
        return real'image(r);
    end function to_str;



    function to_hstring (value : std_logic_vector) return string is
        constant ne            : integer := integer(ceil(real(value'length)/real(4)));
        variable pad           : std_logic_vector((ne*4 - value'length) - 1 downto 0);
        variable ivalue        : std_logic_vector(ne*4 - 1 downto 0);
        variable result        : string(ne downto 1);
        variable quad          : std_logic_vector(3 downto 0);
    begin
        if value'length < 1 then
            return "";
        else
            if value (value'left) = 'Z' then
                pad := (others => 'Z');
            else
                pad := (others => '0');
            end if;
            ivalue := pad & value;
            for i in 0 to ne-1 loop
                quad := To_X01Z(ivalue(4*i+3 downto 4*i));
                case quad is
                    when x"0"    => result(i+1) := '0';
                    when x"1"    => result(i+1) := '1';
                    when x"2"    => result(i+1) := '2';
                    when x"3"    => result(i+1) := '3';
                    when x"4"    => result(i+1) := '4';
                    when x"5"    => result(i+1) := '5';
                    when x"6"    => result(i+1) := '6';
                    when x"7"    => result(i+1) := '7';
                    when x"8"    => result(i+1) := '8';
                    when x"9"    => result(i+1) := '9';
                    when x"A"    => result(i+1) := 'A';
                    when x"B"    => result(i+1) := 'B';
                    when x"C"    => result(i+1) := 'C';
                    when x"D"    => result(i+1) := 'D';
                    when x"E"    => result(i+1) := 'E';
                    when x"F"    => result(i+1) := 'F';
                    when "ZZZZ"  => result(i+1) := 'Z';
                    when others  => result(i+1) := 'X';
                end case;
            end loop;
            return result;
        end if;
    end function to_hstring;


    function to_hstring (value : std_logic) return string is
        variable ivalue        : std_logic_vector(3 downto 0);
        variable result        : string(1 downto 1);
    begin
        if value = 'Z' then
            ivalue  := (others=>'Z');
        else
            ivalue  := "000" & value;
        end if;
        case ivalue is
            when x"0"    => result(1) := '0';
            when x"1"    => result(1) := '1';
            when x"2"    => result(1) := '2';
            when x"3"    => result(1) := '3';
            when x"4"    => result(1) := '4';
            when x"5"    => result(1) := '5';
            when x"6"    => result(1) := '6';
            when x"7"    => result(1) := '7';
            when x"8"    => result(1) := '8';
            when x"9"    => result(1) := '9';
            when x"A"    => result(1) := 'A';
            when x"B"    => result(1) := 'B';
            when x"C"    => result(1) := 'C';
            when x"D"    => result(1) := 'D';
            when x"E"    => result(1) := 'E';
            when x"F"    => result(1) := 'F';
            when "ZZZZ"  => result(1) := 'Z';
            when others  => result(1) := 'X';
        end case;
        return result;
    end function to_hstring;


    procedure print_output(s : string) is
        variable L : line;
    begin
        L := new string'(s);
        writeline(output, L);
    end procedure print_output;

end package body pkg_fun;
