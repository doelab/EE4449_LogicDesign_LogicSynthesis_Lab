/* verilator lint_off UNUSEDSIGNAL */

module p1hwtb // header for our hardware testbench
  (input  logic       clk, reset_l, Button0,
   output logic [7:0] valueToinA, // connect this to sumitup's inA
                      tbSum,      // tb's sum for display
   output logic       go_l, 
                      L0,         // L0 indicating sums match
   input  logic [7:0] outResult); // your downstream module's
                                  // output connected to tb
//////////////////////////////////////////
////////DO NOT CHANGE ANYTHING/////////////
//////////////////////////////////////////
parameter IDLE = 2'b00;
parameter SUM = 2'b01;
parameter DONE = 2'b11;
parameter SEED = 8'd123;

logic calzero;
assign calzero = valueToinA == 8'd0;
//////////////////////////////////////////
//FSM
logic [1:0] state;

logic stateisidle;
assign stateisidle = state == 2'b00;

logic stateissum;
assign stateissum = state == 2'b01;

logic stateisdone;
assign stateisdone = state == 2'b11;

always@(posedge clk)
begin
  if(!reset_l)
  state <= IDLE;
  else if(stateisidle & !Button0)
  state <= SUM;
  else if(stateissum & calzero)
  state <= DONE;
  else if(stateisdone & Button0)
  state <= IDLE;
  else
  state <= state;
end

//////////////////////////////////////////
//valuetoina

always@(posedge clk)
begin
  if(!reset_l|!stateissum|calzero)
    valueToinA <= SEED;
  else if(stateissum)
    valueToinA <= valueToinA - 1;
end

//////////////////////////////////////////
//tbSum

always@(posedge clk)
begin
  if(!reset_l)
  tbSum <= 0;
  else if(stateisidle)
  tbSum <= 0;
  else if(stateissum)
  tbSum <= tbSum + valueToinA;
  else if(stateisdone)
  tbSum <= tbSum;
end

//////////////////////////////////////////
//go_l

assign go_l = stateissum;

//////////////////////////////////////////
//L0

assign L0 = outResult == tbSum;

//////////////////////////////////////////

endmodule
