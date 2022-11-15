module activity9 #(
			 parameter DATA_WIDTH = 32)
			 (output logic [DATA_WIDTH-1:0] instructionoutput, 
			 input logic [DATA_WIDTH-1:0] BranchAdd,
			 //output logic [DATA_WIDTH-1:0] PCPLUS4,
			 input clk, reset,
			 input logic PCSrc,
			 
			 input logic [10:0] Instr,
			 input logic [31:0] PCPlus4,
		    input logic [1:0] RegSrc, RegWrite, ImmScr, ALUScr,ImmSrc,
			 input logic WE3,
			 output logic [31:0] SrcA,
			 output logic [31:0] SrcB,
			 output logic [31:0] WriteData,
			 output logic [31:0] RD2
			 );
			 
			 logic [31:0] RD,Extlmm,WD3;
			 logic [3:0] RA1,RA2,WA3;
			 logic [DATA_WIDTH-1:0] wPC,wA;
			 logic [31:0] PCPLUS4, PCPLUS8,R15;
			 logic [31:0] Result;
			 
			 //implement modules
			 ff    pc(.clk(clk),.PC(wPC), .A(wA), .reset(reset));
			 adder PC4Adder(.A(wA), .B(32'd4), .PCPlus4(PCPLUS4));
			 adder PC8Adder(.A(PCPLUS4), .B(32'd4), .PCPlus4(PCPLUS8));
	       muxx plexi(.PCPlus4(PCPLUS4), .BranchAdd(BranchAdd), .PCSrc(PCSrc), .PC(wPC));
			 Instruction ROM(.RD(instructionoutput),.A(wA));
			 muxx #(4)  mux1(.PCPlus4(RD[19:16]), .BranchAdd(4'b1111), .PCSrc(RegSrc[0]), .PC(RA1));	
			 muxx #(4)  mux2(.PCPlus4(RD[3:0]), .BranchAdd(RD[15:12]), .PCSrc(RegSrc[1]), .PC(RA2));
			 muxx ALUmux(.PCPlus4(RD2), .BranchAdd(Extlmm), .PCSrc(ALUSrc), .PC(SrcB));
			 registerfile Reg(.clk(clk), .WE3(WE3), .RA1(RA1), .RA2(RA2), .WA3(RD[15:12]), .WD3(Result), .R15(PCPLUS8), .RD1(SrcA), .RD2(RD2));
			 extend myextend(.Instr(RD[23:0]), .ImmSrc(ImmSrc), .Extlmm(Extlmm));
endmodule 
//Multiplexer determine what address to use for PC
module muxx #(parameter DATA_WIDTH = 32)
				 (input logic [DATA_WIDTH-1:0]PCPlus4,
				  input logic [DATA_WIDTH-1:0]BranchAdd,
				  input logic  PCSrc, 
				  output logic[DATA_WIDTH-1:0]PC);
	//if load is 1 branch address
	//if load is 0 PCPlus4
	always_comb begin	
		case(PCSrc)
	//enable is 0, we aren't adding value doesn't go through adder does
		1'b0: PC = PCPlus4;
	
	//enable is 1, we are using the multiplexer, value does go through
		1'b1: PC = BranchAdd;
		endcase
	end
endmodule

//Flip flop
module ff   (input logic clk, reset,
				 input logic [31:0] PC,
				 output logic[31:0] A);
				 
	always_ff @(posedge clk)
			A <= PC; 
endmodule

//Adder
module adder #(parameter DATA_WIDTH = 32)
				 (input logic [DATA_WIDTH-1:0] A, B,
				  output logic[DATA_WIDTH-1:0] PCPlus4);
	// takes padded value and sum, adds them to data
	assign PCPlus4 = A + B;
	
//	//passes data to the multiplexer
//	PCPLUS4 <= PCPlus4;
endmodule

//Instruction Memory
module Instruction (input logic [31:0] A,
						  output logic [31:0] RD);
						  
		logic [31:0] ROM[0:15];

initial begin
ROM[0]  = 32'b00000000000000000000000000000000;
ROM[1]  = 32'b11100011101000000010000000000101; //MOV R2,#5
ROM[2]  = 32'b11100011101000000011000000000100; //MOV R3, #4
ROM[3]  = 32'b11100000100000100100000000000011; //ADD R4,R2,R3
ROM[4]  = 32'b00000000000000000000000000000000; 
ROM[5]  = 32'b00000000000000000000000000000000;
ROM[6]  = 32'b00000000000000000000000000000000;
ROM[7]  = 32'b00000000000000000000000000000000;
ROM[8]  = 32'b00000000000000000000000000000000;
ROM[9]  = 32'b00000000000000000000000000000000;
ROM[10] = 32'b00000000000000000000000000000000;
ROM[11] = 32'b00000000000000000000000000000000;
ROM[12] = 32'b00000000000000000000000000000000;
ROM[13] = 32'b00000000000000000000000000000000;
ROM[14] = 32'b00000000000000000000000000000000;
ROM[15] = 32'b00000000000000000000000000000000;
end

assign RD = ROM[A[5:2]];
//always_ff @(posedge clk)
//			PCPlus4 <= A; 
endmodule
