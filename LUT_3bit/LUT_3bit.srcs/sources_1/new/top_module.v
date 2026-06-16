`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 22:17:07
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
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    reg [7:0] Q;
    always@(posedge clk)
        begin
            if(enable) begin
                Q<= {Q[6:0],S}; end
        end
    assign Z =Q[{A,B,C}];
endmodule
