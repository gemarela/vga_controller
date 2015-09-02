`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:31:32 12/15/2014 
// Design Name: 
// Module Name:    Vga_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Vga_controller(
		clk,rst,
		VGA_RED,VGA_GREEN,VGA_BLUE,
		VGA_HSYNC,VGA_VSYNC
    );
	 	 // inputs/outputs signals 
	 input clk;
    input rst;
    output VGA_RED;
    output VGA_GREEN;
    output VGA_BLUE;
    output VGA_HSYNC;
    output VGA_VSYNC;
	 
	 wire [6:0] x_pixel, y_pixel;
	 wire [13:0] vga_addr; 
	 wire reset_de;
	 
	 wire [13:0] addr1;
	 
	 assign addr1 = {y_pixel,x_pixel};
	 
	 assign vga_addr=addr1;
	 
	 // DCM_SP: Digital Clock Manager
   //         Spartan-6
   // Xilinx HDL Language Template, version 14.7

   DCM_SP #(
      .CLKDV_DIVIDE(4.0),                   // CLKDV divide value
                                            // (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
      .CLKFX_DIVIDE(1),                     // Divide value on CLKFX outputs - D - (1-32)
      .CLKFX_MULTIPLY(4),                   // Multiply value on CLKFX outputs - M - (2-32)
      .CLKIN_DIVIDE_BY_2("FALSE"),          // CLKIN divide by two (TRUE/FALSE)
      .CLKIN_PERIOD(10.0),                  // Input clock period specified in nS
      .CLKOUT_PHASE_SHIFT("NONE"),          // Output phase shift (NONE, FIXED, VARIABLE)
      .CLK_FEEDBACK("1X"),                  // Feedback source (NONE, 1X, 2X)
      .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
      .DFS_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
      .DLL_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
      .DSS_MODE("NONE"),                    // Unsupported - Do not change value
      .DUTY_CYCLE_CORRECTION("TRUE"),       // Unsupported - Do not change value
      .FACTORY_JF(16'hc080),                // Unsupported - Do not change value
      .PHASE_SHIFT(0),                      // Amount of fixed phase shift (-255 to 255)
      .STARTUP_WAIT("FALSE")                // Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
   )
   DCM_SP_inst (
      .CLK0(CLK0),         // 1-bit output: 0 degree clock output
      .CLK180(CLK180),     // 1-bit output: 180 degree clock output
      .CLK270(CLK270),     // 1-bit output: 270 degree clock output
      .CLK2X(CLK2X),       // 1-bit output: 2X clock frequency clock output
      .CLK2X180(CLK2X180), // 1-bit output: 2X clock frequency, 180 degree clock output
      .CLK90(CLK90),       // 1-bit output: 90 degree clock output
      .CLKDV(CLKDV),       // 1-bit output: Divided clock output
      .CLKFX(CLKFX),       // 1-bit output: Digital Frequency Synthesizer output (DFS)
      .CLKFX180(CLKFX180), // 1-bit output: 180 degree CLKFX output
      .LOCKED(LOCKED),     // 1-bit output: DCM_SP Lock Output
      .PSDONE(PSDONE),     // 1-bit output: Phase shift done output
      .STATUS(STATUS),     // 8-bit output: DCM_SP status output
      .CLKFB(CLK0),       // 1-bit input: Clock feedback input
      .CLKIN(clk),       // 1-bit input: Clock input
      .DSSEN(DSSEN),       // 1-bit input: Unsupported, specify to GND.
      .PSCLK(PSCLK),       // 1-bit input: Phase shift clock input
      .PSEN(PSEN),         // 1-bit input: Phase shift enable
      .PSINCDEC(PSINCDEC), // 1-bit input: Phase shift increment/decrement input
      .RST(rst)            // 1-bit input: Active high reset input
   );

   // End of DCM_SP_inst instantiation
			

	   // End of DCM_SP_inst instantiation
	 //anafora twn module vram, vga_sync, Debounce
		
			 //anafora twn module vram, vga_sync, Debounce
	 VRam vram(.clk(CLKDV), .rst(rst_de), .addr(vga_addr), .video_on(video_on), .red(VGA_RED), .green(VGA_GREEN), .blue(VGA_BLUE));
	 
	 Vga_Sync sync(.clk(CLKDV), .rst(rst_de), .h_sync(VGA_HSYNC), .v_sync(VGA_VSYNC), .x_pixel(x_pixel), .y_pixel(y_pixel), .video_on(video_on));
	 
	 Debounce Antibounce(.clk(CLKDV), .button(rst), .debounce(rst_de));

endmodule
