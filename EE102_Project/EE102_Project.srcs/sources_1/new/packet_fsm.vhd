library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity packet_fsm is
  Port (
    clk       : in  std_logic;
    rx_valid  : in  std_logic;
    rx_data   : in  std_logic_vector(7 downto 0);

    servo_pitch_angle : out std_logic_vector(7 downto 0);
    servo_yaw_angle   : out std_logic_vector(7 downto 0);
    servo_roll_angle  : out std_logic_vector(7 downto 0)
  );
end packet_fsm;

architecture Behavioral of packet_fsm is

  type state_type is (WAIT_HDR, GET_PITCH, GET_YAW, GET_ROLL, GET_CHK);
  signal state : state_type := WAIT_HDR;
  signal p_reg, y_reg, r_reg : std_logic_vector(7 downto 0);
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rx_valid = '1' then
        case state is

          when WAIT_HDR =>
            if rx_data = x"A5" then
              state <= GET_PITCH;
            end if;

        
          when GET_PITCH =>
            p_reg <= rx_data;
            state <= GET_YAW;

       
          when GET_YAW =>
            y_reg <= rx_data;
            state <= GET_ROLL;

      
          when GET_ROLL =>
            r_reg <= rx_data;
            state <= GET_CHK;
            
          when GET_CHK =>
            if rx_data = (p_reg xor y_reg xor r_reg) then --check
              servo_pitch_angle <= p_reg;
              servo_yaw_angle   <= y_reg;
              servo_roll_angle  <= r_reg;
            end if;
            state <= WAIT_HDR;

        end case;
      end if;
    end if;
  end process;

end Behavioral;
