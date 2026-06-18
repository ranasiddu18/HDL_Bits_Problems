`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 21:19:54
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
    input [511:0] data,
    output reg [511:0] q
);
    integer i;
    reg [511:0] q_next;
     reg left, center, right;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Compute next state using a temporary variable
            for (i = 0; i < 512; i = i + 1) begin
                // Get left, center, right (boundaries are 0)
              
                left   = (i == 0)   ? 1'b0 : q[i-1];
                center = q[i];
                right  = (i == 511) ? 1'b0 : q[i+1];

                // Apply Rule 110 truth table
                case ({right, center, left})
                    3'b111: q_next[i] = 0;
                    3'b110: q_next[i] = 1;
                    3'b101: q_next[i] = 1;
                    3'b100: q_next[i] = 0;
                    3'b011: q_next[i] = 1;
                    3'b010: q_next[i] = 1;
                    3'b001: q_next[i] = 1;
                    3'b000: q_next[i] = 0;
                endcase
            end
            q <= q_next;
        end
    end
endmodule
