
module AddSub10(
    input [9:0] A,
    input [9:0] B,
    input sub,
    output ovfl,
    output [9:0] S
    );
    wire [10:0] C;
    wire [9:0] Kbus;
    wire [9:0] BxorK;
    assign Kbus = {10{sub}};
    assign BxorK = B^Kbus;
    assign C[0] = sub;
    FA f [9:0] (.a(A[9:0]), .b(BxorK[9:0]), .Cin(C[9:0]), .s(S[9:0]), .Cout(C[10:1]));
    assign ovfl = (~sub & ~A[9] & ~B[9] & S[9]) | (~sub & A[9] & B[9] & ~S[9]) | (sub & ~A[9] & B[9] & S[9]) | (sub & A[9] & ~B[9] & ~S[9]);
endmodule
