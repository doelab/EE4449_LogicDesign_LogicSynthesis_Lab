`timescale 1ps/1ps

module bcdtohex
  (
    input logic [3:0] bcd,
   output logic [6:0] segment
   );

  always_comb begin
    unique case(bcd)
      4'd0: segment = 7'b1000000;
      4'd1: segment = 7'b1111001;
      4'd2: segment = 7'b0100100;
      4'd3: segment = 7'b0110000;
      4'd4: segment = 7'b0011001;
      4'd5: segment = 7'b0010010;
      4'd6: segment = 7'b0000010;
      4'd7: segment = 7'b1111000;
      4'd8: segment = 7'b0000000;
      4'd9: segment = 7'b0010000;
      4'hA: segment = 7'b0100000;
      4'hB: segment = 7'b0000011;
      4'hC: segment = 7'b1000110;
      4'hD: segment = 7'b0100001;
      4'hE: segment = 7'b0000110;
      4'hF: segment = 7'b0001110;
      default: segment = 7'b0111111;
    endcase
  end

endmodule

module BCDtoSevenSegmentTest();
  logic [6:0] segment;
  logic [3:0] bcd;

  bcdtohex DUT (.bcd, .segment);
  initial begin
    $monitor($time,,
             "bcd = %d, segment = %b", bcd, segment);
    for (bcd = 4'd0; bcd < 4'd9; bcd++)
      #5;
    #5 $finish;
    
  end
  endmodule: BCDtoSevenSegmentTest