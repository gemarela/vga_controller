`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Marelas George
// 
// Create Date:    21:19:22 12/15/2014 
// Design Name: 
// Module Name:    Vga_Sync 
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
module Vga_Sync(
	clk,rst,
	h_sync,v_sync,
	x_pixel,y_pixel,
	video_on
    );
input  clk,rst;
output 	h_sync, //horizontal synchronization 
			v_sync, //vertical synchronization 
			x_pixel,//position of the row pixel
			y_pixel,//position of the column pixel
			video_on;//enable pixel on screen
	
	wire		 h_sync,
				 v_sync,
				 video_on;
				 
	reg [9:0] r_pixel,c_pixel;
	reg [6:0] x_pixel;  //collum position for VRAM address computation
	reg [6:0] y_pixel;	//collum position for VRAM address computation
	reg [2:0] div_x,div_y; //counters which create delay for x_pixel & y_pixel increment
	
		// Timing parameters (for 25MHz pixel clock and 640 x 480 display)
	//Horizontal parameters 
	parameter H_PIXEL = 640;
	//Horizontal pulse HSYNC_START-HSYNC_END
	parameter HSYNC_START = 655;
	parameter HSYNC_END = 751;
	//Full line of horizontal singal
	parameter H_MAX = 799; //800
	
	//Vertical paramters
	parameter V_PIXEL = 480;
	//verticla pulse VSYNC_START-VSYNC_END
	parameter VSYNC_START = 489; //490 
	parameter VSYNC_END = 491;
	//Full line of vertical signal
	parameter V_MAX = 524;
	
	always @(posedge clk or posedge rst) begin
	
		if (rst) begin
			r_pixel = 0;
			c_pixel = 0;
			x_pixel = 0;
			y_pixel = 0;
			div_x = 0;
			div_y = 0;
			//h_sync = 0;
			//v_sync = 0;
		end
		else begin
			
			//increment horizontal synchronize counter. At the end of sync line counter recycles
			if(c_pixel == H_MAX) begin
				c_pixel = 10'b0;
			end
			else begin                          
				c_pixel = c_pixel+1;
				if(div_x == 4) begin //every five c_pixel, x_pixel increases per 1
					x_pixel = x_pixel+1;
					div_x = 0;
					if(c_pixel == H_MAX)begin
						x_pixel = 7'b0;
					end
				end
				else if(c_pixel < H_PIXEL) begin
					div_x = div_x + 1;
				end
			end
			
			//increment vertical synchronize counter. At the end of sync line counter recycles
			if(r_pixel >= V_MAX && c_pixel >= H_MAX) begin
				r_pixel = 10'b0;
			end
			else if(c_pixel == H_MAX) begin //after c_pixel's maximum value,starts row pixel counter
														
				r_pixel = r_pixel +1;
	
				if(div_y == 4) begin		//every five r_pixel, y_pixel increases per 1
					div_y = 0;									
					y_pixel = y_pixel+1;			
				end
				else if(r_pixel < V_PIXEL) begin
					div_y = div_y + 1;
				end
				if(r_pixel == V_PIXEL)begin
					y_pixel = 7'b0;
				end

			end
		end
	end
	
	//generate active-low horizontal pulse
	assign h_sync   = ((c_pixel > HSYNC_START)&&(c_pixel <= HSYNC_END));
	//generate active_low vertical pulse
	assign v_sync   = ((r_pixel > VSYNC_START)&&(r_pixel <= VSYNC_END));
	//generate the video on signal for the pixels
	assign video_on = ((x_pixel < 127)&&(y_pixel < 96));


endmodule




