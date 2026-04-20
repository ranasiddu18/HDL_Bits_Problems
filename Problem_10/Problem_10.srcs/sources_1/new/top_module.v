`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2026 18:09:38
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


 module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output reg [3:0] q);
    always@(posedge clk)
        begin
            if(reset) begin
                q<=4'b0000;
            end
            else begin
                q<=q+1;
            end
        end
endmodule
