
// Synchronous FIFO


module fifo #(
    parameter DEPTH = 8,   // Number of storage locations
    parameter WIDTH = 4    // Bit width of each location
)(
    input                  clk,
    input                  rst,
    input                  wr_en,      // Write enable
    input      [WIDTH-1:0] data_in,    // Data coming in
    input                  rd_en,      // Read enable
    output reg [WIDTH-1:0] data_out,   // Data going out
    output                 full,       // Can't write anymore
    output                 empty       // Nothing left to read
);

    // ----------------------------------------
    // Memory array — this is the actual storage
    // ----------------------------------------
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // ----------------------------------------
    // Pointers — track where to write and read
    // Extra bit prevents full/empty confusion
    // ----------------------------------------
    reg [$clog2(DEPTH):0] wr_ptr; // write pointer
    reg [$clog2(DEPTH):0] rd_ptr; // read pointer

    // ----------------------------------------
    // Full & Empty Logic
    // Same index bits but MSB differs = FULL
    // Identical pointers = EMPTY
    // ----------------------------------------
    assign full  = (wr_ptr[$clog2(DEPTH)]   != rd_ptr[$clog2(DEPTH)]) &&
                   (wr_ptr[$clog2(DEPTH)-1:0] == rd_ptr[$clog2(DEPTH)-1:0]);
    assign empty = (wr_ptr == rd_ptr);

    // ----------------------------------------
    // Write Logic
    // ----------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
        end else if (wr_en && !full) begin
            mem[wr_ptr[$clog2(DEPTH)-1:0]] <= data_in;
            wr_ptr <= wr_ptr + 1;
        end
    end

    // ----------------------------------------
    // Read Logic
    // ----------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_ptr   <= 0;
            data_out <= 0;
        end else if (rd_en && !empty) begin
            data_out <= mem[rd_ptr[$clog2(DEPTH)-1:0]];
            rd_ptr   <= rd_ptr + 1;
        end
    end

endmodule
