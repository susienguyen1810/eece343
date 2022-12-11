module topmodule(input logic clk, reset, MemWrite, MemtoReg, 
					  input logic [3:0] ALUControl, 
					  input logic PCSrc,ALUScr,RegWrite,
					  input logic [1:0] RegSrc,ImmScr,
					  output logic [11:0] ToControler,
					  output logic [3:0] Flags, 
					  output logic [31:0] dataout
					  );

logic [31:0] Result2RF;
logic [31:0] PC, Instr,SrcA, SrcB, WriteData, ALUResult, rd,PCPLUS4 ;
logic [3:0] ALUFlags;

assign dataout=ALUResult;
			
			
activity9 ifstage (
		.clk(clk),
		.PCSrc (PCSrc),
		.reset(reset),
		.instructionoutput(Instr),
		.BranchAdd(Result2RF),
		.PCPLUS4(PCPLUS4)
		);

activity10 idstage (
		.clk(clk),
		.reset(reset),
		.Instr(Instr),
		.Result(Result2RF),
		.SrcA(SrcA),
		.SrcB(SrcB),
		.RegSrc(RegSrc),
		.RegWrite(RegWrite),
		.ALUScr(ALUScr),
		.ImmScr(ImmScr),
		.WriteData(WriteData),
		.ToControler(ToControler),
		.PCPLUS4(PCPLUS4)
	   );
		
ALU myALU(.ALUControl(ALUControl),
			.ALUResult(ALUResult),
			.A(SrcA),
			.B(SrcB),
			.ALUFlags(ALUFlags)
			);
		
flipflopalu flipflopalu(
			.d(ALUFlags),
			.q(Flags),
			.clk(clk),
			.reset(reset)
			);
			
datamemory datamemory(
			.clk(clk),
			.a(ALUResult),
			.wd(WriteData),
			.rd(rd),
			.WE(MemWrite)
			);
			
muxxx ToReg(
		.d0(ALUResult),
		.d1(rd),
		.s(MemtoReg),
	   .y(Result2RF)
		);
			
endmodule 