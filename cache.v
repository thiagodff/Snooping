module cache(Clock, listenB0, listenB1, read, write, writeHit, readHit, dataMem, dataWr, tag, Q);
  input Clock, read, write;
  output reg writeHit, readHit;
  input [1:0] dataMem, dataWr;
  input [1:0] tag;
  output reg [1:0] Q;
  output reg listenB0, listenB1;

  reg [1:0]mem[1:0];//memoria cache
  reg[1:0] B0, B1;

  initial
  begin//valores iniciais da memoria
    mem[0] = 2'b00;
    mem[1] = 2'b10;
    B0 = 2'b00;
    B1 = 2'b10;
  end

  always@(posedge Clock)
  begin
    if (read == 1)
    begin
      if (tag == B0 || tag == B1) // se a tag estiver na cache, readHit
      begin
        readHit = 1;
        if (tag == B0) // joga para saida o valor da tag
        begin
          listenB0 = 0;
          Q = mem[0];
        end
        else // joga para saida o valor da tag
        begin
          listenB1 = 0;
          Q = mem[1];
        end
      end
      else
      begin
        readHit = 0;
        if (tag == 2'b00 || tag == 2'b01) // como a tag nao esta na cache, busca na mem e mapeia para posicao correta
        begin
          listenB0 = 0;
          B0 = tag;
          mem[0] = dataMem;
          Q = mem[0];
        end
        else
        begin
          listenB1 = 0;
          B1 = tag;
          mem[1] = dataMem;
          Q = mem[1];
        end
      end
    end

  if (write == 1)
  begin
    if (tag == B0 || tag == B1)
    begin
      writeHit = 1;
      if (tag == B0) // verifica em qual posicao vai colocar o dado
      begin
        listenB0 = 0;
        mem[0] = dataWr;
      end
      else
      begin
        listenB1 = 0;
        mem[1] = dataWr;
      end
    end
    else
    begin
      writeHit = 0;
      if (tag == 2'b00 || tag == 2'b01) // como a tag nao esta na cache, olha aposicao para colocar
      begin
        listenB0 = 0;
        B0 = tag;
        mem[0] = dataWr;
      end
      else
      begin
        listenB1 = 0;
        B1 = tag;
        mem[1] = dataWr;
      end
    end
  end
  end

endmodule
