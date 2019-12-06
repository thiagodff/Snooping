module SnoopingMSI(Clock, Resetn, Run, Din);
input Clock;
input Resetn, Run;
input[15:0] Din;// enviar ao CDB
reg Done;
reg[1:0] state;
wire dataWB, abortMem;
wire[1:0] newState;
wire[21:0] CDB;
wire [1:0] dataMen;


Core core1(Resetn, Run, Din, Done, Clock, CDB, CDB, dataWB, abortMem, dataMem, dataOut);
Core core2(Resetn, Run, Din, Done, Clock, CDB, CDB, dataWB, abortMem, dataMem, dataOut);
Core core3(Resetn, Run, Din, Done, Clock, CDB, CDB, dataWB, abortMem, dataMem, dataOut);

Mem compMem(Clock, Din[4:3], dataOut, dataWB && ~abortMem, dataMem);


endmodule