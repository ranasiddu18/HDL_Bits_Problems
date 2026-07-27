`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2026 22:12:18
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
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);
    
    always@(posedge clk) begin
        if(shift_ena) begin
            q <= {q[2:0],data}; end
        else if(count_ena && q!=0 )
            q <= q-1;
        else if( count_ena && q==0)
            q <= 4'hf;
    end 
        
endmodule
