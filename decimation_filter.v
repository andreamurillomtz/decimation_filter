module murmann_group_top(clk, gated_clock_reset, accumulator_reset, ADC_bit, counter, bit_outstream);
  input wire ADC_bit, clk, gated_clock_reset;
  wire gated_clock_bit;
  input wire accumulator_reset;

  output wire [15:0] counter;
  output reg [15:0] bit_outstream;
  
  gated_clock my_gated_clock( .clk(clk),
                             .reset(gated_clock_reset),
                             .ADC_bit(ADC_bit),
                             .gated_clock_bit(gated_clock_bit)
                            );
                         
  accumulator my_accumulator( .clk(clk),
                             .reset(accumulator_reset),
                             .gated_clock_bit(gated_clock_bit),
                             .counter(counter),
                             .bit_outstream(bit_outstream)
                            );

endmodule

module gated_clock(clk, reset, ADC_bit, gated_clock_bit);
  input wire ADC_bit, clk, reset;
  output reg gated_clock_bit;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      gated_clock_bit <= 0;
    end 
    else begin
      gated_clock_bit <= ADC_bit;
    end
  end
endmodule

module accumulator(clk, reset, gated_clock_bit, counter, bit_outstream);
  input wire clk, reset;
  input gated_clock_bit;
  output reg [15:0] counter;
  output reg [15:0] bit_outstream;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      bit_outstream <= 0;  // Reset bit_outstream and counter
      counter <= 0;
    end
    else if (gated_clock_bit) begin
      counter <= counter + 1;
      bit_outstream <= counter;  // Update bit_outstream with counter value
    end
  end
endmodule
