`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2026 21:40:13
// Design Name: 
// Module Name: top_module
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


module top_module(
 input clock,
    input a,
    output reg p,
    output reg q );
    always@(*)
        begin
            if(clock) begin
                p<=a;
                 end
            else begin
                p<=p;
                end
        end
    always@(negedge clock)
        begin
            q<=a;
        end
    
endmodule
