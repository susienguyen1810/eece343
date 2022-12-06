module registerfile ( input logic clk,
							  input logic RegWrite,
							  input logic [3:0] RA1, RA2, WA3,
							  input logic [31:0] WD3, R15,
							  output logic [31:0] RD1,RD2);
							  
							  
	logic [31:0] rf[14:0];
	
	always_ff @(posedge clk)
	if (RegWrite) rf[WA3] <= WD3;
	
  assign RD1 = (RA1 == 4'b1111) ? R15 : rf[RA1];
  assign RD2 = (RA2 == 4'b1111) ? R15 : rf[RA2];
	
endmodule


							  
							  
							  