`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 17:09:58
// Design Name: 
// Module Name: Size_Selecter
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


module Size_Selecter(
    input CLK,
    input [2:0] Size,
    output reg [2:0] size
    );
    
        always@(posedge CLK) begin
        case(Size)
            0: size <= 1;
            1: size <= 1;
            2: size <= 2;
            3: size <= 2;
            4: size <= 4;
            5: size <= 4;
            6: size <= 4;
            7: size <= 4;
            endcase
    end
endmodule
