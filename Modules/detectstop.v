`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 03:32:50 PM
// Design Name: 
// Module Name: detectstop
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


module detectstop(stop_err,data_out,check_stop,data_in,rx_data,clk);
    output reg stop_err;
    output reg [7:0] data_out;
    input data_in,check_stop,clk;
    input [7:0]rx_data;
    
    reg [3:0]count = 0;
    
    always @ (posedge clk) begin
        if(check_stop == 1'b1)begin
            if(data_in)begin
                if(count == 4'b1111)begin
                    count <= 4'b0000;
                    stop_err <= 1'b0;
                    data_out <= rx_data;
                end
                else begin
                    count <= count +1'b1;
                end
            end
            else begin
                stop_err <= 1'b1;
                data_out <= 8'h00;
            end
        end
        else begin
            stop_err <= 1'b0;
            data_out <= rx_data;
        end
    end
endmodule