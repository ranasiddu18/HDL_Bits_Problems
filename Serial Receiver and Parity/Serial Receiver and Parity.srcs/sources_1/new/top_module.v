`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 21:54:10
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
    output [7:0] out_byte,
    output done
);

    localparam IDLE = 2'd0, DATA_RECV = 2'd1, STOP = 2'd2, ERROR = 2'd3;
    
    reg [1:0] state, next_state;
    reg [3:0] count;
    reg [7:0] data;
    wire odd;
    wire parity_reset;

    // Release parity reset ONLY when actively receiving the 9 stream bits
    assign parity_reset = (state != DATA_RECV);

    parity p1 (
        .clk(clk),
        .reset(parity_reset),
        .in(in),
        .odd(odd)
    );

    // 1. Next-State Combinational Logic
    always @(*) begin
        case (state)
            IDLE: begin
                next_state = (~in) ? DATA_RECV : IDLE;
            end
            DATA_RECV: begin
                // Wait for 9 bits: 8 data bits + 1 parity bit.
                // When count == 9, wire 'in' holds the STOP bit.
                if (count == 4'd9) begin
                    if (~in)
                        next_state = ERROR;     // Missing stop bit -> framing error
                    else if (odd)
                        next_state = STOP;      // Valid stop bit + correct odd parity -> DONE!
                    else
                        next_state = IDLE;      // Parity check failed -> discard byte, wait for next start bit
                end
                else begin
                    next_state = DATA_RECV;
                end
            end
            STOP: begin
                next_state = (~in) ? DATA_RECV : IDLE;
            end
            ERROR: begin
                next_state = (in) ? IDLE : ERROR;
            end
            default: next_state = IDLE;
        endcase
    end

    // 2. State & Counter Synchronous Update
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'd0;
        end
        else begin
            state <= next_state;
            if (state == DATA_RECV)
                count <= count + 1'b1;
            else
                count <= 4'd0;
        end
    end

    // 3. Datapath: Serial-to-Parallel Shift Register
    always @(posedge clk) begin
        if (reset) begin
            data <= 8'd0;
        end
        // Only shift during the 8 actual data bit cycles (count 0 to 7).
        // When count == 8 (parity bit) or count == 9 (stop bit), do NOT shift!
        else if (state == DATA_RECV && count <= 4'd7) begin
            data <= {in, data[7:1]};
        end
    end

    // 4. Output Assignments
    assign done = (state == STOP);
    assign out_byte = data;

endmodule