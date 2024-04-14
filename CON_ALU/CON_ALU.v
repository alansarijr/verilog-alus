module CON_ALU(
  input [7:0] A,
  input [7:0] B,
  input [3:0] SELC,
  output [7:0] ALU_OUT,
  output reg CF,
  output reg ZF,
  output reg SF
);

wire [8:0] t;
assign t = {1'b0,A} + {1'b0,B};   
reg [7:0] RES;
reg temp_CF; // Temporary variable for CF

initial begin
  CF = 1'b0;
  ZF = 1'b0;
  SF = 1'b0;
end

always @* begin 
  temp_CF = t[8]; // Compute CF
  case(SELC)
    4'b0000: RES = A + B; // Addition
    4'b0001: RES = A - B; // Subtraction 
    4'b0010: RES = A * B; // Multiplication
    4'b0011: RES = A / B; // Division
    4'b0100: RES = A << 1; // Logical shift left
    4'b0101: RES = A >> 1; // Logical shift right
    4'b0110: RES = {A[6:0],A[7]}; // Rotate left
    4'b0111: RES = {A[0],A[7:1]}; // Rotate right
    4'b1000: RES = A & B; // Logical and 
    4'b1001: RES = A | B; // Logical or
    4'b1010: RES = A ^ B; // Logical xor 
    4'b1011: RES = ~(A | B); // Logical nor
    4'b1100: RES = ~(A & B); // Logical nand 
    4'b1101: RES = ~(A ^ B); // Logical xnor
    4'b1110: begin // Greater comparison
      if (A > B) begin
        RES = 8'd1;
        temp_CF = 1'b1;
        ZF = 1'b0;
        SF = 1'b0;
      end
      else begin
        RES = 8'd0;
        temp_CF = 1'b0;
        ZF = 1'b0;
        SF = 1'b0;
      end
    end
    4'b1111: begin // Equal comparison 
      if (A == B) begin
        RES = 8'd1;
        temp_CF = 1'b0;
        ZF = 1'b1;
        SF = 1'b0;
      end
      else begin
        RES = 8'd0;
        temp_CF = 1'b0;
        ZF = 1'b0;
        SF = 1'b0;
      end
    end
    default: begin
      RES = A + B;
      temp_CF = 1'b0;
      ZF = 1'b0;
      SF = 1'b0;
    end
  endcase
  CF = temp_CF; // Assign CF
end

assign ALU_OUT = RES;

endmodule
