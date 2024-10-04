module murmann_group_top(clk, reset);
  input clk, reset;
 

endmodule


module gated_clock(clk, reset, ADC_bit, gated_clock_bit);
  input ADC_bit, clk, reset;
  output gated_clock_bit;
  
  if (reset)
    assign gated_clock_bit = 0;
  
  else
    assign gated_clock_bit = ( clk & ADC_bit );
  

endmodule

module accumulator(gated_bit, clk, reset, bit_outstream);
  input clk, reset;
  input gated_bit
  output [15:0] bit_outstram;
  
  //Every positive edge of the clock
  always@(posedge clk) 
  begin
    if(reset)    //Set Counter to Zero
      count <= 0;
    else if(load)    //load the counter with data value
      count <= data;
    else if(up_down)        //count up
      count <= count + 1;
    else            //count down
      count <= count - 1;
  end
  
endmodule
