`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 06:35:43 PM
// Design Name: 
// Module Name: Decoder
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


module Decoder(
    input [3:0] HEX,
    input [1:0] Select,
    output reg [6:0] HEX_OUT,
    output reg [3:0] SEG_SELECT
    );
    
always@(Select) begin    
        case(Select)
            2'b00: SEG_SELECT[3:0] <= 4'b0111;
            2'b01: SEG_SELECT[3:0] <= 4'b1011;
            2'b10: SEG_SELECT[3:0] <= 4'b1101;
            2'b11: SEG_SELECT[3:0] <= 4'b1110;
            default: SEG_SELECT[3:0] <= 4'b1111;
        endcase
    end
always@(HEX) begin
        case(HEX)
        4'h0:HEX_OUT[6:0]<=7'b1000000;//显示数字0
        4'h1:HEX_OUT[6:0]<=7'b1111001;//显示数字1
        4'h2:HEX_OUT[6:0]<=7'b0100100;//显示数字2
        4'h3:HEX_OUT[6:0]<=7'b0110000;//显示数字3
        4'h4:HEX_OUT[6:0]<=7'b0011001;//显示数字4
        4'h5:HEX_OUT[6:0]<=7'b0010010;//显示数字5
        4'h6:HEX_OUT[6:0]<=7'b0000010;//显示数字6
        4'h7:HEX_OUT[6:0]<=7'b1111000;//显示数字7
        4'h8:HEX_OUT[6:0]<=7'b0000000;//显示数字8
        4'h9:HEX_OUT[6:0]<=7'b0010000;//显示数字9
        4'hA:HEX_OUT[6:0]<=7'b0001000;//显示字母A
        4'hB:HEX_OUT[6:0]<=7'b0000011;//显示字母B
        4'hC:HEX_OUT[6:0]<=7'b1000110;//显示字母C
        4'hD:HEX_OUT[6:0]<=7'b0100001;//显示字母D
        4'hE:HEX_OUT[6:0]<=7'b0000110;//显示字母E
        4'hF:HEX_OUT[6:0]<=7'b1111111;//显示字母F
        
        default:HEX_OUT[6:0]<=7'b1111111;//七根管都不亮
        endcase

    end
endmodule
