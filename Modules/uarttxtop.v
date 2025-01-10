`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 03:06:41 PM
// Design Name: 
// Module Name: uarttxtop
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


module uarttxtop(data_out,clk,rst,tx_start,data_in,tx_busy);
    output data_out,tx_busy;
    input tx_start,clk,rst;
    input [7:0]data_in;
    
    wire shift,load,DATA_BIT,PARITY_BIT;
    wire [1:0]sel;
    
    tx_fsm f0(sel,load,shift,clk,rst,tx_start,tx_busy);
    piso p0(shift,load,rst,clk,data_in,DATA_BIT);
    paritygen pg0(PARITY_BIT,load,data_in);
    mux4x1 m0(sel,DATA_BIT,PARITY_BIT,data_out);
endmodule
