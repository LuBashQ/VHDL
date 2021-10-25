library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gen_busmux4to1 is
    generic (
        DATA_WIDTH : integer := 8
    );  
    port (
        clk, n_Reset: in std_logic;
        A,B,C,D : in std_logic_vector(DATA_WIDTH-1 downto 0);
        S : in std_logic_vector(1 downto 0);
        Y : out std_logic_vector(DATA_WIDTH-1 downto 0)
     );
end gen_busmux4to1;

architecture rtl of gen_busmux4to1 is
begin
    sync_mux_p: process(clk, n_Reset) 
    begin
        if n_Reset = '0' then
            Y <= (others => '0');
        elsif rising_edge(clk) then
            case S is
                when "00" => Y <= A;
                when "01" => Y <= B;
                when "10" => Y <= C;
                when others => Y <= D;
            end case;
        end if; --clk/rst
    end process sync_mux_p;
end architecture rtl;