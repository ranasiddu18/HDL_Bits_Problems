`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.06.2026 20:19:23
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
////////////////////////////////////////////////////////////////////////////////

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
); 
    reg [2:0] state, next_state;
    localparam L1 = 3'd1;  // below s1
    localparam L2 = 3'd2;   //rising from s2   between s2 & s1
    localparam L3 = 3'd3;   //falling from s2    between s2 & s1
    localparam L4 = 3'd4;   //rising from s2    between s3 & s2
    localparam L5 = 3'd5;   //falling from s3   between s3 & s2
    localparam L6 = 3'd6;  //all sensors on
    
    always@(posedge clk)
        begin
            if(reset) begin
                state <= L1;
                 end
            else begin
                state<= next_state; end
        end
    always@(*) begin
        case(state)
            L6: begin
                if(s==3'd7) begin
                    next_state = state ;
                end
                else if( s== 3'd3) begin
                    next_state = L5; 
                end
            end
            L5: begin
                if(s==3'd7)  begin
                    next_state = L6;
                end
                else if(s== 3'd3)  begin
                    next_state = state ;
                end
                else if(s==3'd1) begin
                    next_state = L3;
                end
            end
            L4: begin
                if(s==3'd7) begin
                    next_state = L6;
                end
                else if(s==3'd3) begin
                    next_state = state ;
                end
                else if( s==3'd1) begin
                    next_state = L3;
                end
            end
            L3 : begin
                if ( s==3'd3) begin
                    next_state = L4 ;
                end
                else if ( s== 3'd1) begin
                    next_state = state;
                end
                else if ( s== 3'd0) begin
                    next_state = L1;
                end
            end
            L2 : begin
                if( s==3'd3) begin
                    next_state = L4 ;
                end
                else if(s==3'd1) begin
                    next_state = state ;
                end
                else if ( s==3'd0) begin
                    next_state = L1 ;
                end
            end
            L1 : begin
                if( s== 3'd1) begin
                    next_state = L2; end
                else if(s==3'd0) begin
                    next_state = state; 
                end  
            end
        endcase
            end
    always@(*) begin
        case(state)
            L6: begin fr3=0; fr2=0;fr1=0; dfr = 0; end
            L5: begin fr3=0; fr2=0;fr1=1; dfr = 1; end
            L4: begin fr3=0; fr2=0;fr1=1; dfr = 0; end
            L3: begin fr3=0; fr2=1;fr1=1; dfr = 1; end
            L2: begin fr3=0; fr2=1;fr1=1; dfr = 0; end
            L1: begin fr3=1; fr2=1;fr1=1; dfr = 1; end
            endcase
    end
                
                    
endmodule
