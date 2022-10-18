module clkdiv_tb();
  logic clk;
  logic Reset;
  logic left;
  logic right;
  logic hazard;
  logic brake;
  logic LA;
  logic LB;
  logic LC;
  logic RA;
  logic RB;
  logic RC;
  
always #1 clk =~clk;
// FSM device under test
  FSM dut(
    .clk (clk),
    .Reset (Reset),
    .left (left),
    .right (right),
    .hazard (hazard),
    .brake (brake),
    .LA (LA),
    .LB (LB),
    .LC (LC),
    .RA (RA),
    .RB (RB),
    .RC (RC)
  );

// input generation
  initial begin
  Reset=1;
  #2 Reset=0;
  clk = 0;
  
  #10 left = 1'b1; right = 1'b0; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing left
  #10 left = 1'b1; right = 1'b0; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing left
  #10 left = 1'b1; right = 1'b0; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing left

  #10 left = 1'b0; right = 1'b1; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing right
  #10 left = 1'b0; right = 1'b1; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing right
  #10 left = 1'b0; right = 1'b1; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing right

  #10 left = 1'b0; right = 1'b0; brake = 1'b1; hazard = 1'b0; Reset = 1'b0; //testing brake

  #10 left = 1'b1; right = 1'b0; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing left
  #10 left = 1'b1; right = 1'b0; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing left
  #10 left = 1'b0; right = 1'b0; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing reset

  #10 left = 1'b1; right = 1'b0; brake = 1'b0; hazard = 1'b0; Reset = 1'b0; //testing left
  #10 left = 1'b0; right = 1'b0; brake = 1'b0; hazard = 1'b1; Reset = 1'b0; //testing hazar

  $stop;
  end
endmodule