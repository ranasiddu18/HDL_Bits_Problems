`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 19:54:20
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
    output reg [511:0] q ); 
integer i;
    always@(posedge clk)
        begin
            
            q<=512'd00;
            for(i=0;i<512;i=i+1) begin
            if(load)
                q<=data;
            else begin
                if(i==0)
                    q[0]<= 0^q[1];
                else if(i==511)
                    q[511] <= 0^q[510];
                else begin
                    q[i] <= q[i+1] ^ q[i-1] ; end
            end
            end
        end
                    
                 
endmodule
