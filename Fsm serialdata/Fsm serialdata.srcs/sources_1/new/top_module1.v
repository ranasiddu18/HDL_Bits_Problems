`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2026 22:15:24
// Design Name: 
// Module Name: top_module1
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



module top_module1(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);

    // Pragmatic naming: 'DATA_RECV' replaces the conceptually misleading 'start'
    localparam IDLE = 2'd0, DATA_RECV = 2'd1, STOP = 2'd2, ERROR = 2'd3;
    
    reg [1:0] state, next_state;
    reg [3:0] count;  // 4 bits is exactly what we need to count to 8 (no wasted FF area)
    reg [7:0] data;

    // 1. Next-State Combinational Logic
    always @(*) begin
        case (state)
            IDLE: begin
                // A start bit is a low level (~in) on the line
                next_state = (~in) ? DATA_RECV : IDLE;
            end
            DATA_RECV: begin
                // Stay in DATA_RECV for 8 data cycles (count 0 through 7).
                // When count == 8, wire 'in' is actively holding the STOP bit.
                if (count == 4'd8) begin
                    if (in)
                        next_state = STOP;   // Valid stop bit (1) detected
                    else
                        next_state = ERROR;  // Framing error (stop bit missing/0)
                end
                else begin
                    next_state = DATA_RECV;
                end
            end
            STOP: begin
                // The byte is valid. Next cycle could immediately be a new start bit (~in) or back to IDLE.
                next_state = (~in) ? DATA_RECV : IDLE;
            end
            ERROR: begin
                // Wait until the serial line recovers to high (idle) before hunting for a new start bit
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
        // BLIND SPOT FIX: Only shift during the 8 actual data bit cycles (count 0 to 7).
        // When count == 8, we are sampling the stop bit; do NOT shift it into data!
        else if (state == DATA_RECV && count <= 4'd7) begin
            data <= {in, data[7:1]}; // LSB first protocol: shift right, insert at MSB
        end
    end

    // 4. Output Assignments
    assign done = (state == STOP);
    assign out_byte = data;

endmodule



 