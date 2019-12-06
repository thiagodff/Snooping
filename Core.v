module processor(Resetn, Run, Din, Done, Clock, req, CDB, dataWB, abortMem, dataMem, Q);
input Resetn, Run;
input Clock;
input [21:0] req;
input [15:0]Din;
output reg Done;
output reg [21:0] CDB; //Common Data Bus
wire [1:0] Inst; //01 -> read | 10 -> write
output reg [1:0]Q;
input [1:0] dataMem;

reg [21:0] request;// enviar ao CDB
reg[1:0] stateB0, stateB1;
reg listenB0, listenB1;
output dataWB, abortMem;
wire[1:0] newStateB0, newStateB1;

reg read, write, writeHit, readHit;
reg [1:0]dataWr;

initial
begin
  stateB0 = 2'b00;
  stateB1 = 2'b00;
  listenB0 = 1;
  listenB1 = 1;
  request = 22'b0000000000000000000000;
end

StateMachine B0(Clock, stateB0, request, listenB0, newStateB0, CDB, dataWB, abortMem);
StateMachine B1(Clock, stateB1, request, listenB1, newStateB1, CDB, dataWB, abortMem);

cache L1(Clock, listenB0, listenB1, read, write, writeHit, readHit, dataMem, dataWr, tag, Q);

assign Inst = Din[1:0];

always@(posedge Clock)
begin
  request = req;
  stateB0 <= newStateB0;
  stateB1 <= newStateB1;
  listenB0 = 1;
  listenB1 = 1;
  
  if (Run == 1)
  begin
    read = 0;
    case(Inst)
    2'b01: // read
    begin
      read = 1;
      request = {4'b1000, readHit, 1'b1, 16'b0000000000000000};
    end
    2'b10:
    begin
      write = 1;
      dataWr = Din[6:5];
      request = {4'b1000, writeHit, 1'b0, 16'b0000000000000000};
    end
    endcase
  end
  
end
  
endmodule