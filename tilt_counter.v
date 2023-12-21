module tilt_counter(
  input clk,
  input reset_n,
  input tilt_x,
  output reg [31:0] count
);

reg [31:0] count_reg;
wire tilt_counter_done;

tilt_counter #(
  .FREQ(50_000_000), // 50 MHz clock
  .WIDTH(32)         // 32-bit counter
) counter_inst (
  .clk(clk),
  .reset_n(reset_n),
  .start(tilt_x),
  .done(tilt_counter_done),
  .count(tilt_counter)
);

always @(posedge clk or negedge reset_n) begin
  if (~reset_n) begin
    count_reg <= 0;
  end else if (tilt_counter_done) begin
    count_reg <= tilt_counter;
  end
end

assign count = count_reg;

endmodule