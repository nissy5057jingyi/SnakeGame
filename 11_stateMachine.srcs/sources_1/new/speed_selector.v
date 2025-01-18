`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 05:45:25 AM
// Design Name: 
// Module Name: Speed_Selector
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


module Speed_Selector(
    input CLK,
    input [2:0] Level,
    input [1:0] MSM_State,
    output reg [31:0] Counter
    );
    
    wire [31:0] Counter_1;
    wire [31:0] Counter_2;
    wire [31:0] Counter_3;
    wire [31:0] Counter_4;
    wire [31:0] Counter_5;
    wire [31:0] Counter_6;
    wire [31:0] Counter_7;

    Generic_counter # (
    .COUNTER_WIDTH(32),
    .COUNTER_MAX(100000000))  
    Count_1(  
    .CLK(CLK),
    .ENABLE(MSM_State==2'b01),
    .RESET(1'b0),
    .COUNT(Counter_1)
    );
    
    Generic_counter # (
    .COUNTER_WIDTH(32),
    .COUNTER_MAX(80000000))  
    Count_2(  
    .CLK(CLK),
    .ENABLE(1'b1),
    .RESET(1'b0),
    .COUNT(Counter_2)
    );
    
    Generic_counter # (
    .COUNTER_WIDTH(32),
    .COUNTER_MAX(70000000))  
    Count_3(  
    .CLK(CLK),
    .ENABLE(1'b1),
    .RESET(1'b0),
    .COUNT(Counter_3)
    );
    
    Generic_counter # (
    .COUNTER_WIDTH(32),
    .COUNTER_MAX(60000000))  
    Count_4(  
    .CLK(CLK),
    .ENABLE(1'b1),
    .RESET(1'b0),
    .COUNT(Counter_4)
    );
    
    Generic_counter # (
    .COUNTER_WIDTH(32),
    .COUNTER_MAX(50000000))  
    Count_5(  
    .CLK(CLK),
    .ENABLE(1'b1),
    .RESET(1'b0),
    .COUNT(Counter_5)
    );
    
    Generic_counter # (
    .COUNTER_WIDTH(32),
    .COUNTER_MAX(40000000))  
    Count_6(  
    .CLK(CLK),
    .ENABLE(1'b1),
    .RESET(1'b0),
    .COUNT(Counter_6)
    );
    
    Generic_counter # (
    .COUNTER_WIDTH(32),
    .COUNTER_MAX(10000000))  
    Count_7(  
    .CLK(CLK),
    .ENABLE(1'b1),
    .RESET(1'b0),
    .COUNT(Counter_7)
    );
    
    always@(posedge CLK) begin
        case(Level)
            0: Counter <= 32'b1;
            1: Counter <= Counter_1;
            2: Counter <= Counter_2;
            3: Counter <= Counter_3;
            4: Counter <= Counter_4;
            5: Counter <= Counter_5;
            6: Counter <= Counter_6;
            7: Counter <= Counter_7;
            endcase
    end
    
endmodule
