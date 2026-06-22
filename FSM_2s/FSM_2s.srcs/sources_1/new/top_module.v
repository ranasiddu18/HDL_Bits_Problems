`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 19:06:52
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
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        next_state<=state;
        case(state)
            ON: begin
                if(k) begin
                    next_state<=OFF; end
                else begin
                    next_state <= state; end
            end
            OFF : begin
                if(j) begin
                    next_state<=ON; end
                else begin
                    next_state<= state; end
            end
        endcase// State transition logic
    end

    always @(posedge clk) begin
        if(reset)
            state<=OFF;
        else
            state<=next_state;// State flip-flops with synchronous reset
    end

    // Output logic
    assign out = (state == ON); // assign out = (state == ...);

endmodule
