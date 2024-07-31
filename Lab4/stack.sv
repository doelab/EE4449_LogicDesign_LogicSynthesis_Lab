module stack	  
#( 
// default: 4-bits data with 100 layers of stack. 
parameter WIDTH = 4,
parameter DEPTH = 100
)
(                            
input  wire        clk,      
input  wire        rst,                      
input  wire        push_stb, 
input  wire [WIDTH-1:0] push_dat,                            
input  wire        pop_stb,  
output wire [WIDTH-1:0] pop_dat  
);                           
reg    	[DEPTH-1:0] ptr;
reg		[WIDTH-1:0] stack[0:DEPTH-1];

always@(posedge clk or posedge rst)
begin
 if(rst) ptr <= 0;
 else if(push_stb)
  ptr <= ptr + 1;  
 else if(pop_stb)
  ptr <= ptr - 1;
end
always@(posedge clk or posedge rst)
	if(push_stb)
			stack[ptr] <= push_dat;
assign 	pop_dat = stack[ptr-1];

endmodule