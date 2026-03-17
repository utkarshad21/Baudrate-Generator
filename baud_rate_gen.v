`timescale 1ns / 1ps
//
// Engineer: Utkarsha
// Project Name: Baudrate Generator
//
// Description: 
// Baud rate Generator converts fast clock to slow timing.
// Formula to Generate Baud Rate:
// Divider = Clock Frequency / Baud Rate
// Baudrate = Clock Frequency / Divider
// 
// Most UART designs support these standard baud rates:
// Taking clock as 100 MHz
//  Baud Rate   Divider  
//  9600        10416    
//  19200       5208     
//  38400       2604     
//  57600       1736     
//  115200      868      
//
// If we count Divider clock cycles, we get 1 bit time.
// If divider is 868, then 868 clock cycles = 1 UART bit
// UART expected bit time: 1 / 115200 = 8.68 us
//

module baud_rate_gen
(
input clk,
input reset,
input [2:0] baud_sel,
output reg baud_tick
);

reg [13:0] divider;
reg [13:0] count;

localparam BAUD_9600   =  3'b000,
           BAUD_19200  =  3'b001,
           BAUD_38400  =  3'b010,
           BAUD_57600  =  3'b011,
           BAUD_115200 =  3'b100;

always@(*)
begin
    case(baud_sel)
        BAUD_9600: divider = 14'd10416; // for baudrate 9600
        BAUD_19200: divider = 14'd5208; // for baudrate 19200
        BAUD_38400: divider = 14'd2604; // for baudrate 38400 
        BAUD_57600: divider = 14'd1736; // for baudrate 57600 
        BAUD_115200: divider = 14'd868; // for baudrate 115200 
        default: divider = 14'd10416; // for baudrate 9600
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) 
    begin
        count <= 0;
        baud_tick <= 0;
    end
    else if (count == divider - 1) 
    begin
        count <= 0;
        baud_tick <= 1;
    end
    else 
    begin
        count <= count + 1;
        baud_tick <= 0;
    end
end

endmodule
