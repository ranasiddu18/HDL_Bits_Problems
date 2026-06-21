`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 19:58:28
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
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;
   
    always @(*) begin
      next_state <= state;    
        case(state) 
            ON: begin
                if(k) begin
                    next_state<=OFF; end
                else begin
                    next_state<=state; end
            end
            OFF: begin
                if(j) begin
                    next_state<=ON; end
                else begin
                    next_state<=state; end
            end// State transition logic
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset)
            state<=OFF;
        else
            state<=next_state;
               // State flip-flops with asynchronous reset
    end

    // Output logic
    assign out = (state == ON); // assign out = (state == ...);

endmodule
