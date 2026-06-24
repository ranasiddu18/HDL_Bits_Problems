`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 19:54:19
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
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = state[A]&~in | state[C]&~in;
    assign next_state[B] = state[A]&in | state[B]&in | state[D]&in;
    assign next_state[C] = state[B]&~in | state[D]&~in;
    assign next_state[D] =  state[C]&in ;

    // Output logic: 
    assign out =  state[3]&~in | state[3]& in;

endmodule
 
