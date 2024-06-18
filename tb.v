module tb;

reg clk;
reg wr_en;
reg rd_en;
reg rstop;
reg [15:0] din;
reg rstn;
wire [15:0] dout;
reg [15:0] rdata; // Changed to reg
wire empty;
wire full;

// Declare the loop variable outside the initial block
integer i;

sync_fifo u_sync_fifo (
    .rstn(rstn),
    .clk(clk),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .empty(empty),
    .full(full)
);

always #10 clk = ~clk;

initial begin
    clk <= 0;
    rstn <= 0;
    wr_en <= 0;
    rd_en <= 0;
    din <= 0;
    rstop <= 0;
    #50 rstn <= 1;
end

initial begin
    @(posedge clk);
    for (i = 0; i < 50; i = i + 1) begin
        // Wait until there is space in fifo
        while (full) begin
            @(posedge clk);
            $display("[TB] FIFO is full, wait for reads to happen at time=%0t", $time);
        end

        // Drive new values into FIFO
        wr_en <= $random;
        din <= $random;
        $display("[TB] clk time=%0t, i=%0d, wr_en=%0d, din=%0xh, full=%b, empty=%b", $time, i, wr_en, din, full, empty);

        // Wait for next clock edge
        @(posedge clk);
    end

    rstop <= 1;
end

initial begin
    @(posedge clk);
    while (!rstop) begin
        // Wait until there is data in fifo
        while (empty) begin
            rd_en <= 0;
            @(posedge clk);
            $display("[TB] FIFO is empty, wait for writes to happen at time=%0t", $time);
        end

        // Sample new values from FIFO at random pace
        rd_en <= $random;
        @(posedge clk);
        rdata <= dout;
        $display("[TB] clk time=%0t, rd_en=%0d, rdata=%0xh, full=%b, empty=%b", $time, rd_en, rdata, full, empty);
    end

    #500 $finish;
end

endmodule
