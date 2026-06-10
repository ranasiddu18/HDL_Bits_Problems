`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 19:18:53
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
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    always@(posedge clk)
        begin
            if(load) begin
                q<=data; end
            else if(ena) begin
                case(amount)
                    2'b00: q<=q<<1;
                    2'b01: q<=q<<8;
                    2'b10: q<= $signed(q)>>>1;        //{q[63],1'b0,q[61:0]};
                    2'b11: q<= $signed(q)>>>8 ;         // {q[63],8'b00000000,q[54:0]};
                endcase
            end
        end    
endmodule
