`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Edinburgh
// Engineer: Xiaoyu LIN
// 
// Create Date: 2017/11/13 14:13:08
// Design Name: score counter
// Module Name: score_counter
// Project Name: snake_game_extra
// Target Devices: Basys3 Board (with Microblaze processor on the Artix-7 FPGA)
// Tool Versions: Vivado 2015.2 
// Description: This source file record the score.
//              Once the snake reach the target, score add one.
//              It output the number of each digit of 7seg to be dispalyed.
//              It also output the segment strob number.
// Dependencies: 
//              This source file record the score.
// Revision:1.0
// Revision 0.01 - File Created
// Additional Comments:
//              This source file record the score.
//////////////////////////////////////////////////////////////////////////////////


module Blood_Counter(
    input CLK,
    input RESET,
    input [1:0] MSM_State,
    input Reached_Obstacle,
    output reg [3:0] Current_Blood
    );
   
    // generate the fist digit number

                          
endmodule
