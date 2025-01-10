`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2025 11:08:31 PM
// Design Name: 
// Module Name: mux4x1
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


module mux4x1(sel,PISO,ParityGen,TxDataOut);
    input PISO,ParityGen;
    input [1:0]sel;
    output reg TxDataOut;
    
    wire StartBit,StopBit;
    
    assign StartBit = 1'b0;
    assign StopBit = 1'b1;
    
    always @(sel)begin
        case (sel)
            2'b00 : TxDataOut = StartBit; 
            2'b01 : TxDataOut = PISO;
            2'b10 : TxDataOut = ParityGen;
            2'b11 : TxDataOut = StopBit;
            default : TxDataOut = StopBit;
        endcase
    end
endmodule
