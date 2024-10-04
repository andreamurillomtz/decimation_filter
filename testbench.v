`include "decimation_filter.v"

module murmann_group_top_tb;

  // Testbench signals
  reg clk;
  reg gated_clock_reset;
  reg accumulator_reset;
  reg ADC_bit;
  
  wire [15:0] counter;
  wire [15:0] bit_outstream;

  // Instantiate the DUT (Design Under Test)
  murmann_group_top dut (
    .clk(clk),
    .gated_clock_reset(gated_clock_reset),
    .accumulator_reset(accumulator_reset),
    .ADC_bit(ADC_bit),
    .counter(counter),
    .bit_outstream(bit_outstream)
  );

  // Clock generation: 10ns period (100 MHz clock)
  always begin
    #5 clk = ~clk;  // Toggle clock every 5 ns
  end

  // Initial block to apply the stimulus
  initial begin
    // Initialize signals
    clk = 0;
    gated_clock_reset = 1;  // Start with reset asserted
    accumulator_reset = 1;  // Start with reset asserted
    ADC_bit = 0;

    // Apply stimulus
    #10;  // Wait for 10 ns

    // Deassert resets
    gated_clock_reset = 0;
    accumulator_reset = 0;

    // Apply ADC_bit = 1 (Gating the clock)
    #10;
    ADC_bit = 1;

    // Wait for some clock cycles
    #50;

    // Change ADC_bit to 0
    ADC_bit = 0;

    // Wait for some more clock cycles
    #50;

    // Reset the accumulator again
    accumulator_reset = 1;
    #10;
    accumulator_reset = 0;

    // Keep running for 100 ns
    #100;

    // End simulation
    $stop;
  end

  // Monitor the outputs for debugging
  initial begin
    $monitor("Time: %0t | Reset: %b | ADC_bit: %b | Counter: %h | Bit_outstream: %h", 
             $time, accumulator_reset, ADC_bit, counter, bit_outstream);
  end
endmodule
