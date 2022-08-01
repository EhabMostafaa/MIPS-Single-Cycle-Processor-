module Control_unit 
  (input   wire      [5:0]  OpCode,
   input   wire      [5:0]  Funct,
   input   wire             Zero,
   output  wire             MemtoReg,
   output  wire             MemWrite,
   output  wire             ALUSrc,
   output  wire             RegDst,
   output  wire             RegWrite,
   output  wire             jump,
   output  wire      [2:0]  ALUControl,
   output  wire             PCSrc
      );
  wire             Branch;      
  wire      [1:0]  ALUOp;
  
  
   
  Main_Decoder m0(.opCode(OpCode),
                  .jump(jump),
                  .aluOp(ALUOp),
                  .memWrite(MemWrite),
                  .regWrite(RegWrite),
                  .regDest(RegDst),
                  .aluSrc(ALUSrc),
                  .memtoReg(MemtoReg),
                  .Branch(Branch));
                  
  assign PCSrc=Branch&Zero;
  
   ALU_Decoder a0(.ALUOp(ALUOp),
                 .Funct(Funct),
                 .ALUControl(ALUControl));

                endmodule
  
  