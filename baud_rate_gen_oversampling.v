`timescale 1ns / 1ps
//
// Engineer: Utkarsha
// Project Name: Baudrate Generator
//
// Description: 
//In UART communication the receiver does not share the same clock as the transmitter.
//Both devices only agree on the baud rate, but their clocks may have small errors.
//Example:
//Transmitter baud = 115200
//Receiver baud ? 115100
//This small difference causes sampling errors over time.
//Problem Without Oversampling
//If the receiver samples exactly once per bit, and the clocks are slightly different:
//Sampling may occur near the edge of the bit
//Noise or jitter can cause wrong bit detection
//
// Instead of sampling once per bit, the receiver samples multiple times per bit.
//Most UARTs use 16× oversampling.
//
// Sampling each UART bit many times (usually 16×) to accurately detect the bit value even if clocks are slightly mismatched or noise is present.
//
// To support 16× oversampling, your baud generator must generate a tick that is 16 times faster than the baud rate.
//
// Baud rate generator with 16x oversampling
// Oversample Tick = BaudRate × 16
// Divider = Clock / (BaudRate × 16)
//
// Baud Rate  Divider (100MHz / (baud×16)) 
// 9600       651                          
// 19200      326                          
// 38400      163                          
// 57600      108                          
// 115200     54                           
//

module baud_rate_gen_oversampling(
input clk,
input reset,
input [2:0] baud_sel,
output reg oversample_tick
);

reg [13:0] divider;
reg [13:0] count;

localparam BAUD_9600   = 3'b000,
           BAUD_19200  = 3'b001,
           BAUD_38400  = 3'b010,
           BAUD_57600  = 3'b011,
           BAUD_115200 = 3'b100;

always @(*)
begin
    case(baud_sel)
        BAUD_9600   : divider = 14'd651;  // 100M / (9600*16)
        BAUD_19200  : divider = 14'd326;  // 100M / (19200*16)
        BAUD_38400  : divider = 14'd163;  // 100M / (38400*16)
        BAUD_57600  : divider = 14'd108;  // 100M / (57600*16)
        BAUD_115200 : divider = 14'd54;   // 100M / (115200*16)
        default     : divider = 14'd651;
    endcase
end

always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        count <= 0;
        oversample_tick <= 0;
    end
    else if (count >= divider-1)
    begin
        count <= 0;
        oversample_tick <= 1;
    end
    else
    begin
        count <= count + 1;
        oversample_tick <= 0;
    end
end

endmodule
