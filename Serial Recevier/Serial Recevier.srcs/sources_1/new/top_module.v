`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 19:26:56
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
    input reset,    // Synchronous reset
    output done
); 
    reg [2:0] state,next_state;
    localparam idle=0,start = 1,stop=2,error=3;
    reg [4:0] count; 
    
    always@(*)
        begin
            case(state)
                idle : begin
                    if(~in)
                        next_state = start;
                    else
                        next_state = idle;
                end
                start: begin
                    if(count ==4'd8) begin
                        if(in) 
                            next_state=stop;
                        else 
                            next_state= error; 
                    end
                    else
                        next_state = start;
                end
                stop:
                    next_state = (~in) ? start : idle;
                error : 
                    next_state = in? idle : error;
                default: next_state = idle;
            endcase
        end
    always@(posedge clk)
        begin
            if(reset) begin
                count <= 4'd0;
                state <= idle;
            end
            else begin
                state <= next_state;
                if(state == start)
                    count <= count+1;
                else 
                    count <= 4'd0;
               
            end
        end
    assign done = (state == stop);
endmodule

