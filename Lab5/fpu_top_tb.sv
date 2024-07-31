// Testbench for fpu_top

`timescale 1ns/1ns

module fpu_top_tb();

reg clk;
reg reset;
reg op_valid;
reg [1:0] op_type;
reg [15:0] a, b;
wire [15:0] result;
wire [4:0] flags;

fpu_top dut(
  .clk(clk),
  .reset(reset),
  .op_valid(op_valid),
  .op_type(op_type),
  .a(a),
  .b(b),
  .result(result),
  .flags(flags)
);

// Clock generation
initial begin
  clk = 0;
  forever #5 clk = ~clk;
end

// Stimulus
initial begin
  
  // Reset
  reset = 1; #10;
  reset = 0;
  
  // Test case 1
  op_valid = 1;
  op_type = 2'b00; // Add 
  a = 16'b0100000000000001; // 1.25
  b = 16'b0011111111111111; // 0.99
  #10;
  
  // Test case 2 
  op_valid = 1; 
  op_type = 2'b01; // Subtract
  a = 16'b0100000000000100; // 4
  b = 16'b0011111111111110; // -2
  #10;

  // Other test cases...
  
  $finish;
end

endmodule