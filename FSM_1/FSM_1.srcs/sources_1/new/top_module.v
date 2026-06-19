`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 18:11:34
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
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin  
        next_state=state;                // This is a combinational always block
        case(state)
            A: begin
                if(in) begin
                    next_state<=state;
                      end
                     
                else begin
                    next_state<=B;
                    
                     end
            end
            B: begin
                if(in) begin
                    next_state<=state;
                     end
                    
                else begin
                    next_state<=A;
                    end
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        if(areset)
          state<=B;
        else 
            state <= next_state;          // State flip-flops with asynchronous reset
    end

              // Output logic
    assign out = state==B ;// assign out = (state == ...);

endmodule
