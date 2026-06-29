`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2026 17:21:26
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
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah );

    parameter LEFT = 0, RIGHT = 1, FALLING = 2;
    reg [1:0] state, next_state, prev_state;

    // Combinational next-state logic (NO prev_state assignment here)
    always @(*) begin
        case(state)
            LEFT: begin
                if (~ground)        next_state = FALLING;
                else if (bump_left) next_state = RIGHT;
                else                next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)         next_state = FALLING;
                else if (bump_right) next_state = LEFT;
                else                 next_state = RIGHT;
            end
            FALLING: begin
                if (~ground) next_state = FALLING;
                else         next_state = prev_state; // use registered prev_state
            end
            default: next_state = LEFT;
        endcase
    end

    // Sequential state register + prev_state update
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state      <= LEFT;
            prev_state <= LEFT;
        end else begin
            state <= next_state;
            // Only update prev_state when NOT already falling
            if (state != FALLING)
                prev_state <= state;
        end
    end

    // Output logic
    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == FALLING);

endmodule
