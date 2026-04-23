`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2026 19:13:41
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
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    full_adder d1(a[0],b[0],cin,cout[0],sum[0]);
    full_adder d2(a[1],b[1],cout[0],cout[1],sum[1]);
    full_adder d3(a[2],b[2],cout[1],cout[2],sum[2]);
endmodule
