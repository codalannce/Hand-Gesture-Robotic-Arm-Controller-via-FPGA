

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AngleMapping is
  Port (
    raw_angle: in signed(7 downto 0); -- (-128,128) => -90, 90
    servo_angle:   out unsigned(7 downto 0) -- (0, 256) => 0, 180
  
  );
end AngleMapping;

architecture Behavioral of AngleMapping is
begin

process(raw_angle)
     variable a : integer range -128 to 127;
begin
    a := to_integer(raw_angle);

    if a < -90 then
        servo_angle <= to_unsigned(0, 8);
    elsif a > 90 then
        servo_angle <= to_unsigned(180, 8);
    else
        servo_angle <= to_unsigned(a + 90, 8);
    end if;
end process;

end Behavioral;
