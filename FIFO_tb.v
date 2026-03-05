module tb_fifo;

    // Parameters matching the DUT
    parameter DEPTH = 8;
    parameter WIDTH = 4;

    // Inputs
    reg                  clk, rst;
    reg                  wr_en, rd_en;
    reg      [WIDTH-1:0] data_in;

    // Outputs
    wire     [WIDTH-1:0] data_out;
    wire                 full, empty;

    // Instantiate FIFO
    fifo #(.DEPTH(DEPTH), .WIDTH(WIDTH)) uut (
        .clk(clk), .rst(rst),
        .wr_en(wr_en), .data_in(data_in),
        .rd_en(rd_en), .data_out(data_out),
        .full(full), .empty(empty)
    );

    always #5 clk = ~clk;

    // Task: write one item
    task write_data;
        input [WIDTH-1:0] data;
        begin
            @(posedge clk);
            wr_en   = 1;
            data_in = data;
            @(posedge clk);
            wr_en   = 0;
            $display("[WRITE] data_in=%0d | full=%b empty=%b", data, full, empty);
        end
    endtask

    // Task: read one item
    task read_data;
        begin
            @(posedge clk);
            rd_en = 1;
            @(posedge clk);
            rd_en = 0;
            $display("[READ ] data_out=%0d | full=%b empty=%b", data_out, full, empty);
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_fifo);

        // Initialize
        clk = 0; rst = 1;
        wr_en = 0; rd_en = 0; data_in = 0;

        // Apply reset
        #15 rst = 0;
        $display("\n===== FIFO TESTBENCH =====");

        // TEST 1: Write 8 items (fill it completely)
        $display("\n-- TEST 1: Fill FIFO --");
        write_data(4'd1);
        write_data(4'd2);
        write_data(4'd3);
        write_data(4'd4);
        write_data(4'd5);
        write_data(4'd6);
        write_data(4'd7);
        write_data(4'd8);
        $display("FULL flag: %b (expect 1)", full);

        // TEST 2: Try writing when full (should be ignored)
        $display("\n-- TEST 2: Overflow Protection --");
        write_data(4'd9); // Should NOT be written
        $display("Data should still be 8 items only");

        // TEST 3: Read all 8 items out
        $display("\n-- TEST 3: Drain FIFO --");
        repeat(8) read_data();
        $display("EMPTY flag: %b (expect 1)", empty);

        // TEST 4: Try reading when empty (underflow)
        $display("\n-- TEST 4: Underflow Protection --");
        read_data(); // Should NOT produce valid data

        // TEST 5: Interleaved write and read
        $display("\n-- TEST 5: Interleaved Write & Read --");
        write_data(4'd5);
        read_data();
        write_data(4'd10);
        write_data(4'd15);
        read_data();
        read_data();

        $display("\n===== TEST COMPLETE =====");
        $finish;
    end
endmodule
