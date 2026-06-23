`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 14:40:52
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
    input [1:0] state,
    output reg [1:0] next_state,              
    output reg out); //                                  // State transition logic: next_state = f(state, in)
                                                      // Output logic:  out = f(state) for a Moore state machine
    parameter A=0, B=1, C=2, D=3;
    always@(*) begin
        case(state)
            A: begin
                if(in) begin
                    next_state = B;
                    out = 0; end
                else begin
                    next_state = state;
                    out =0; end
            end
            B: begin
                if(in) begin
                    next_state= state ;
                    out = 0; end
                else begin
                    next_state = C;
                    out =0; end
            end
            C:begin
                if(in) begin
                    next_state = D;
                    out=0; end
                else begin
                    next_state = A;
                    out = 0; end
            end
            D: begin
                if(in) begin
                    next_state = B;
                    out = 1; end
                else  begin
                    next_state = C;
                    out = 1; end
            end
        endcase 
    end
endmodule

