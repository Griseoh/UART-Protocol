`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 06:18:23 PM
// Design Name: 
// Module Name: sipo
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


module sipo(data_out,data_in,shift,clk,rst);
    output [7:0]data_out;
    input data_in,clk,rst,shift;
    
    reg [7:0]register;
    
    assign data_out = register;
    
    always @(posedge clk or negedge rst)begin
        if(!rst)begin
            register <= 0; 
        end
        else begin
            if(shift)begin
                register <= register >> 1'b1;
                register[7] <= data_in;
            end
            else begin
                register <= register;
            end
        end
    end
    
endmodule
