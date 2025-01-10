`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 06:51:24 PM
// Design Name: 
// Module Name: rx_fsm
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


module rx_fsm(shift,parity_load,check_stop,clk,rst,d_start_bit,parity_err);
    output reg shift,parity_load,check_stop;
    input clk,rst,d_start_bit,parity_err;
    
    reg[2:0]bitcounter;
    reg[3:0]counter;
    reg bitcount,state_flag;
    reg [1:0] state, next_state;
    parameter IDLE = 2'b00, DATA_BIT = 2'b01, PARITY_BIT = 2'b10, STOP_BIT = 2'b11;
    
    always @(*)begin                                                            //State Machine for control signals of RX
        parity_load = 1'b0;
        check_stop = 1'b0;
        shift = 1'b0;
        
        case (state)
            IDLE : begin
                next_state = d_start_bit ? DATA_BIT:IDLE;
                shift = 1'b0;
                parity_load = 1'b0;
                check_stop = 1'b0;    
            end
            DATA_BIT : begin
               next_state = bitcount ? PARITY_BIT:DATA_BIT;
               shift = 1'b1;
               parity_load = 1'b0;
               check_stop = 1'b0;    
            end
            PARITY_BIT : begin
                next_state = parity_err ? IDLE:(state_flag ? STOP_BIT:PARITY_BIT);
                shift = 1'b0;
                parity_load = 1'b1;
                check_stop = 1'b0; 
            end
            STOP_BIT : begin
                next_state = state_flag ? IDLE:STOP_BIT;
                shift = 1'b0;
                parity_load = 1'b0;
                check_stop = 1'b1;
            end
            default : begin
                next_state = IDLE;
                shift = 1'b0;
                parity_load = 1'b0;
                check_stop = 1'b0;
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
