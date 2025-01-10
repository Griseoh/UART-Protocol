`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2025 11:40:12 PM
// Design Name: 
// Module Name: tx_fsm
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


module tx_fsm(sel,load,shift,clk,rst,tx_start,tx_busy);
    output reg load,shift,tx_busy;
    output reg [1:0]sel;
    input clk,rst,tx_start;
    
    reg [2:0] bitcounter;
    reg [3:0] counter;
    reg bitcount,state_flag;
    reg [2:0] state, next_state;
    parameter IDLE = 3'b000, START_BIT = 3'b001, DATA_BIT = 3'b010;
    parameter PARITY_BIT = 3'b011, STOP_BIT = 3'b100;
    
    always@(*)begin                                                             //State Machine for Control Signals of TX
        load = 1'b0;
        shift = 1'b0;
        sel = 2'b11;
        tx_busy = (state != IDLE);
        
        case (state)
            IDLE:begin
              next_state = tx_start ? START_BIT:IDLE;
              load = 1'b0;
              shift = 1'b0;
              sel = 2'b11;
              tx_busy = 1'b0;
            end
            START_BIT:begin
                next_state = state_flag ? DATA_BIT:START_BIT;
                load = 1'b1;
                shift = 1'b0;
                sel = 2'b00;
                tx_busy = 1'b1;
            end
            DATA_BIT:begin
                next_state = bitcount ? PARITY_BIT:DATA_BIT;
                load = 1'b0;
                shift = 1'b1;
                sel = 2'b01;
                tx_busy = 1'b1;
            end
            PARITY_BIT:begin
                next_state = state_flag ? STOP_BIT:PARITY_BIT;
                load = 1'b0;
                shift = 1'b1;
                sel = 2'b10;
                tx_busy = 1'b1;
            end
            STOP_BIT:begin
                next_state = state_flag ? IDLE:STOP_BIT;
                load = 1'b0;
                shift = 1'b0;
                sel = 2'b11;
                tx_busy = 1'b1;
            end
            default:begin
                next_state = 3'b000;
                load = 1'b0;
                shift = 1'b0;
                sel = 2'b11;
                tx_busy = 1'b0;
            end
        endcase
    end
    
    always @(posedge clk)begin                                                  //Counting data bits in DATA_BIT state 
        if(state == DATA_BIT)begin
            if(bitcounter == 3'b111)begin
                bitcount <= 1'b1;
                bitcounter <= 3'b000;
            end
            else begin
                bitcount <=1'b0;
                bitcounter <= bitcounter +1'b1;
            end
        end
        else begin
            bitcount <= 1'b0;
        end
    end
    
    always @(posedge clk)begin                                                  //Counting Baud ticks to set state flag
            if(counter == 4'b1111)begin
                state_flag <= 1'b1;
                counter <=4'b0000; 
            end
            else begin
                state_flag <= 1'b0;
                counter <= counter +1'b1;
            end
    end
    
    always @(posedge clk or negedge rst)begin                                   //Initializing the complete FSM 
        if(~rst)begin
            state <= IDLE;
            bitcounter <= 3'b000;
            counter <= 4'b0000;
        end
        else begin
            state <= next_state;
        end
    end
endmodule
