module ALUControl (
    input wire [1:0] ALUOp,      // Reebido da unidade de controle
    input wire [5:0] funct,     // funct field
    output reg [3:0] ALUControl_to_Aluop // saída pra ALU
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 4'b0010; // lw/sw: add
        2'b01: ALUControl = 4'b0110; // beq: sub
        2'b10: begin
            case (funct)
                6'b100000: ALUControl = 4'b0010; // add
                6'b100010: ALUControl = 4'b0110; // sub
                6'b100100: ALUControl = 4'b0000; // and
                6'b100101: ALUControl = 4'b0001; // or
                6'b101010: ALUControl = 4'b0111; // slt
                default:   ALUControl = 4'b0000; // default to and
            endcase
        end
        default: ALUControl = 4'b0000; // default to and
    endcase
end

endmodule