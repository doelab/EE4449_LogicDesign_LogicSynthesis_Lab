// Lab 5 top level for 16-bit IEEE 754 FPU

module fpu_top (
  input         clk,
  input         reset,
  input         op_valid,
  input  [1:0]  op_type, // 00 - Add, 01 - Subtract, 10 - Multiply, 11 - Divide
  input  [18:0] a,
  input  [18:0] b,
  output [18:0] result,
  output [4:0]  flags 
);

// FPU flags  
// flags[4] - invalid operation
// flags[3] - divide by zero
// flags[2] - overflow
// flags[1] - underflow
// flags[0] - inexact rounding


///////////
endmodule