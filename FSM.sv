module FSM (input logic clk, Reset, left, right, hazard, brake,
				output logic LA,LB,LC,RA,RB,RC);
logic [2:0]state;
logic [2:0]nextstate;

always_ff @ (posedge clk, posedge Reset)
		 if(Reset) state <= 0;
		 else 	  state <= nextstate;
		 
always_comb begin
		 case(state) 
		 
		 3'b000 : begin //s0
		 if (left ==1'b1) nextstate = 3'b001;
		 else if (right==1'b1) nextstate = 3'b100;
		 else if (brake== 1'b1) nextstate = 3'b111;
		 else if (hazard== 1'b1) nextstate = 3'b111;
		 else	nextstate = 3'b000;
		 end
		 
		 3'b001 : begin //s1
		 if (left ==1'b1) nextstate = 3'b010;
		 else	nextstate = 3'b000;
		 end
		 
		 3'b010 : begin //s2
		 if (left == 1'b1) nextstate = 3'b011;
		 else nextstate = 3'b000;
		 end
		 
		 3'b011 : begin //s3
		 if (left == 1'b1) nextstate = 3'b000;
		 else nextstate = 3'b000;
		 end
		 
		 3'b100 : begin //s4
		 if (right == 1'b1) nextstate = 3'b101;
		 else nextstate = 3'b000;
		 end
		 
		 3'b101 : begin //s5
		 if (right == 1'b1) nextstate = 3'b110;
		 else nextstate = 3'b000;
		 end
		 
		 3'b110 : begin //s6
		 if (right == 1'b1) nextstate = 3'b000;
		 else nextstate = 3'b000;
		 end
		 
		 3'b111 : begin //s7
		 if (brake == 1'b1) nextstate = 3'b111;
		 else if (hazard == 1'b1) nextstate = 3'b000;
		 else nextstate = 3'b000;
		 end
		 
		 endcase
		 end
		 
always_comb begin
		 case(state) 
		 
		 3'b000 : {LA,LB,LC,RA,RB,RC}= 6'b000000;
		 
		 3'b001 : {LA,LB,LC,RA,RB,RC}= 6'b100000;
		 
		 3'b010 : {LA,LB,LC,RA,RB,RC}= 6'b110000;
		 
		 3'b011 : {LA,LB,LC,RA,RB,RC}= 6'b111000;
		 
		 3'b100 : {LA,LB,LC,RA,RB,RC}= 6'b000100;
		 
		 3'b101 : {LA,LB,LC,RA,RB,RC}= 6'b000110;
		 
		 3'b110 : {LA,LB,LC,RA,RB,RC}= 6'b000111;
		 
		 3'b111 : {LA,LB,LC,RA,RB,RC}= 6'b111111;
		 
		 endcase
		 end

endmodule
