`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:49:39 12/15/2014
// Design Name:   VRam
// Module Name:   Y:/Documents/3oLAB/V_RAM/VRam_tb.v
// Project Name:  V_RAM
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: VRam
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module VRam_tb;

// Inputs
	reg clk;
	reg rst;
	reg [13:0] addr;

	// Outputs
	wire red;
	wire green;
	wire blue;

	// Instantiate the Unit Under Test (UUT)
	VRam uut (
		.clk(clk), 
		.rst(rst), 
		.addr(addr), 
		.red(red), 
		.green(green), 
		.blue(blue)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		addr = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		addr = 384;
		#100
		addr = 1356;
		#100
		addr = 1923;
		#100
		addr = 7745;
		#100
		addr = 10883;
		#100
		addr = 16537;
		
		#10000 $finish;
        
		// Add stimulus here

	end
	
	always #10 clk = ~clk;
      
endmodule

