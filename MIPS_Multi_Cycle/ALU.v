module ALU(
    // for the system clock
    input               clk,
    // UI
    input               ALUSrcA, // ALU; address A
    input       [1:0]   ALUSrcB, // ALU; address B
    input       [31:0]  A, // input is address A
    input       [31:0]  B, // input is address B
    input       [31:0]  PC, // This is the program counter 32bit
    input       [31:0]  SignImm, // sign extension 32bit

    // input       [31:0]  SrcA,
    // input       [31:0]  SrcB,

	// 3 bit controls ALU control
    input       [2:0]   ALUControl,
    output  reg [31:0]  ALUOut, // 32-bit output that is equated to ALUResult at the end
    output  reg [31:0]  ALUResult, //32-bit result of the dictated operation
    output              Zero
);
    reg [31:0]  SrcA,SrcB; // calculate values of A and B   

    
    assign Zero = (ALUResult) ? 1'b0 : 1'b1; //set on
    always @(*) begin
        SrcA = ALUSrcA ? A : PC; // Checking if SrcA is the same as SrcA in the ALU. If so, Set SrcA to address A. Else set it to the Program Counter(PC)
        case(ALUSrcB)
            2'b00: SrcB = B; // If the value of ALUSrcB is 00 then SrcB is equal to address B
            2'b01: SrcB = 32'd4; // If it is 01 then set it to decimal value 4 with a width of 32 bits
            2'b10: SrcB = SignImm; // If it is 10 then set it to the sign extended number
            2'b11: SrcB = SignImm << 2; // If it is 11 then set it to the twice left shifted sign extended number
        endcase
    end

    always @(*) begin
        case (ALUControl)
            3'b010 : begin 
                ALUResult = SrcA + SrcB;
            end 
            3'b110 : begin 
                ALUResult = SrcA - SrcB;
            end
            3'b000 : ALUResult = SrcA & SrcB; // AND
            3'b001 : ALUResult = SrcA | SrcB; // OR
            3'b111 : ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0; // Set on less than
            default: ;
        endcase
    end

    always @(posedge clk) begin
        ALUOut <= ALUResult; // Equates ALUOut to ALUResult
    end


endmodule