module ALU_32_bits (
	input logic [31:0] A,B,
	input logic [3:0] ALU_Op,
	output logic [31:0] Result,
	output logic [3:0] ALUFlags
);
	//logic [32:0] Sum;
	//logic V,C,Z,N;
	
	always_comb begin
	case(ALU_Op)
		32'b0000: begin           
	   Result = A & B;
		ALUFlags[3] = Result[31];
	   ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[1] = 0;
		ALUFlags[0] = 32'bx;
		end	
		
		32'b0001: begin	   
		Result = A | B; //OR
		ALUFlags[3] = Result[31];
		ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[1] = 0;
		ALUFlags[0] = 32'bx;
		end
		
		32'b0010: begin	   
		Result = A ^ B; //XOR
		ALUFlags[3] = Result[31];
		ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[1] = 0;
		ALUFlags[0] = 32'bx;
		end 
		
		32'b0011: begin	   
		Result = A + B; //ADD
		ALUFlags[3] = Result[31];
		ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[0] = (ALU_Op[1] == 1'b0) & ~(A[31] ^ B[31] ^ ALU_Op[0]) & (A[31] ^ Result[31]);
	   ALUFlags[1] = (ALU_Op[1] == 1'b0) & Result[31];
		end 
		
		32'b0100: begin	   
		Result = A << B[4:0]; //Logical shift left
		ALUFlags[3] = Result[31];
		ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[1] = Result[31];
		ALUFlags[0] = 32'bx;
		end  
		
		32'b0101:begin	   
		Result = A >> B[4:0]; //Logical shift right
		ALUFlags[3] = Result[31];
		ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[1] = Result[0]; 
		ALUFlags[0] = 32'bx;
		end  
		
		32'b0110:begin	   
		Result = A >>> B[4:0]; //Arithmetic shift right
		ALUFlags[3] = Result[31];
		ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[1] = Result[0];
		ALUFlags[0] = 32'bx;	
		end  
		
		32'b0111:begin	   
		Result = A << (32-B[4:0] | A >> B[4:0]); //Rotate right
		ALUFlags[3] = Result[31];
		ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[1] = Result[0]; 
		ALUFlags[0] = 32'bx;
		end
		
		32'b1011: begin	   
		Result = A + ~B + 1; //Subtract
		ALUFlags[3] = Result[31];
		ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[0] = (ALU_Op[1] == 1'b0) & ~(A[31] ^ B[31] ^ ALU_Op[0]) & (A[31] ^ Result[31]);
	   ALUFlags[1] = (ALU_Op[1] == 1'b0) & Result[31];
		end 
		
		32'b1100: begin           
	   Result = A & ~B; //Bit clear
		ALUFlags[3] = Result[31];
	   ALUFlags[2] = (Result == 32'b0000);
		ALUFlags[1] = 0;
		ALUFlags[0] = 32'bx;
		end 

		default: begin
		Result = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; //Undefined
		ALUFlags[3] = 1'bx;
	   ALUFlags[2] = 1'bx;
		ALUFlags[1] = 1'bx;
		ALUFlags[0] = 1'bx;
		end
	endcase

	//assign B_finals = ALU_Op[3] ? ~B : B;
	//assign Sum = A + B_finals + ALU_Op[3];
	
	//assign ALUFlags = {V,C,Z,N};
	//assign V = (ALU_Op[1] == 1'b0) & ~(A[31] ^ B[31] ^ ALU_Op[0]) & (A[31] ^ Sum[31]);
	//assign C = (ALU_Op[1] == 1'b0) & Sum[32];
	//assign Z = (Result == 32'b0000);
	//assign N = Result[31];
end
endmodule
		