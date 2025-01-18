`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2022 15:45:53
// Design Name: 
// Module Name: obstacle_generator
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


module Obstacle_Generator(
       input CLK,
       input RESET,
       input [31:0] Counter, 
       input [1:0] MSM_State,
       input [8:0] MaxY,
       output reg [9:0] Obstacle_x,
       output reg [8:0] Obstacle_y
    );
    
       
        
    always@(posedge CLK)begin
        if(RESET)begin
            Obstacle_x <= 10;
            Obstacle_y <= 0;
        end
        else if ((Counter==0) && (MSM_State==2'b01)) begin
                if(Obstacle_y ==MaxY)
                 Obstacle_y <= 0;
                else begin      
                 Obstacle_y <= Obstacle_y +1;
                end
        end
     end
  
         
  endmodule
