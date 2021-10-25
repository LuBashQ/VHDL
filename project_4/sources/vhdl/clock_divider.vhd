----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2021 12:27:40
-- Design Name: 
-- Module Name: clock_divider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_divider is
    generic(output_f: integer:= 125e5 --Hz
    );
    Port (  sysclk : in std_logic;
            n_Reset: in std_logic;
            output_s: out std_logic
             );
end clock_divider;

architecture Behavioral of clock_divider is
    signal count: integer := 0;
    signal max: integer := (125e6/output_f)/2 -1;
    signal output_copy: std_logic := '0';
    
begin
    process(sysclk, n_Reset) is
    begin
        if n_Reset='1' then
            count <= 0;
            output_copy <= '0';
        elsif sysclk'event and sysclk = '1' then
            if count >= max then
                count <= 0;
                output_copy <= not output_copy;
            else
                count <= count + 1;
                output_copy <= output_copy;
            end if;
        end if;
        output_s <= output_copy; 
    end process;
end Behavioral;
