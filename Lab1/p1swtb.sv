`timescale 1ps/1ps

module p1swtb; // header for our software testbench, this is use to test the behavior of p1.sv module
//the expected behavior is defined in the README.md file
//////////////////////////////////////////

logic clk, rst, en;

always #5 clk = ~clk; // clock generator

//testbench input
logic CLOCK_50;
assign CLOCK_50 = clk;
logic KEY0;
assign KEY0 = en;
logic KEY2;
assign KEY2 = rst;
wire [6:0] HEX3, HEX2, HEX1, HEX0; //testbench out
wire LED0;

//testbench input
p1 dut
	(.CLOCK_50(CLOCK_50),
  .KEY0(KEY0),
  .KEY2(KEY2),
  .LED0(LED0),
  .HEX3(HEX3),
  .HEX2(HEX2), //testbench out
  .HEX1(HEX1),
  .HEX0(HEX0) //downstream out
     );

initial begin
    $display("Start testbench");
    clk = 0;
    rst = 0;
    en = 1;
    #100 rst = 1;
    #100 en = 0;
    #10000 en = 1;
    $display("Testbench finished, Check the output on Waveform");
    $display("If it is good, you should see at least two times that LED0 = 1");
    $display("1 is when the testbench begins, 2 is when the testbench ends");
    #1000 $finish;
end

initial begin //monitor LED 0
    $monitor("LED0 = %b", LED0);
end

//block to dump .vcd waveform file
initial begin
    $dumpfile("p1swtb.vcd");
    $dumpvars(0, p1swtb);
end

//////////////////////////////////////////
endmodule