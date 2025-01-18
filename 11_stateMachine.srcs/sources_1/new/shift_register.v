`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2022 04:54:39 AM
// Design Name: 
// Module Name: Shift_Register
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


module Shift_Register(
    CLK,
    RESET,
    IN,
    OUT
    );
    
    parameter LENGTH = 8;
    parameter Max_Value = 150;
    
    input CLK;
    input RESET;
    input IN;
    output [LENGTH-1 : 0] OUT;
    
    reg [LENGTH-1 : 0] Dtypes;
    
    initial begin
    Dtypes <=0;
    end
    
    always@(posedge CLK) begin
        if(RESET)
        Dtypes <=0;
        else
        Dtypes <= {Dtypes[LENGTH-2:0], IN};
    end
    
    assign OUT = Dtypes >= Max_Value ? Dtypes - Max_Value : Dtypes;
endmodule
