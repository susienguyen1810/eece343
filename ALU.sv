module ALU (
	input logic [31:0] A,B,
	input logic [3:0] ALUControl,
	output logic [31:0] ALUResult,
	output logic [3:0] ALUFlags
	//output logic [3:0] ALUFlagOut
);

logic [31:0] rd, Result,SrcA, SrcB ;
logic MemtoReg;
	 muxxx memtoregmux(.d0(rd), .d1(ALUResult), .s(MemtoReg), .y(Result));
 //   rc_adder adder1(.a(SrcA), .b(SrcB), .cin(ALUControl[0]), .sum(ALUResult), .cout(cout));
	 
	always_comb begin
	case(ALUControl)
		4'b0000: begin           
	   ALUResult = A & B;
		ALUFlags[3] = ALUResult[31];
	   ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[1] = 0;
		ALUFlags[0] = 1'bx;
		end	
		
		4'b0001: begin	   
		ALUResult = A | B; //OR
		ALUFlags[3] = ALUResult[31];
		ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[1] = 0;
		ALUFlags[0] = 1'bx;
		end
		
		4'b0010: begin	   
		ALUResult = A ^ B; //XOR
		ALUFlags[3] = ALUResult[31];
		ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[1] = 0;
		ALUFlags[0] = 1'bx;
		end 
		
		4'b0011: begin	   
		{ALUFlags[1],ALUResult} = A + B; //ADD
		ALUFlags[3] = ALUResult[31];
		ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[0] = ((ALUResult[31] != A[31]) && (A[31] == B[31]));
	 //  ALUFlags[1] = (ALUControl[1] == 1'b0) & ALUResult[31];
		end 
		
		4'b0100: begin	   
		ALUResult = A << B[4:0]; //Logical shift left
		ALUFlags[3] = ALUResult[31];
		ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[1] = ALUResult[31];
		ALUFlags[0] = 1'bx;
		end  
		
		4'b0101:begin	   
		ALUResult = A >> B[4:0]; //Logical shift right
		ALUFlags[3] = ALUResult[31];
		ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[1] = ALUResult[0]; 
		ALUFlags[0] = 1'bx;
		end  
		
		4'b0110:begin	   
		ALUResult = A >>> B[4:0]; //Arithmetic shift right
		ALUFlags[3] = ALUResult[31];
		ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[1] = ALUResult[0];
		ALUFlags[0] = 1'bx;	
		end  
		
		4'b0111:begin	   
		ALUResult = A << (32-B[4:0] | A >> B[4:0]); //Rotate right
		ALUFlags[3] = ALUResult[31];
		ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[1] = ALUResult[0]; 
		ALUFlags[0] = 1'bx;
		end
		
		4'b1011: begin	   
		ALUResult = A + ~B + 1; //Subtract
		ALUFlags[3] = ALUResult[31];
		ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[0] = (ALUControl[1] == 1'b0) & ~(A[31] ^ B[31] ^ ALUControl[0]) & (A[31] ^ ALUResult[31]);
	   ALUFlags[1] = (ALUControl[1] == 1'b0) & ALUResult[31];
		end 
		
		4'b1100: begin           
	   ALUResult = A & ~B; //Bit clear
		ALUFlags[3] = ALUResult[31];
	   ALUFlags[2] = (ALUResult == 32'b0000);
		ALUFlags[1] = 0;
		ALUFlags[0] = 1'bx;
		end 

		default: begin
		ALUResult = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; //Undefined
		ALUFlags[3] = 1'bx;
	   ALUFlags[2] = 1'bx;
		ALUFlags[1] = 1'bx;
		ALUFlags[0] = 1'bx;
		end
	endcase

end
endmodule





