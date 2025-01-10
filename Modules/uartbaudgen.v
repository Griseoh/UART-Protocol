`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2025 08:11:28 PM
// Design Name: 
// Module Name: uartbaudgen
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


module uartbaudgen(clk_out,clk,sel,rst);
    input[1:0]sel;
    input clk,rst;
    output reg clk_out;
    
    reg [11:0]temp;
    reg [11:0]count;
    
    always @(sel)begin
        case (sel)
            2'b00: temp <= 12'h146;             //Baud Rate divisor values 
            2'b01: temp <= 12'h01b;             // Divisor = Fclk/(Oversampling Factor x Fbaud)
            2'b10: temp <= 12'h051;             // We take a 50 MHz clock frequency
            2'b11: temp <= 12'h146;             // 146 - 9600 | 01b - 115200 | 051 - 38400
            default: temp <= 12'h146;
        endcase
    end
    
    always @(posedge clk or negedge rst) begin
        if(!rst)begin 
            clk_out <= 0;
            count <=0;
        end
        else if(count == temp-1)begin
            count <= 0;
            clk_out <= ~clk_out;
        end
        else begin
            count <= count+1;
            clk_out <= ~clk_out;
        end
    end
endmodule
