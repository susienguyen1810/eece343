module flipflopalu 
              (input  logic    clk, reset,
               input  logic [3:0] e, 
               output logic [3:0] f);

  always_ff @(posedge clk, posedge reset)
    if (reset) f <= 0;
    else       f <= e;
endmodule