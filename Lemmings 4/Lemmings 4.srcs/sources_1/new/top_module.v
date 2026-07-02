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
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    localparam WL = 3'd0,
               WR = 3'd1,
               FL = 3'd2,
               FR = 3'd3,
               DL = 3'd4,
               DR = 3'd5,
               SP = 3'd6;

    reg [2:0] state, next_state;
    reg [4:0] fall_count;

    //==========================
    // State register & counter
    //==========================
   always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WL;
        fall_count <= 0;
    end
    else begin
        state <= next_state;

        // Falling counter
        if ((state==FL || state==FR) && !ground)
            fall_count <= fall_count + 1;
        else if (next_state==FL || next_state==FR)
            fall_count <= 0;      // Just started falling
        else
            fall_count <= 0;
    end
end

    //==========================
    // Next-state logic
    //==========================
    always @(*) begin
        case(state)

        //----------------------
        // Walk Left
        //----------------------
        WL:
            if (!ground)
                next_state = FL;
            else if (dig)
                next_state = DL;
            else if (bump_left)
                next_state = WR;
            else
                next_state = WL;

        //----------------------
        // Walk Right
        //----------------------
        WR:
            if (!ground)
                next_state = FR;
            else if (dig)
                next_state = DR;
            else if (bump_right)
                next_state = WL;
            else
                next_state = WR;

        //----------------------
        // Dig Left
        //----------------------
        DL:
            if (!ground)
                next_state = FL;
            else
                next_state = DL;

        //----------------------
        // Dig Right
        //----------------------
        DR:
            if (!ground)
                next_state = FR;
            else
                next_state = DR;

        //----------------------
        // Fall Left
        //----------------------
        FL:
            if(ground) begin
             if (fall_count >= 20)
               next_state = SP;
             else
               next_state = WL;
            end
            else
                next_state = FL;

        //----------------------
        // Fall Right
        //----------------------
        FR:
            if (ground) begin
                if (fall_count >= 20)
                   next_state = SP;
                else
                   next_state = WL;
            end
            else
                next_state = FR;

        //----------------------
        // Splatter
        //----------------------
        SP:
            next_state = SP;

        default:
            next_state = WL;

        endcase
    end

    //==========================
    // Outputs
    //==========================
    assign walk_left  = (state == WL);
    assign walk_right = (state == WR);

    assign aaah = (state == FL) || (state == FR);

    assign digging = (state == DL) || (state == DR);

endmodule
