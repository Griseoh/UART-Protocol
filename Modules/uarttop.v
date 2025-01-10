`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 07:45:42 PM
// Design Name: 
// Module Name: uarttop
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


module uarttop(stop_err,parity_err,data_out,sel,tx_start,data_in,clk,rst);
    output stop_err,parity_err;
    output [7:0]data_out;
    input tx_start,clk,rst;
    input [1:0]sel;
    input [7:0]data_in;
    
    wire tx_data_out,clk_out;
    
    uarttxtop tx0(tx_data_out,clk_out,rst,tx_start,data_in);
    uartrxtop rx0(stop_err,data_out,tx_data_out,clk_out,rst,parity_err);
    uartbaudgen bg0(clk_out,clk,sel,rst);
    
endmodule
