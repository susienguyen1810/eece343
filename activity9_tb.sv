module activity9_tb();
wire[31:0] instructionoutput;

reg clk,PCSrc;

	// Device under test
	activity9 dut(
		.clk(clk),
		.instructionoutput (instructionoutput),
		.PCPLUS4 (PCPLUS4),
		.PCSrc   (PCSrc)
	);
initial begin 

clk=0;
PCSrc = 0;
end

always #5 clk=~clk;

initial begin
PCSrc = 1;

#50;
#10 PCSrc = 0;

#100 $stop;


end 

endmodule 