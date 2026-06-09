`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 17:42:05
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
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
    always@(posedge clk)
        begin
            if(load)
                q<=data;
            else if(ena==2'b01)
                q<={q[0],q[99:1]};
            else if(ena==2'b10)
                q<={q[98:0],q[99]};
            else 
                q<=q;
        end
endmodule
