`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2022 13:21:19
// Design Name: 
// Module Name: tb_master
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


module tb_navigation( );

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
	wire [1:0] direction;
	

     Navigation_state_machine Navigation_state_machine
          (.CLK(CLK),
           .RESET(RESET),
           .BTNL(BTNL),
           .BTNR(BTNR),
           .BTNU(BTNU),
           .BTND(BTND),
           .direction(direction)
           );

	initial begin
		RESET = 0;
		BTNU = 0;
		BTND = 0;
		BTNR = 0;
		BTNL = 0;
		
		#100
		BTNU = 1;
		#20
		BTNU = 0;
		#100
		RESET = 1;
		#20
		RESET = 0;
		#20
        BTNR = 1;
        #20
        BTNR = 0;
		#100
        BTND = 1;
        #20
        BTND = 0;
		#100
        BTNL = 1;
        #20
        BTNL = 0;
		#100;
		$stop;
	end

endmodule
