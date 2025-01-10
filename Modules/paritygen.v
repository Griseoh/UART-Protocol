`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2025 11:35:43 PM
// Design Name: 
// Module Name: paritygen
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


module paritygen(pbit,load,data_in);
    input load;
    input [7:0]data_in;
    output reg pbit;
    
    always @(*)begin
        if(load) pbit = ^data_in;
        else pbit = 1'b0;
    end
endmodule
