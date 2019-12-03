module processor(Resetn, Run, Din, Done, Clock, CDB);
  input Resetn, Run;
	input Clock;
	input [15:0]Din;
	output reg Done;
  output reg [21:0] CDB; //Common Data Bus
  wire [1:0] Inst; //01 -> read | 10 -> write
  
  Mem L1();
  
  assign Inst = [1:0]Din;
  
  always@(posedge Clock)
  begin
    
    if (Run == 1)
    begin
      case(Inst)
      2'b01:
      begin
        //read
      end
      2'b10:
      begin
        //write
      end
    end
    
  end
  
endmodule