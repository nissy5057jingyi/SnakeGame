`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2022 15:38:58
// Design Name: 
// Module Name: idle
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


module idle(
        input CLK,
        input [9:0]ADDRH,
        input [8:0] ADDRV, 
        output reg [11:0] IDLE_COLOUR
    );
    
         always@(posedge CLK) begin
           IDLE_COLOUR<=12'h0F0;
         end
    
endmodule
