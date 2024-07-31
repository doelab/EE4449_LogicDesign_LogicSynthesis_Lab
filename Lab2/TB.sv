`timescale 1ps/1ps

module TB;
  logic clock, resetN;
  logic disp_sel;

  logic [6:0] HEX_D[6];

  ChipInterface dut (.CLOCK_50(clock), .SW({disp_sel}), .KEY({resetN}),
                     .HEX5(HEX_D[5]), .HEX4(HEX_D[4]), .HEX3(HEX_D[3]),
                     .HEX2(HEX_D[2]), .HEX1(HEX_D[1]), .HEX0(HEX_D[0]));


  initial begin
    clock = 1'b0;

    forever #5 clock = ~clock;
  end

  initial begin
    #10000

    $display("@%0t: Error timeout!", $time);
    $finish;
  end

  initial begin
    disp_sel = 1'b0;

    resetN = 1'b1;
    resetN <= 1'b0;
    resetN <= #1 1'b1;

    @(posedge dut.done);

    $display("@%0t: Finished!", $time);
    $display("@%0t: The sum is %h", $time, dut.sum);

    #10;
    $finish;
  end

endmodule : TB
