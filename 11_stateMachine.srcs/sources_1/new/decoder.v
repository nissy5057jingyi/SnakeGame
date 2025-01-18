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
        4'h0:HEX_OUT[6:0]<=7'b1000000;//��ʾ����0
        4'h1:HEX_OUT[6:0]<=7'b1111001;//��ʾ����1
        4'h2:HEX_OUT[6:0]<=7'b0100100;//��ʾ����2
        4'h3:HEX_OUT[6:0]<=7'b0110000;//��ʾ����3
        4'h4:HEX_OUT[6:0]<=7'b0011001;//��ʾ����4
        4'h5:HEX_OUT[6:0]<=7'b0010010;//��ʾ����5
        4'h6:HEX_OUT[6:0]<=7'b0000010;//��ʾ����6
        4'h7:HEX_OUT[6:0]<=7'b1111000;//��ʾ����7
        4'h8:HEX_OUT[6:0]<=7'b0000000;//��ʾ����8
        4'h9:HEX_OUT[6:0]<=7'b0010000;//��ʾ����9
        4'hA:HEX_OUT[6:0]<=7'b0001000;//��ʾ��ĸA
        4'hB:HEX_OUT[6:0]<=7'b0000011;//��ʾ��ĸB
        4'hC:HEX_OUT[6:0]<=7'b1000110;//��ʾ��ĸC
        4'hD:HEX_OUT[6:0]<=7'b0100001;//��ʾ��ĸD
        4'hE:HEX_OUT[6:0]<=7'b0000110;//��ʾ��ĸE
        4'hF:HEX_OUT[6:0]<=7'b1111111;//��ʾ��ĸF
        
        default:HEX_OUT[6:0]<=7'b1111111;//�߸��ܶ�����
        endcase

    end
endmodule
