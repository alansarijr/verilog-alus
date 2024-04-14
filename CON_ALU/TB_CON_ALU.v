module TB_CON_ALU;

reg [7:0] A, B;
reg [3:0] SELC;
wire [7:0] ALU_OUT;
wire CF;
wire ZF, SF;

// Instantiate the Unit Under Test (UUT)
CON_ALU uut (
    .A(A),
    .B(B),
    .SELC(SELC),
    .ALU_OUT(ALU_OUT),
    .CF(CF),
    .ZF(ZF),
    .SF(SF)
);

// Initialize Inputs
initial begin
    A = 8'b00000000;
    B = 8'b00000000;
    SELC = 4'b0000;

    // Add more test cases here
    #10 A = 8'b00001100; B = 8'b00100010; SELC = 4'b0000; // A + B
    #10 A = 8'b01001100; B = 8'b00011111; SELC = 4'b0001; // A - B
    #10 A = 8'b01001100; B = 8'b00011111; SELC = 4'b0010; // A * B
    #10 A = 8'b10010000; B = 8'b00001000; SELC = 4'b0011; // A / B
    #10 A = 8'b00000101; B = 8'b00001010; SELC = 4'b0100; // A << 1
    #10 A = 8'b11110000; B = 8'b00000001; SELC = 4'b0101; // A >> 1
    #10 A = 8'b00001010; B = 8'b00000010; SELC = 4'b0110; // Rotate left
    #10 A = 8'b11110000; B = 8'b00000001; SELC = 4'b0111; // Rotate right
    #10 A = 8'b11110000; B = 8'b00001111; SELC = 4'b1000; // Logical and
    #10 A = 8'b11110000; B = 8'b00001111; SELC = 4'b1001; // Logical or
    #10 A = 8'b11110000; B = 8'b00001111; SELC = 4'b1010; // Logical xor
    #10 A = 8'b11110000; B = 8'b00001111; SELC = 4'b1011; // Logical nor
    #10 A = 8'b11110000; B = 8'b00001111; SELC = 4'b1100; // Logical nand
    #10 A = 8'b11110000; B = 8'b00001111; SELC = 4'b1101; // Logical xnor
    #10 A = 8'b11110000; B = 8'b00001111; SELC = 4'b1110; // Greater comparison
    #10 A = 8'b11110000; B = 8'b11110000; SELC = 4'b1110; // Greater comparison (equal)
    #10 A = 8'b11110000; B = 8'b11110000; SELC = 4'b1111; // Equal comparison
    #10 $finish;
end

initial begin
    $dumpfile("waveforms.vcd");
    $dumpvars(0, TB_CON_ALU);
end

// Display results
always @* begin
    case(SELC)
      4'b0000: $display("Operation: Addition, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b0001: $display("Operation: Subtraction, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b0010: $display("Operation: Multiplication, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b0011: $display("Operation: Division, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b0100: $display("Operation: Logical shift left, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b0101: $display("Operation: Logical shift right, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b0110: $display("Operation: Rotate left, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b0111: $display("Operation: Rotate right, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b1000: $display("Operation: Logical and, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b1001: $display("Operation: Logical or, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b1010: $display("Operation: Logical xor, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b1011: $display("Operation: Logical nor, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b1100: $display("Operation: Logical nand, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b1101: $display("Operation: Logical xnor, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b1110: $display("Operation: Greater comparison, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      4'b1111: $display("Operation: Equal comparison, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
      default: $display("Unknown operation, A = %h, B = %h, ALU_OUT = %h, CF = %b, ZF = %b, SF = %b", A, B, ALU_OUT, CF, ZF, SF);
    endcase
end

endmodule
