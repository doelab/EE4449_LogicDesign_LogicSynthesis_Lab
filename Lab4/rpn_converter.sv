/*
I got this Idea from the following link:
Title: Polish Postfix Notation Calculator
*/
module rpn_converter(	
	input wire clk,
	input wire rst,	   
	// Input variables
	input 	wire input_stb,
	input 	wire [3:0] input_data,
	input 	wire is_input_operator,
	output 	reg input_ack,	
	// Output variables
	output reg output_stb,
	output reg	[3:0] output_data,
	output 	reg is_output_operator,
	input 	wire output_ack,
);

///////////////////////////////////
//Write your code from here

///////////////////////////////////


  endmodule