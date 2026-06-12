`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2026 19:55:12
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
    input [2:0] SW,      // R
    input [1:0] KEY,     // L and clk
    output reg [2:0] LEDR);  // Q

    wire clk = KEY[0];
    wire L   = KEY[1];

    always @(posedge clk) begin
        if (L) begin
             
            LEDR <= SW;
        end else begin
          
            LEDR[2] <= LEDR[1]^LEDR[2];
            LEDR[1] <= LEDR[0];
            LEDR[0] <= LEDR[2] ;
        end
    end

endmodule
