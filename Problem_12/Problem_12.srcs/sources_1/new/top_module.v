`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2026 20:06:26
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
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);
    


    always @(posedge clk) begin
        if (reset)
            q <= 4'd0;
        else if (slowena) begin
            if (q == 4'd9)
                q <= 4'd0;
            else
                q <= q + 4'd1;
        end
        end
endmodule
