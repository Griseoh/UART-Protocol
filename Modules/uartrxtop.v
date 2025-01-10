`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 07:25:34 PM
// Design Name: 
// Module Name: uartrxtop
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


module uartrxtop(stop_err,data_out,data_in,clk,rst,parity_err);
    output [7:0]data_out;
    output stop_err,parity_err;
    input data_in,clk,rst;
    
    wire shift,parity_load,parity_err,check_stop,d_start_bit;
    wire [7:0]rx_data;
    
    detectstart dstrt0(d_start_bit,data_in,clk);
    detectstop dstp0(stop_err,data_out,check_stop,data_in,rx_data,clk);
    paritycheck pc0(parity_err,parity_load,data_in,rx_data);
    sipo s0(rx_data,data_in,shift,clk,rst);
    rx_fsm f0(shift,parity_load,check_stop,clk,rst,d_start_bit,parity_err);
    
endmodule
