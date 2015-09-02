`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:00:11 12/15/2014
// Design Name:   Vga_controller
// Module Name:   Y:/Documents/3oLAB/VGA_SYNC/vga_controller_tb.v
// Project Name:  VGA_SYNC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Vga_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_controller_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire VGA_RED;
	wire VGA_GREEN;
	wire VGA_BLUE;
	wire VGA_HSYNC;
	wire VGA_VSYNC;

	// Instantiate the Unit Under Test (UUT)
	Vga_controller uut (
		.clk(clk), 
		.rst(rst), 
		.VGA_RED(VGA_RED), 
		.VGA_GREEN(VGA_GREEN), 
		.VGA_BLUE(VGA_BLUE), 
		.VGA_HSYNC(VGA_HSYNC), 
		.VGA_VSYNC(VGA_VSYNC)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#300;
        
		rst = 0;
		
		//#10000 $finish;
		// Add stimulus here

	end
	
	always #20 clk = ~clk;
      
endmodule

