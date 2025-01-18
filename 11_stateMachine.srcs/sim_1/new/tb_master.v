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


module tb_master( );

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
	reg HIT;
	reg [3:0] Current_Score;
	wire [1:0] MSM_State;
	

     Master_state_machine Master_state_machine(
           .CLK(CLK),
           .RESET(RESET),
           .BTNL(BTNL),
           .BTNR(BTNR),
           .BTNU(BTNU),
           .BTND(BTND),
           .Current_Score(Current_Score),
           .HIT(HIT),
           .MSM_State(MSM_State)
           );

	initial begin
		RESET = 0;
		BTNU = 0;
		BTND = 0;
		BTNR = 0;
		BTNL = 0;
		Current_Score=0;
		HIT=0;
	
		
		#100
		BTNU = 1;
		#20
		BTNU = 0;
		#100
		HIT=1;
		#20
		HIT=0;
		#100
		RESET = 1;
		#20
		RESET = 0;
		#100
        Current_Score = 10;
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


