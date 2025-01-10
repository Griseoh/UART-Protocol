`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 06:28:31 PM
// Design Name: 
// Module Name: paritycheck
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


module paritycheck(parity_err,parity_load,data_in,rx_data);
    output reg parity_err;
    input [7:0]data_in;
    input rx_data,parity_load;
    
    always @(*)begin
        if(parity_load)begin
            if(rx_data == (^data_in))begin
                parity_err = 1'b0; 
            end
            else begin
                parity_err = 1'b1;
            end
        end
        else begin
            parity_err = 1'b0;
        end
    end
endmodule
