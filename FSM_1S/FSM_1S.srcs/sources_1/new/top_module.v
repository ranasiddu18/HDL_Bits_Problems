`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 21:00:48
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


module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations

    reg present_state;
    localparam A=0;
    localparam B=1;

    always @(posedge clk) begin
         
        if (reset) begin  
            present_state <= B;
           // Fill in reset logic
        end else begin
            case (present_state)
                A: present_state <= in ? A : B;
                B : present_state <= in ? B : A;                               
            endcase           
        end
    end
    always@(*) begin
        case(present_state)
            A: out <= 0;
            B: out <= 1;
        endcase
    end

endmodule

