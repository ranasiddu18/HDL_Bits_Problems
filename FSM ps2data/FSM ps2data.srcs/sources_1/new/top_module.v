`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 19:24:13
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
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

     reg [1:0] state,next_state;
    localparam byte1 = 0, byte2 = 1, byte3 = 2,Done= 3;
    reg [7:0] in1,in2,in3;
    
     // Datapath should be in sequential block
    always@(*)
        begin
            case(state)
                byte1: begin
                   
                    if(in[3]) begin
                        next_state = byte2;
                          
                          end
                    else 
                        next_state = state;
                end
                byte2: begin
                      
                    next_state = byte3; 
                      
                end
                     
                byte3: begin
                    
                    next_state = Done;
                      
                      end
                Done: begin
                    if(in[3])
                        next_state = byte2;
                    else
                        next_state = byte1;
                end
                      
                default : next_state = byte1;
                
            endcase
        end
    
    always@(posedge clk)
        begin
            if(reset) begin
                state = byte1; end
            else begin
                state <= next_state;
                 end
        end
    
    always@(posedge clk) begin
        if(reset) begin
            in1 <= 8'd0;
            in2 <= 8'd0;
            in3 <= 8'd0;
        end
        else begin
            case(next_state)
                byte2: in1 <= in;
                byte3: in2 <= in;
                Done : in3 <= in;
            endcase
        end
    end
               
    assign done = state == Done;
    assign out_bytes = {in1,in2,in3};
endmodule

