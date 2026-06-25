`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2026 20:08:26
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
    input in,
    input areset,
    output out); //
    
    reg [1:0] state,next_state;
  parameter A=0, B=1, C=2, D=3;
    
    always@(posedge clk or posedge areset)
        begin
            if(areset)
                state <= A;
            else
                state <= next_state;
        end
    always@(*) begin
        case(state)
            A: begin
                if(in) begin
                    next_state = B;
                     end
                else begin
                    next_state = state;
                     end
            end
            B: begin
                if(in) begin
                    next_state= state ;
                      end
                else begin
                    next_state = C;
                     end
            end
            C:begin
                if(in) begin
                    next_state = D;
                     end
                else begin
                    next_state = A;
                     end
            end
            D: begin
                if(in) begin
                    next_state = B;
                    end
                else  begin
                    next_state = C;
                     end
            end
        endcase 
    end
    assign out =  (state==D) & in | (state == D) & ~in ; 
endmodule
