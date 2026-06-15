`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 20:08:34
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
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    MUXDFF d1(KEY[0],KEY[3],SW[3],KEY[1],KEY[2],LEDR[3]);
    MUXDFF d2(KEY[0],LEDR[3],SW[2],KEY[1],KEY[2],LEDR[2]);
    MUXDFF d3(KEY[0], LEDR[2],SW[1],KEY[1],KEY[2],LEDR[1]);
    MUXDFF d4(KEY[0],LEDR[1],SW[0],KEY[1],KEY[2],LEDR[0]);
    
endmodule


module MUXDFF(
    input clk,
    input w, R, E, L,
    output reg Q
);
    always@(posedge clk)
        begin
            if(E==0 & L==0) begin
                Q <= Q; end
            else if(E==0 & L==1) begin
                Q <= R; end
            else if(E==1 & L==0) begin
                Q <= w; end
                    else if(E==1 & L==1) begin
                Q <= R; end
                    end
endmodule
