`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2022 10:38:46 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_top();

	reg CLK;
	initial begin
		CLK = 0;
	end
	always begin
		CLK = ~CLK; #10;
	end


	reg RESET;
	reg BTNU;
	reg BTND;
	reg BTNL;
	reg BTNR;
	reg [2:0] Level;
	wire [3:0] SEG_SELECT;
	wire [6:0] HEX_OUT;
	wire [11:0] COLOUR_OUT;
	wire HS;
	wire VS;
	

	top top(
		.CLK(CLK),
		.RESET(RESET),
		.BTNU(BTNU),
		.BTND(BTND),
		.BTNL(BTNL),
		.BTNR(BTNR),
		.Level(Level),
        .SEG_SELECT(SEG_SELECT),
        .HEX_OUT(HEX_OUT),
        .COLOUR_OUT(COLOUR_OUT),
        .HS(HS),
        .VS(VS)
	);
	

	initial begin
		RESET = 0;
		BTNU = 0;
		BTND = 0;
		BTNR = 0;
		BTNL = 0;
		Level=0;
		#100;
		Level = 1;
		#100;
		BTNU = 1;
		#20;
		BTNU = 0;
		#2000;
		RESET = 1;
		#100;
		BTNR = 1;
		#20;
		BTNR = 0;
		#500;
		BTND = 1;
		#20;
		BTND = 0;
		#500;
		BTNL = 1;
		#20;
		BTNL = 0;
		#1000;
		$stop;
	end

endmodule