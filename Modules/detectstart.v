`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 04:01:23 PM
// Design Name: 
// Module Name: detectstart
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


module detectstart(d_start_bit,data_in,clk);
    output reg d_start_bit;
    input data_in,clk;
    reg [3:0]bitcount = 0;
    
    always @(posedge clk)begin
        if(data_in == 1'b0)begin
            if(bitcount == 4'b1111)begin
                bitcount <= 4'b0000;
                d_start_bit <=1'b1;
            end
            else begin
                bitcount <= bitcount+1'b1;
                d_start_bit <= 1'b0;
            end
        end
        else begin
            bitcount <= 4'b0000;
            d_start_bit <= 1'b0;      
        end
    end    
endmodule
