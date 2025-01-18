`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2022 16:50:14
// Design Name: 
// Module Name: Seg_Display
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


module Seg_Display(
    input CLK,
    input RESET,
    input [7:0] Current_Score,
    input [7:0] Current_Blood,
    input [7:0] timer,
    output [3:0] SEG_SELECT,
    output [6:0] HEX_OUT
    );
    wire TRIG_OUT;
    wire [1:0] Select;
    wire [3:0] A;
    wire [3:0] B;
    wire [3:0] C;
    wire [3:0] D;
    wire [3:0] c;
    wire [3:0] d;
    wire [3:0] HEX;
    wire [1:0] Cy;

        digit score(
            .Num(Current_Score/2),
            .CLK(CLK),
            .OUT_0(A)
         );
         
        digit blood(
             .Num(Current_Blood/2),
             .CLK(CLK),
             .OUT_0(B)
          );
        
        digit Timer(
           .Num(timer),
           .CLK(CLK),
           .OUT_0(C),
           .OUT_1(D)
        );
        
         
        Generic_counter # (
            .COUNTER_WIDTH(17),
            .COUNTER_MAX(99999))  
        strobe_counter (  
            .CLK(CLK),
            .ENABLE(1'b1),
            .RESET(1'b0),
            .TRIG_OUT(TRIG_OUT)
        );
        
       Generic_counter # (
            .COUNTER_WIDTH(10),
            .COUNTER_MAX(999))  
        second (  
            .CLK(CLK),
            .ENABLE(TRIG_OUT),
            .RESET(1'b0),
            .TRIG_OUT(Cy[0])
        );
    
        
        Generic_counter # (
            .COUNTER_WIDTH(2),
            .COUNTER_MAX(3))  
        select_counter (  
            .CLK(CLK),
            .ENABLE(TRIG_OUT),
            .RESET(1'b0),
            .COUNT(Select)
        );
        
        
        MUX MUX(.A(A), .B(B), .C(C), .D(D), .Select(Select), .HEX(HEX));
        Decoder Decoder(.HEX(HEX), .Select(Select), .HEX_OUT(HEX_OUT), .SEG_SELECT(SEG_SELECT));
    
endmodule
