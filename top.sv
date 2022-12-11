module top(input logic clk, reset,
			  output logic MemWrite, 
			  output logic [31:0] WriteData, 
			                      rd, 
										 ALUResult);
										 
logic PCSrc, 
	   MemtoReg,
	   ALUSrc,
		RegWrite;
		
logic [1:0] RegSrc, ImmSrc;
logic [3:0] ALUControl;
logic [3:0] ALUFlagOut;
logic [3:0] Cond;
logic [1:0] Op;
logic [5:0] Funct;

logic [31:0] Result2RF;
logic [31:0] PC, Instr,SrcA, SrcB,PCPLUS4;
logic [3:0] ALUFlags;

logic [11:0] ToControler;

assign dataout=ALUResult;
assign Cond = ToControler[11:8]; 
assign Op = ToControler[7:6];
assign Funct = ToControler[5:0];
			
			
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
		.ALUSrc(ALUSrc),
		.ImmSrc(ImmSrc),
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
			.e(ALUFlags),
			.f(ALUFlagOut),
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

controller myController(.Cond(Cond),
								.Op(Op),
								.Funct(Funct),
								.ALUFlagOut(ALUFlagOut),
								.PCSrc(PCSrc), 
								.MemtoReg(MemtoReg),
								.WE(MemWrite),
								.ALUSrc(ALUSrc),
								.RegWrite(RegWrite),
								.RegSrc(RegSrc),
								.ImmSrc(ImmSrc),
								.ALUControl(ALUControl)
								);
endmodule
