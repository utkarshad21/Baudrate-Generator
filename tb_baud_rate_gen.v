`timescale 1ns / 1ps

module tb_baud_rate_gen;

reg clk;
reg reset;
reg [2:0] baud_sel;
wire baud_tick;

// Instantiate DUT (Device Under Test)

//baud_rate_gen DUT (
//    .clk(clk),
//    .reset(reset),
//    .baud_sel(baud_sel),
//    .baud_tick(baud_tick)
//);

baud_rate_gen_oversampling DUT (
    .clk(clk),
    .reset(reset),
    .baud_sel(baud_sel),
    .oversample_tick(baud_tick)
);

// Clock Generation (100 MHz)
// Period = 10 ns

initial begin
    clk = 0;
end

always #5 clk = ~clk;


// Test sequence

initial begin

    // Initialize
    reset = 1;
    baud_sel = 3'b000;

    #50;
    reset = 0;

    // Test 9600 baud
    baud_sel = 3'b000;
    #200000;

    // Test 19200 baud
    baud_sel = 3'b001;
    #200000;

    // Test 38400 baud
    baud_sel = 3'b010;
    #200000;

    // Test 57600 baud
    baud_sel = 3'b011;
    #200000;

    // Test 115200 baud
    baud_sel = 3'b100;
    #200000;

    $finish;

end

endmodule