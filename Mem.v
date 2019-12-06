module Mem(Clock, tag, data, writeEn, Q);
  input Clock, writeEn;
  input [1:0] tag;
  input [1:0] data;
  output reg [1:0]Q;
  reg [1:0]mem[1:0];//memoria compartilhada

  initial
	begin//valores iniciais da memoria
		mem[0] = 2'b00;
		mem[1] = 2'b01;
		mem[2] = 2'b10;
		mem[3] = 2'b11;
	end

  always@(posedge Clock)
  begin
    if (writeEn == 0)
    begin
      Q = mem[tag];
    end
    else
    begin
      mem[tag] = data;
    end
  end

endmodule
