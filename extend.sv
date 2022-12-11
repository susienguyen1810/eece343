module extend (input logic [1:0] ImmSrc,
					input logic [23:0] Instr,
					output logic [31:0] Extlmm);
					
	always_comb 
	case (ImmSrc)
	2'b00: Extlmm = {24'b0, Instr[7:0]};
	2'b01: Extlmm = {20'b0, Instr[11:0]};
	2'b10: Extlmm = {{6{Instr[23]}}, Instr[23:0], 2'b00};
	default: Extlmm = 32'bx;
	
	endcase
endmodule 