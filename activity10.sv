module activity10 #(
			 parameter DATA_WIDTH = 32)
			 
			 (input clk, reset,
			 input logic [31:0] Instr,
		    input logic [1:0] RegSrc, ImmSrc,
			 input logic RegWrite,  ALUSrc,
			 output logic [31:0] SrcA,
			 output logic [31:0] SrcB,
			 output logic [31:0] WriteData,
			 output logic [11:0] ToControler,
			 input logic [31:0] Result,
			 input logic [31:0] PCPLUS4
			 ); 
			 
			 logic [31:0] Extlmm;
			 logic [3:0] RA1,RA2,WA3;

			 logic [31:0] PCPLUS8;
			 
			 logic [DATA_WIDTH-1:0] instructionoutput;
			 logic PCSrc;
			 
			 assign ToControler=Instr[31:20];
			 
			 //implement modules
			 adder PC8Adder(.A(32'd4), .B(PCPLUS4), .C(PCPLUS8));
			 muxxx #(4)  mux1(.d0(Instr[19:16]), .d1(4'b1111), .s(RegSrc[0]), .y(RA1));	
			 muxxx #(4)  mux2(.d0(Instr[3:0]), .d1(Instr[15:12]), .s(RegSrc[1]), .y(RA2));
			 muxxx ALUmux(.d0(WriteData), .d1(Extlmm), .s(ALUSrc), .y(SrcB));
			 
			 registerfile Reg(.clk(clk), .RegWrite(RegWrite), .RA1(RA1), .RA2(RA2), .WA3(Instr[15:12]), .WD3(Result), .R15(PCPLUS8), .RD1(SrcA), .RD2(WriteData));
			 
			 extend myextend(.Instr(Instr[23:0]), .ImmSrc(ImmSrc), .Extlmm(Extlmm));
endmodule 

