module testbench();

  logic        clk;
  logic        reset;
  logic 			MemWrite;
  logic [31:0] WriteData, ReadData, ALUResult;
  //logic        MemWrite;

  // instantiate device to be tested
  top dut(clk, reset, MemWrite, WriteData, ReadData, ALUResult);
  

  // initialize test
  initial
    begin
      reset <= 1; # 2; reset <= 0;
	//	# 2000 $stop;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @(negedge clk)
    begin
			if(MemWrite) begin
        if(WriteData === 24) begin
          $display("Simulation succeeded");
          #15 $stop;
        end else begin
          $display("Simulation failed");
          $stop;
        end
      end
    end
endmodule



//module testbench();
//
//logic        clk, reset;
//logic [1:0]  RegSrc;
//logic        RegWrite;
//logic [1:0]  ImmSrc;
//logic        ALUSrc;
//logic [1:0]  ALUControl;
//logic        MemtoReg;
//logic        PCSrc;
//logic [3:0]  ALUFlags;
//logic [31:0] ALUResult, WriteData;
//logic 		 MemWrite;
//logic [10:0] testvector[0:100];
//logic [31:0] vectornumber, errors;
//logic clktest;
//  // instantiate device to be tested
//  Datapath dut(clk, reset, RegSrc, RegWrite, ImmSrc, ALUSrc, ALUControl, MemtoReg, PCSrc, MemWrite, ALUFlags, ALUResult, WriteData);
//  
//  // initialize test
//  initial
//    begin
//		clk=0; clktest=0;
//      reset = 1; # 12; reset = 0; 
//	
//		errors=0;
//		$readmemb("Test.dat", testvector);   // read test vector 
//		#10 vectornumber = 0;
//    end
//
//// apply testvector
//
//
//  initial 
//    begin 
// 
//		#20; {PCSrc, RegSrc, RegWrite, ImmSrc, ALUSrc, ALUControl, MemtoReg, MemWrite} = 11'b00010000100; //sub
//		#20; {PCSrc, RegSrc, RegWrite, ImmSrc, ALUSrc, ALUControl, MemtoReg, MemWrite} = 11'b00010010000;	// add imm
//		#20; {PCSrc, RegSrc, RegWrite, ImmSrc, ALUSrc, ALUControl, MemtoReg, MemWrite} = 11'b01000110001; //str 
//		#20; {PCSrc, RegSrc, RegWrite, ImmSrc, ALUSrc, ALUControl, MemtoReg, MemWrite} = 11'b00010110010; // ldr
//		#50 $stop;
//
//    end
//
//
//  // generate clock to sequence tests
//  always
//    begin
//      clk <= 1; # 5; clk <= 0; # 5;
//    end
//  
// 
//
//endmodule




//module testbench();
//
//			 logic clk, reset, MemWrite, MemtoReg;
//			 logic [3:0] ALUControl;
//			 logic PCSrc,ALUScr,RegWrite;
//			 logic [1:0] RegSrc,ImmScr;
//			 logic [11:0] ToControler;
//			 logic [3:0] Flags;
//			 logic [31:0] dataout;
//
//			 
//
//topmodule uut(clk, reset, MemWrite, MemtoReg, 
//					  ALUControl, 
//					  PCSrc,ALUScr,RegWrite,
//					  RegSrc,ImmScr,
//					  
//					  ToControler,
//					  Flags, dataout
//					  );
//
//  // initialize test
//  initial
//    begin
//		clk=0;
//      reset = 1; # 12; reset = 0; 
//		MemWrite=0; MemtoReg=0; 
//					  ALUControl=4'b0011; 
//					  PCSrc=0;
//					  ALUScr=0;
//					  RegWrite=1;
//					  RegSrc=2'b00;
//					  ImmScr=2'b00;
//	#100 $stop;
//    end
//
//  // generate clock to sequence tests
//  always
//    begin
//      clk <= 1; # 5; clk <= 0; # 5;
//    end
//
//endmodule
