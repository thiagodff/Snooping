library verilog;
use verilog.vl_types.all;
entity StateMachine is
    port(
        clock           : in     vl_logic;
        state           : in     vl_logic_vector(1 downto 0);
        cdb             : in     vl_logic_vector(21 downto 0);
        listen          : in     vl_logic;
        newState        : out    vl_logic_vector(1 downto 0);
        emit            : out    vl_logic_vector(21 downto 0);
        dataWB          : out    vl_logic;
        abortMem        : out    vl_logic
    );
end StateMachine;
