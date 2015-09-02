`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Marelas George
// 
// Create Date:    00:48:58 10/15/2014 
// Design Name: 
// Module Name:    Debounce 
// Project Name: 		
// Target Devices: 
// Tool versions: 
// Description: To Debounce exei ylopoihthei gia na prolamvanei pithanes astatheies 
//					kai anapidiseis simatwn apo tin xrisi tou koumpiou tis plaketas. 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Debounce( clk, button, debounce);
	
	/*input to clock toy kyklwmatos kai to sima poy theloyme na filtraroume*/
	input  	  clk,button;		 
	/*output to filtrarismeno sima*/
	output 	  debounce;
	
	reg [19:0] cntr; //counter deigmatolipsias.elegxei tin timi tou button se xroniko diastima 
							//kai mas dinei timi molis statheropoihthei to button
	reg 		  debounce;
	reg 		  button_1;
	reg 		  button_sync;
	

	/*2 flip-flop gia na filtraroume to sima*/
	always @(posedge clk)
	begin
		button_1 <= button;
		button_sync <= button_1;
	end
	
	
	always @(posedge clk )
	begin
		if (button_sync)begin
			cntr = cntr+1;
			if(cntr == 100000)
			begin
				cntr = 0 ;
				debounce = 1; ////to sima gia tin enallagi me to patima tou koumpiou energopoieitai.
			end
		end
		else
		begin
			cntr = 0; 
			debounce = 0;
		end		
	end
	

endmodule
