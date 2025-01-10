`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2025 11:23:14 PM
// Design Name: 
// Module Name: piso
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


module piso(shift,load,rst,clk,data_in,data_out);
    input shift,load,rst,clk;
    input [7:0]data_in;
    output reg data_out;
    
    reg [7:0]register;
    
    always @(posedge clk or negedge rst)begin
        if(!rst)begin
            data_out <=0;                   //reset state
        end
        else if(load)begin
            register <= data_in;            //loading data into PISO register
        end
        else if(shift)begin
            data_out <= register[0];        //reading data from PISO register
            register <= register >> 1'b1;   //shifting the data in PISO register
        end
    end
endmodule
