
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_top is
    port (
        sysclk: in std_logic;
        n_Reset: in std_logic;
        E,F,G,H: in std_logic_vector(15 downto 0);
        X,Y,Z,W: in std_logic_vector(31 downto 0);
        S: in std_logic_vector(1 downto 0);
        Q : out std_logic_vector(15 downto 0);
        Q_wide : out std_logic_vector(31 downto 0));
end mux_top;

architecture rtl of mux_top is

    component gen_busmux4to1 is
    generic ( DATA_WIDTH : integer := 8 );  
    port (
        clk, n_Reset: in std_logic;
        A,B,C,D : in std_logic_vector(DATA_WIDTH-1 downto 0);
        S : in std_logic_vector(1 downto 0);
        Y : out std_logic_vector(DATA_WIDTH-1 downto 0)
     );
    end component gen_busmux4to1;  
    
    --signal E,F,G,H: std_logic_vector(15 downto 0);
    --signal X,Y,Z,W: std_logic_vector(31 downto 0);
    --signal n_Reset: std_logic;
begin
    --n_Reset <= '0';
    
	i_busmux16: gen_busmux4to1
    generic map (
        DATA_WIDTH  => 16
    )
    port map (n_Reset    => n_Reset,
			clk        => sysclk,
			A  => E, B => F, C  => G, D => H,
			S => S,
			Y => Q);

	i_busmux32: gen_busmux4to1
    generic map (
        DATA_WIDTH  => 32
    )
    port map (n_Reset    => n_Reset,
			clk        => sysclk,
			A  => X, B => Y, C  => Z, D => W,
			S => S,
			Y => Q_wide);

end rtl;
