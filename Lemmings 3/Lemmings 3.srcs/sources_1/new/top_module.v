`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2026 20:05:22
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
      reg walk_dir; // 0 = LEFT, 1 = RIGHT
localparam LEFT = 0,RIGHT = 1,FALLING = 2, DIGGING = 3;
    
    reg [1:0] state, next_state ;
    
    always @(*) begin
    case(state)

    LEFT:
        if(!ground)
            next_state = FALLING;
        else if(dig)
            next_state = DIGGING;
        else if(bump_left)
            next_state = RIGHT;
        else
            next_state = LEFT;

    RIGHT:
        if(!ground)
            next_state = FALLING;
        else if(dig)
            next_state = DIGGING;
        else if(bump_right)
            next_state = LEFT;
        else
            next_state = RIGHT;

    DIGGING:
        if(!ground)
            next_state = FALLING;
        else
            next_state = DIGGING;

    FALLING:
        if(ground)
            next_state = (walk_dir) ? RIGHT : LEFT;
        else
            next_state = FALLING;

    default:
        next_state = LEFT;
    endcase
  end
   

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_dir <= 0;
    end
    else begin
        if (state == LEFT)
            walk_dir <= 0;
        else if (state == RIGHT)
            walk_dir <= 1;

        state <= next_state;
    end
end
   
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign  aaah = (state == FALLING);
    assign digging = (state == DIGGING);
    
                    
                    
                    
endmodule
