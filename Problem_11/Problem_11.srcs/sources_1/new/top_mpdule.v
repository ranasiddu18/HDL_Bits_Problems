`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 22:25:20
// Design Name: 
// Module Name: top_mpdule
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


module top_mpdule(
    input clk,
    input reset,        // Synchronous active-high reset
    output reg [3:0] q);
    always@(posedge clk)
        begin
            if(reset || q==4'd9) begin
                q<=4'b0000;
            end
            else
                q<=q+1;
        end
            
endmodule
