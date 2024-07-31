module fifoctrl
    (
     clkw, //clock write
     clkr, //clock read
     rst,
     
     fiford,    // FIFO control
     fifowr,

     fifofull,  // high when fifo full
     notempty,  // high when fifo not empty
     fifolen,   // fifo length

                // Connect to memories
     write,     // enable to write memories
     wraddr,    // write address of memories
     read,      // enable to read memories
     rdaddr     // read address of memories
     );

parameter ADDRBIT = 5;
parameter LENGTH = 32;

input   clkw,
        clkr,
        rst,
        fiford,
        fifowr;

output  fifofull,
        notempty;

output [ADDRBIT:0] fifolen;

output  write;
output  read;

output [ADDRBIT-1:0] wraddr;
output [ADDRBIT-1:0] rdaddr;

reg     [ADDRBIT:0]   fifo_len;
reg     [ADDRBIT-1:0] wrcnt;

wire    [ADDRBIT-1:0] wraddr;
assign  wraddr = wrcnt;

wire    fifoempt;
assign  fifoempt    =   (fifo_len=={1'b0,{ADDRBIT{1'b0}}});

wire    notempty;
assign  notempty    =   !fifoempt;

wire    fifofull;
assign  fifofull    =   (fifo_len[ADDRBIT]);

assign  fifolen     =   fifo_len;

wire    write;
assign  write       =   (fifowr& !fifofull);

wire    read;
assign  read        =   (fiford& !fifoempt);

wire    [ADDRBIT-1:0]   rdcnt;
assign  rdcnt       =   wrcnt - fifo_len[ADDRBIT-1:0];

wire    [ADDRBIT-1:0] rdaddr;
assign  rdaddr = rdcnt;

always @(posedge clkw or posedge rst)
    begin
    if(rst) wrcnt <= {ADDRBIT{1'b0}};
    else if(write) wrcnt    <= wrcnt  + 1'b1;
    end

always @(posedge clkr or posedge rst)
    begin
    if(rst) fifo_len  <= {1'b0,{ADDRBIT{1'b0}}};
    else
        case({read,write})
        2'b01: fifo_len <= fifo_len + 1'b1;
        2'b10: fifo_len <= fifo_len - 1'b1;
        default: fifo_len <= fifo_len;
        endcase
    end

endmodule
