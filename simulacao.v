`include "ALU.v"
`include "ALUontrol.v"
`include "controlUnit.v"
`include "dataMemory.v"
`include "MemoriaDeInstruções.v"
`include "MUX1.v"
`include "proessador.v"
`include "ProgramCounter.v"
`include "registers.v"
`include "signExtended.v"
`include "ALU.v"

`timescale 1ns / 1ps

module simulacao();
    reg clk;
    reg rst;

    wire [31:0] pc;          
    wire [31:0] instruction; 
    wire RegWrite, ALUSrc, Branch, Jump; 

    reg [31:0] registerArray [31:0];

    // Declaração de genvars para os generate
    genvar i, j,k;
    integer idx;

    processador inst_processador (
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .instruction(instruction),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .Branch(Branch),
        .Jump(Jump)
    );

    // Bloco principal de inicialização 
    initial begin
        //Arquivo de dump para visualização de ondas
        $dumpfile("Processador.vcd");
        $dumpvars(0, SingleCycleMIPS_Simulation);


        // Inicializa clock e reset
        clk = 0;
        rst = 1;

        // Carrega o arquivo que será armazenado na nemoria de instrucoes
        $readmemb("codigo.mem", uut.inst_MemoriaDeInstrucoes);

        // Desativa o reset após 10 ns
        #10 rst = 0;

        repeat (40) begin
            #5 clk = ~clk;
        end

        $finish;
    end

    initial begin
        $monitor("Tempo: %0d | registerArray[0]: %h", $time, registerArray[0]);
    end

    always @(posedge clk) begin
        for (idx = 0; idx < 32; idx = idx + 1) begin
            regBankState[idx] = uut.inst_registers.registers[idx];
        end
    end

endmodule