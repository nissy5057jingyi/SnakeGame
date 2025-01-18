`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2022 21:28:35
// Design Name: 
// Module Name: apple
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


module Target_Generator(
    input CLK,
    input RESET,
    input Reached_Target,
    input [2:0] size,
    input [9:0] MaxX,
    input [8:0] MaxY,
    output reg [9:0] Target_x,
    output reg [8:0] Target_y
);
    
    wire [8:0] OUT1_1;
    wire [7:0] OUT2_1;
    wire [7:0] OUT1_2;
    wire [6:0] OUT2_2;
    wire [5:0] OUT1_4;
    wire [4:0] OUT2_4;
    
    
    
    Shift_Register #(
        .LENGTH(9),
        .Max_Value(320)
    )
    bit9_X (
        .CLK(CLK),
        .RESET(RESET),
        .IN((OUT1_1[8]^~OUT1_1[5])^~(OUT1_1[4]^~OUT1_1[3])),
        .OUT(OUT1_1)
    );
    
    
    Shift_Register #(
        .LENGTH(8),
        .Max_Value(240)
    )
    bit8_Y (
        .CLK(CLK),
        .RESET(RESET),
        .IN(OUT2_1[7]^~OUT2_1[5]),
        .OUT(OUT2_1)
    );
    
    Shift_Register #(
        .LENGTH(8),
        .Max_Value(160)
    )
    bit8_X (
        .CLK(CLK),
        .RESET(RESET),
        .IN((OUT1_2[7]^~OUT1_2[5])^~(OUT1_2[4]^~OUT1_2[3])),
        .OUT(OUT1_2)
    );
    
    Shift_Register #(
        .LENGTH(7),
        .Max_Value(120)
    )
    bit7_Y (
        .CLK(CLK),
        .RESET(RESET),
        .IN(OUT2_2[6]^~OUT2_2[5]),
        .OUT(OUT2_2)
    );
    
    
    Shift_Register #(
        .LENGTH(6),
        .Max_Value(40)
    )
    bit6_X (
        .CLK(CLK),
        .RESET(RESET),
        .IN((OUT1_4[5]^~OUT1_4[0])^~(OUT1_4[4]^~OUT1_4[3])),
        .OUT(OUT1_4)
    );
    
    Shift_Register #(
        .LENGTH(5),
        .Max_Value(30)
    )
    bit5_Y (
        .CLK(CLK),
        .RESET(RESET),
        .IN(OUT2_4[4]^~OUT2_4[1]),
        .OUT(OUT2_4)
    );
   
    initial begin
    Target_x<=5;
    Target_y<=5;
    end
    
   always@(posedge CLK) begin
      if(RESET)begin
      Target_x<=5;
      Target_y<=5;
      end
      else if(Reached_Target)begin
      case(size)
        3'd1:begin
             Target_x[8:0] <= OUT1_1;
             Target_y[7:0] <= OUT2_1; 
        end
        3'd2:begin
             Target_x[7:0] <= OUT1_2;
             Target_y[6:0]<= OUT2_2;  
        end
        3'd4:begin
             Target_x[5:0] <= OUT1_4;
             Target_y[4:0] <= OUT2_4;  
        end
       endcase
     end
   end
      
endmodule
    
