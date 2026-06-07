`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.06.2026 15:42:15
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
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
     always@(posedge clk)
         begin
             if(reset) begin
                 pm<=0;
                 hh<=8'h12;
                 mm<=8'h00;
                 ss<=8'h00; end
             else if(ena) begin
                 
                 if(ss[7:4]==4'h05 && ss[3:0]==4'h09) begin
                     mm[3:0]<=mm[3:0]+1; ss<=8'h00; end
                 else if(ss[7:4]!=4'h05 && ss[3:0]==4'h09) begin
                     ss[7:4]<= ss[7:4]+1; ss[3:0]<=4'h00; end
             else  begin
                   ss[3:0]<=ss[3:0]+1; end
                 
                
                 if(ss[7:4]==4'h05 && ss[3:0]==4'h09) begin
                     
                     
                     if(mm[3:0]!=4'd09) begin
                          mm[3:0] <= mm[3:0]+1; end
                     else if(mm[7:4]!=4'd05 && mm[3:0]==4'd09) begin
                        mm[7:4]<= mm[7:4]+1; mm[3:0]<=4'h00; end
                     else if(mm[7:4]==4'd05 && mm[3:0]==4'd09) begin
                         mm<=8'h00;
                 end
                         
           /*  else  begin
                 mm[3:0]<=mm[3:0]+1; end*/
                 
                 if(mm[7:4] == 4'h05 && mm[3:0] == 4'h09) begin
                   
                      
                     if(hh[7:4]==4'h01 && hh[3:0]==4'h02) begin
                     hh<=8'h01; end
                    else if(hh[3:0]!=4'd09) begin
                         hh[3:0] <= hh[3:0]+1;hh[7:4]<=hh[7:4]; end
                     else if (hh[3:0]==4'h09) begin
                         hh[7:4]<=4'h01; hh[3:0] <= 4'h00; end
                /* else  begin
                     hh[7:4] <= hh[7:4] +1;
                     hh[3:0] <= hh[3:0]+1; end end */ end
                 
                     if(hh[7:4] == 4'h01 && hh[3:0] == 4'h01 && mm[7:4] == 4'h05 && mm[3:0] == 4'h09 && ss[7:4] == 4'h05 && ss[3:0] == 4'h09) begin
                     pm<=~pm; end
             end 
         end
         end
endmodule