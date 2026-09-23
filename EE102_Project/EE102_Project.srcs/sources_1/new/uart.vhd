
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity uart is
    
    generic (
    clk_freq    : integer := 100_000_000;
    baud_rate   : integer := 9600
    );
    
    Port ( 
    clk : in std_logic;
    rx  : in std_logic;
    data: out std_logic_vector(7 downto 0);
    rx_stop: out std_logic
    );
    
end uart;

architecture Behavioral of uart is

type states is (S_IDLE, S_START, S_DATA, S_STOP);
signal state : states := S_IDLE;

constant period : integer:= clk_freq/baud_rate;

signal counter: integer range 0 to period;
signal bit_counter: integer range 0 to 7;
signal regist: std_logic_vector (7 downto 0);


begin
    process(clk) begin
        if (rising_edge(clk)) then
        
            case state is
            
                when S_IDLE =>
                    rx_stop <= '0';
                    if (rx = '0') then
                        state <= S_START;
                    end if;
                    
                when S_START =>
                    if counter = period/2 -1 then
                        state <= S_DATA;
                        counter <= 0;
                    else
                        counter <= counter + 1;
                    end if;
                when S_DATA =>
                    
                    if (counter = period -1) then
                        if (bit_counter = 7) then
                            state <= S_STOP;
                            bit_counter <= 0;
                        else
                            bit_counter <= bit_counter + 1;
                        end if;
                        
                        regist(bit_counter) <= rx;
                        counter <= 0;
                    else
                        counter <= counter + 1;
                    end if;
                 when S_STOP =>
                     if (counter = period -1) then
                        state <= S_IDLE;
                        counter <= 0;
                        rx_stop <= '1';
                    else
                        counter <= counter + 1;
                    end if;                    
              end case;
        end if;
  end process;
  
  data <= regist;
end Behavioral;
