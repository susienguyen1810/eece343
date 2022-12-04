module topmodule(input logic clk, reset, WE, MemtoReg, 
					  input logic [2:0] ALUControl, 
			        output logic [10:0] ToControler,
					  output logic [3:0] Flags
					  );

logic PCSrc,ALUScr,RegWrite;
logic [1:0] RegSrc, ImmScr;
					  
activity9 ifstage (
		.clk(clk),
		.PCSrc (PCSrc),
		.reset(reset),
		.PCPLUS4(PCPlus4),
		.instructionoutput(Instr)
		);
		
activity10 idstage (
		.clk(clk),
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
		
ALU myALU(.ALUControl(ALUControl),
			.ALUResult(ALUResult),
			.A(SrcA),
			.B(SrcB),
			.ALUFlags(ALUFlags)
			);
		
flipflopalu flipflopalu(
			.d(ALUFlags),
			.q(Flags),
			.clk(clk)
			);
			
datamemory datamemory(
			.clk(clk),
			.a(ALUResult),
			.wd(WriteData),
			.rd(rd),
			.WE(WE)
			);
			
muxxx muxx(
		.PCPlus4(ALUResult),
		.BranchAdd(rd),
		.PCSrc(MemtoReg)
		);
			
endmodule 
