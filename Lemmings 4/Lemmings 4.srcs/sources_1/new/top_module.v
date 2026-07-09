`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2026 21:26:46
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
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    reg [2:0] state, next_state;
    localparam LEFT = 0, RIGHT = 1, DIG_L = 2, DIG_R = 3, FALL_L = 4, FALL_R = 5, SPLAT = 6;
    reg [4:0] count;
    
    always @(*) begin
        next_state = state;
        case(state)
            LEFT: begin
                if (~ground)
                    next_state = FALL_L;
                else if (dig)
                    next_state = DIG_L;
                else if (bump_left)
                    next_state = RIGHT;
            end
            RIGHT: begin
                 if (~ground)
                    next_state = FALL_R;
                else if (dig)
                    next_state = DIG_R;
                else if (bump_right)
                    next_state = LEFT;
            end
            DIG_L: begin
                if (~ground)
                    next_state = FALL_L;
            end
            DIG_R: begin
                 if (~ground)
                    next_state = FALL_R;
            end
            FALL_L: begin
                if (ground) begin
                    if (count > 20)
                        next_state = SPLAT;
                    else
                        next_state = LEFT;
                end
            end
            FALL_R: begin
                if (ground) begin
                    if (count > 20)
                        next_state = SPLAT;
                    else
                        next_state = RIGHT;
                end
            end
            SPLAT: begin
                next_state = state;
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            count <= 5'd0;
        end else begin
            state <= next_state;
            
            if (next_state == FALL_L || next_state == FALL_R) begin
                if (state == FALL_L || state == FALL_R) begin
                    // Saturate the counter at 21 to prevent overflow on massive falls
                    if (count < 5'd21)
                        count <= count + 5'd1;
                end else begin
                    count <= 5'd1; 
                end
            end else begin
                count <= 5'd0;
            end
        end
    end

    // Pragmatic continuous assignments instead of an unnecessary always block
    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == FALL_L) || (state == FALL_R);
    assign digging    = (state == DIG_L)  || (state == DIG_R);

endmodule