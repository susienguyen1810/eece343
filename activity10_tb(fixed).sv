module activity10_tb();

			 
			 logic clk, reset;
			 logic [31:0] Instr;
			 logic [31:0] PCPlus4;
		    logic [1:0] RegSrc,ImmScr; 
			 logic RegWrite,ALUScr;
			 logic [31:0] SrcA;
			 logic [31:0] SrcB;
			 logic [31:0] WriteData;
			 logic [10:0] ToControler;
			 logic [31:0] Result;
	// Device under test
	activity10 dut(
		.clk(clk),
		//.PCSrc(PCSrc),
		.reset(reset),
		.Instr(Instr),
		.Result(Result),
		.SrcA(SrcA),
		.SrcB(SrcB),
		.RegSrc(RegSrc),
		.RegWrite(RegWrite),
		.ALUScr(ALUScr),
		.ImmScr(ImmScr),
		.WriteData(WriteData),
		.PCPlus4(PCPlus4),
		.ToControler(ToControler)
	);
	
always #5 clk=~clk;
  
  initial 
    begin
  clk=0; 
  RegSrc = 2'b00;
  RegWrite = 1;
  ALUScr = 0;
  ImmScr = 2'b00;
  Result=32'd0;
  PCPlus4=32'd4;
  Instr=32'he3a02005;
  #50 $stop;
    end


//initial begin
//  #5 reset=0;
//  #5 RegSrc = 0;
//  #5 RegWrite = 1;
//  #5 ALUScr = 1;
//  #5 ImmScr = 2'b00;
//
//
//#100 $stop;


//end 

endmodule 
