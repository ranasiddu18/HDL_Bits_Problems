`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 16:39:22
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
    output done); //

    
    reg [1:0] state,next_state;
    localparam byte1 = 0, byte2 = 1, byte3 = 2,Done= 3;
    
    
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
                  
                    next_state = byte3; end
                     
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
    assign done = state == Done;

endmodule 

/*module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done
);

    reg [1:0] state;

    localparam BYTE1 = 2'd0;   // searching for byte1 (bit[3]=1)
    localparam BYTE2 = 2'd1;   // got byte1, waiting for byte2
    localparam BYTE3 = 2'd2;   // got byte1&2, waiting for byte3
    // localparam unused: 2'd3

    // done should be a 1-cycle pulse right after byte3 is received
    assign done = (state == BYTE3);

    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[3])  // bit[3]=1 marks byte1
                    state_next = BYTE2;
                else
                    state_next = BYTE1;
            end
            BYTE2: state_next = BYTE3;
            BYTE3: state_next = BYTE1;
            default: state_next = BYTE1;
        endcase
    end

    reg [1:0] state_next;

    always @(posedge clk) begin
        if (reset)
            state <= BYTE1;
        else
            state <= state_next;
    end

endmodule */

