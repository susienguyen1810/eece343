module Integrator (input logic Start, Clk, Reset, 
						output logic [15:0] SUM, 
						output logic Done);
						
logic [3:0]state;
logic [3:0]nextstate;
logic [15:0] sum;

assign SUM = ( Done == 1) ? sum : 16'hxx;


// insert your code here, 
// do not change any ports specifications. You are not required to write a testbench for this design. 

always_ff @ (posedge Clk, posedge Reset)
		 if(Reset) state <= 0;
		 else 	  state <= nextstate;
		 
reg[6:0] ROM[0:7];

initial begin
ROM[0] = 7'b0000010; //2
ROM[1] = 7'b0000011; //3
ROM[2] = 7'b0000101; //5
ROM[3] = 7'b0000111; //7
ROM[4] = 7'b0001011; //11
ROM[5] = 7'b0001101; //13
ROM[6] = 7'b0010001; //17
ROM[7] = 7'b0010011; //19
end

always_comb begin
		 case(state) 
		 4'b0000 : begin //s0
		 sum = 0;
		 Done = 0;
		 if (Start ==1'b1) nextstate = 4'b0001;
		 else	nextstate = 4'b0000;
		 end
		 
		 4'b0001 : begin //s1
		 sum = ROM[0];
		 Done = 0;
		 nextstate = 4'b0010;
		 end
	
		 4'b0010 : begin //s2
		 sum = ROM[0] + ROM[1];
		 Done = 0;
		 nextstate = 4'b0011;
		 end
		 
		 4'b0011 : begin //s3
		 sum = ROM[0] + ROM[1] + ROM[2];
		 Done = 0;
		 nextstate = 4'b0100;
		 end
		 
		 4'b0100 : begin //s4
		 sum = ROM[0] + ROM[1] + ROM[2] + ROM[3];
		 Done = 0;
		 nextstate = 4'b0101;
		 end
	
		 4'b0101 : begin //s5
		 sum = ROM[0] + ROM[1] + ROM[2] + ROM[3] + ROM[4];
		 Done = 0;
		 nextstate = 4'b0110;
		 end
	
		 4'b0110 : begin //s6
		 sum = ROM[0] + ROM[1] + ROM[2] + ROM[3] + ROM[4] + ROM[5];
		 Done = 0;
		 nextstate = 4'b0111;
		 end
		 
		 4'b0111 : begin //s7
		 sum = ROM[0] + ROM[1] + ROM[2] + ROM[3] + ROM[4] + ROM[5] + ROM[6];
		 Done = 0;
		 nextstate = 4'b1000;
		 end
		 
		 4'b1000 : begin //s8
		 sum = ROM[0] + ROM[1] + ROM[2] + ROM[3] + ROM[4] + ROM[5] + ROM[6] + ROM[7];
		 Done = 1;
		 nextstate = 4'b0000;
		 end
		 default: begin
		 nextstate=4'b0000;
		 sum = 0;
		 Done = 0;
		 end
		 
		 endcase
		 end


		 
endmodule 
 