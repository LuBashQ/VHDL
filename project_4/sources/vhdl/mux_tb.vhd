----------------------------------------------------------------------------------
-- Company: Turku University of Applied Sciences
-- Engineer: Jarno Tuominen
-- Description: Test bench example 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_tb is
--  Port ( ); -- no ports in test bench
end mux_tb;

architecture Behavioral of mux_tb is

    constant SYSCLK_PERIOD : time := 8 ns; -- 125MHz
    signal sysclk: std_logic := '0'; -- init to 0 for simulation
    signal n_Reset : std_logic := '0'; -- init to 0 for simulation

    -- these are the stimulus signals (inputs)
    signal S_int: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    -- 16-bit buses
    signal E_int: STD_LOGIC_VECTOR(15 downto 0) := X"CAFE";
    signal F_int: STD_LOGIC_VECTOR(15 downto 0) := X"ABBA";
    signal G_int: STD_LOGIC_VECTOR(15 downto 0) := X"DEAD";
    signal H_int: STD_LOGIC_VECTOR(15 downto 0) := X"BEEF";
    -- 32-bit buses
    signal X_int: STD_LOGIC_VECTOR(31 downto 0) := X"12345678";
    signal Y_int: STD_LOGIC_VECTOR(31 downto 0) := X"ABCDABCD";
    signal Z_int: STD_LOGIC_VECTOR(31 downto 0) := X"DEADBEEF";
    signal W_int: STD_LOGIC_VECTOR(31 downto 0) := X"F000F000";

    signal Q_int:  STD_LOGIC_VECTOR(15 downto 0);
    signal Q_wide_int:  STD_LOGIC_VECTOR(31 downto 0);

    component mux_top is
    port (
        sysclk: in std_logic;
        n_Reset: in std_logic;
        E,F,G,H: in std_logic_vector(15 downto 0);
        X,Y,Z,W: in std_logic_vector(31 downto 0);
        S: in std_logic_vector(1 downto 0);
        Q : out std_logic_vector(15 downto 0);
        Q_wide : out std_logic_vector(31 downto 0));
    end component mux_top;

begin

    -- Clock driver
    sysclk <= not sysclk after (SYSCLK_PERIOD / 2.0);


    -- Here we create the stimulus (select signal)
    -- The data inputs in this case are constant
    stimulus_p: process
    begin
        -- after 10 clock cycles deassert reset
        wait for ( SYSCLK_PERIOD * 10 );
        n_Reset <= '1';
        
        wait for 1 us; -- this is just unconditional wait for a specified amount of time
        S_int <= "00"; --set S to "00" 
        wait for 1 us;
        S_int <= "01"; --set S to "01"       
        wait for 1 us;
        S_int <= "10"; --set S to "10"
        wait for 1 us;
        S_int <= "11"; --set S to "11"
 
        wait; -- wait here forever
    
    end process;

    -- Then, instantiate the DUT (Design Under Test)
    i_DUT: mux_top
        port map (
            sysclk => sysclk,
            n_Reset => n_Reset,
            E => E_int, F => F_int, G => G_int, H => H_int,
            X => X_int, Y => Y_int, Z => Z_int, W => W_int,
            S => S_int,
            Q => Q_int, Q_wide => Q_wide_int
        );
end Behavioral;  
