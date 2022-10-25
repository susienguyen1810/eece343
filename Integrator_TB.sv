
module Integrator_TB();

wire Done;
wire [15:0] SUM;

reg Clk, Reset, Start; 


Integrator UUT(Start, Clk, Reset, SUM, Done);

initial begin 

Clk=0;
Reset=0;
Start=0;
end

always #5 Clk=~Clk;

initial begin

#50;
Reset=1;
#8 Reset=0;
#10 Start=1;

#10 Start=0; 

#100 $stop;


end 

endmodule 
