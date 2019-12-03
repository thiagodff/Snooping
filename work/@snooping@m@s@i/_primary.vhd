library verilog;
use verilog.vl_types.all;
entity SnoopingMSI is
    port(
        clock           : in     vl_logic;
        request         : in     vl_logic_vector(21 downto 0);
        listen          : in     vl_logic;
        dataWB          : out    vl_logic;
        abortMem        : out    vl_logic;
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0);
        HEX4            : out    vl_logic_vector(6 downto 0);
        HEX5            : out    vl_logic_vector(6 downto 0);
        HEX6            : out    vl_logic_vector(6 downto 0);
        HEX7            : out    vl_logic_vector(6 downto 0)
    );
end SnoopingMSI;
