`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2022 12:59:31
// Design Name: 
// Module Name: flix
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
///////////////////////a`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 06:32:44 PM
// Design Name: 
// Module Name: Flick
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


module Flick(    
       input Bit_counter,
       output  reg [1:0] Select
     );

    reg [1:0] Current_state = 0, Next_state;
    always@(posedge Bit_counter) 
            Current_state = Next_state;
    always@(Current_state) begin
            case(Current_state)
                2'b00:
                    begin
                        Select = 2'b00;
                        Next_state = 2'b01;
                    end
                2'b01:
                    begin
                        Select = 2'b01;
                        Next_state = 2'b10;
                    end
                2'b10:
                    begin
                        Select = 2'b10;
                        Next_state = 2'b11;
                    end
                2'b11:
                    begin
                        Select = 2'b11;
                        Next_state = 2'b00;
                    end
            endcase
        end
endmodule
///////////////////////////////////////////////////////////


module flix(

    );
endmodule
