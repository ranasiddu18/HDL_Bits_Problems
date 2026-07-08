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
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging ); 
    
    reg [2:0] state ,next_state;
    localparam LEFT = 0, RIGHT = 1, DIG_L=2, DIG_R=3, FALL_L=4, FALL_R=5, SPLAT=6;
    reg [4:0] count;
    
    always@(*)
        begin
            case(state)
                LEFT: begin
                    if(~ground)
                        next_state = FALL_L;
                    else if(dig)
                        next_state = DIG_L;
                    else if(bump_left)
                        next_state = RIGHT;
                    else
                        next_state = state;
                end
                RIGHT : begin
                     if(~ground)
                        next_state = FALL_R;
                    else if(dig)
                        next_state = DIG_R;
                    else if(bump_right)
                        next_state = LEFT;
                    else
                        next_state = state;
                end
                DIG_L : begin
                    if(~ground)
                        next_state = FALL_L;
                    else
                        next_state = state;
                end
                DIG_R : begin
                     if(~ground)
                        next_state = FALL_R;
                    else
                        next_state = state;
                end
                FALL_L: begin
                    if(count>21) begin
                        if(ground) begin
                            next_state = SPLAT; end
                        else
                            next_state = state; end
                    else begin
                        if(ground) begin
                            next_state = LEFT; end
                        else 
                            next_state = state; end
                end
                FALL_R : begin
                    if(count>21) begin
                        if(ground) begin
                            next_state = SPLAT; end
                        else
                            next_state = state; end
                    else begin
                        if(ground) begin
                            next_state = RIGHT; end
                        else 
                            next_state = state; end
                end
                SPLAT : 
                    next_state= state;
                default : 
                    next_state = LEFT;
                
            endcase
        end
    always@(posedge clk or posedge areset) begin
        
    if(areset) begin
        count <= 0;
        state <= LEFT; end
    else 
        state <= next_state;
    if(state == FALL_L | FALL_R)
        count <= count +1 ;
    else if ( (state == FALL_L | FALL_R) && (next_state != FALL_L | FALL_R))
        count <= 0;
    end
    
   
    always@(*)
        begin
            if(state == SPLAT) begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0; end
            else begin
                walk_left = (state == LEFT);
                walk_right = (state == RIGHT);
                aaah = (state == FALL_L || state == FALL_R);
                digging = (state == DIG_L || state == DIG_R);
            end
        end
    
endmodule

/* module top_module(
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



//// 2nd  Code
module top_module(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    localparam LEFT     = 3'd0,
               RIGHT    = 3'd1,
               FALLING  = 3'd2,
               DIGGING  = 3'd3,
               SPLATTER = 3'd4;

    reg [2:0] state, next_state;
    reg [4:0] count;
    reg walk_dir; // 0 = LEFT, 1 = RIGHT

   // Sequential block
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state    <= LEFT;
        walk_dir <= 0;
        count    <= 0;
    end else begin
        state <= next_state;

        // Capture walking direction ONLY when walking
        if (next_state == LEFT)
            walk_dir <= 0;
        else if (next_state == RIGHT)
            walk_dir <= 1;

        else begin  // Count ONLY when currently in FALLING state
        if(state != FALLING && next_state == FALLING)
          count <= 0;          // entering falling
        else if(state == FALLING)
          count <= count + 1;
        else
          count <= 0;  end // Reset count whenever not falling
    end
end

// Next state logic (combinational)
always @(*) begin
    case(state)
        LEFT: begin
            if (!ground)
                next_state = FALLING;
            else if (dig)
                next_state = DIGGING;
            else if (bump_left)
                next_state = RIGHT;
            else
                next_state = LEFT;
        end

        RIGHT: begin
            if (!ground)
                next_state = FALLING;
            else if (dig)
                next_state = DIGGING;
            else if (bump_right)
                next_state = LEFT;
            else
                next_state = RIGHT;
        end

        DIGGING: begin
            if (!ground)
                next_state = FALLING;
            else
                next_state = DIGGING;
        end

        FALLING: begin
            if (ground) begin
                // count already reflects cycles spent falling
                if (count > 5'd20)   // >20 means 21st cycle causes splat
                    next_state = SPLATTER;
                else
                    next_state = walk_dir ? RIGHT : LEFT;
            end else begin
                next_state = state;
            end
        end

        SPLATTER: 
                next_state = state;

        default:
            next_state = LEFT;
    endcase
end

// Output logic
always @(*) begin
    walk_left  = (state == LEFT);
    walk_right = (state == RIGHT);
    aaah       = (state == FALLING);
    digging    = (state == DIGGING);

    if (state == SPLATTER) begin
        walk_left  = 0;
        walk_right = 0;
        aaah       = 0;
        digging    = 0;
    end
end

endmodule */
