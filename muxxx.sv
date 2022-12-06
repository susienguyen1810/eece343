//Multiplexer determine what address to use for PC
module muxxx #(parameter DATA_WIDTH = 32)
				 (input logic [DATA_WIDTH-1:0]d0, //in0
				  input logic [DATA_WIDTH-1:0]d1,  //in1
				  input logic s, 									//select
				  output logic[DATA_WIDTH-1:0]y);
	//if load is 1 branch address
	//if load is 0 PCPlus4
	always_comb begin	
		case(s)
	//enable is 0, we aren't adding value doesn't go through adder does
		1'b0: y = d0;
	
	//enable is 1, we are using the multiplexer, value does go through
		1'b1: y = d1;
		endcase
	end
endmodule
