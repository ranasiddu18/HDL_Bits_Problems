`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2026 15:29:49
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
    input a,
    output reg [3:0] q );
    always@(posedge clk)
        begin
            if(a)
                q<=4'd4;
            else if(q==4'd6)
                q<=0;
            else
                q<=q+1;
        end
endmodule
