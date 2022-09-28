module rc_adder_tb ();

	// dut signals
	logic [31:0] a, b;
	logic [31:0] sum;
	logic carry;

	// tb signals
	integer   error_count = 0;
	integer   total_tests = 0;


	// Device under test
	rc_adder dut (
		.a    (a),
		.b    (b),
		.sum  (sum),
		.cout (carry)
	);

	// Input generation
	initial begin
		$display("============== Starting simulation ==============");

		/*
		 * This takes tooooo loooong, so we can't exhaustively test
		 * all input combinations.
		 *
		{a,b} = 64'd0;
		while( {a, b} != 64'hFFFFFFFFFFFFFFFF ) begin
			run_test(a,b);
			{a, b} = {a, b} + 1;
		end
		*/

		// Use this task to test various input combinations
		// inputs to the task are a and b, two 32-bit numbers.
		run_test(0,0);
		// What other tests are required?
		//B is fixed
		a = 1;
		b = 1;
		for (int i = 0; i <32; i = i+1)begin
		run_test(a,b);
		a = a << 1;
		end
		#3;
		//A is fixed
		a = 1;
		b = 1;
		for (int i = 0; i <32; i = i+1)begin
		run_test(a,b);
		b = b << 1;
		end
		//Cout is fixed
		a = 3;
		b = 3;
		for (int i = 0; i <32; i = i+1)begin
		run_test(a,b);
		a = a << 1;
		b = b << 1;
		end
		
		$display("%d errors found.", error_count);
		$display("%d total tests performed.", total_tests);
		$display("============== Simulation complete ==============");
		$stop;
	end

	// Output check
	always @ (*) begin
		#1;
		if( {carry,sum} !== {1'b0,a}+{1'b0,b} ) begin
			$display("Error at a=%x,b=%x should be %x but got %x", a, b, {1'b0,a}+{1'b0,b}, {carry,sum});
			error_count = error_count + 1;
		end
		total_tests = total_tests + 1;
	end

	task run_test;
		input [31:0] arg_a;
		input [31:0] arg_b;
	begin
		#3;
		a = arg_a;
		b = arg_b;
	end
	endtask
		
endmodule
