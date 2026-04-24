`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 20:47:57
// Design Name: 
// Module Name: F_adder
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


module F_adder(
   input a,b,cin,
    output c,s);
    assign s=a^b^cin;
    assign c=a&b|b&cin|cin&a;
endmodule
