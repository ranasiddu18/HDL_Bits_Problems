`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 20:47:08
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
     input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
wire c1,c2,c3;
    F_adder d1(x[0],y[0],0,c1,sum[0]);
    F_adder d2(x[1],y[1],c1,c2,sum[1]);
    F_adder d3(x[2],y[2],c2,c3,sum[2]);
    F_adder d4(x[3],y[3],c3,sum[4],sum[3]);

endmodule
