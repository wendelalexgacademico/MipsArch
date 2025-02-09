module ALU_Control (
    input [1:0] ALUOp,      // From Main Control Unit
    input [5:0] funct,      // From instruction (funct field)
    output reg [3:0] ALUControl // To ALU
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 4'b0010; // lw/sw: add
        2'b01: ALUControl = 4'b0110; // beq: subtract
        2'b10: begin
            case (funct)
                6'b100000: ALUControl = 4'b0010; // add
                6'b100010: ALUControl = 4'b0110; // subtract
                6'b100100: ALUControl = 4'b0000; // and
                6'b100101: ALUControl = 4'b0001; // or
                6'b101010: ALUControl = 4'b0111; // slt
                default:   ALUControl = 4'b0000; // default to and
            endcase
        end
        default: ALUControl = 4'b0000; // default to and
    endcase
end
