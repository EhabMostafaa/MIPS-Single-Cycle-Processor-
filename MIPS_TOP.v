module MIPS_TOP #(parameter DATA_WIDTH=32,
                  parameter INST_WIDTH=32)
  (input   wire          clk_top,
   input   wire          reset_top,
   output  wire  [15:0]  test_value_top
   );              



  wire                      MemWrite_top;
  wire                      RegWrite_top;
  wire                      RegDst_top;
  
  wire                      ALUsrc_top;
  wire                      MemtoReg_top;
  wire                      zero_top;
  
  wire                      PCSrc_top;
  wire                      Jump_top;
  wire   [2:0]              ALUControl_top;

  wire   [INST_WIDTH-1:0]   PC_top;
  wire   [DATA_WIDTH-1:0]   ALUOut_top;
  wire   [DATA_WIDTH-1:0]   WriteData_top;
  
  wire   [DATA_WIDTH-1:0]   ReadData_top;
  wire   [INST_WIDTH-1:0]   instr_top;
 
 // wire   [5:0]              Opcode_top;
 // wire   [5:0]              Funct_top;
  
  
 Data_Path #(.DATA_WIDTH(DATA_WIDTH),
             .INST_WIDTH(INST_WIDTH))
         D0(.clk_dp(clk_top),
            .reset_dp(reset_top),
            .RegWrite_dp(RegWrite_top),
            .RegDst_dp(RegDst_top),
            
            .ALUsrc_dp(ALUsrc_top),
            .MemtoReg_dp(MemtoReg_top),
            .PCSrc_dp(PCSrc_top),
            .Jump_dp(Jump_top),
            
            .ALUControl_dp(ALUControl_top),
            .ReadData_dp(ReadData_top),
            .instr_Dp(instr_top),
            .zero_dp(zero_top),
            
            .PC_dp(PC_top),
            .ALUOut_dp(ALUOut_top),
            .WriteData_dp(WriteData_top) 
            );
            
            //////////////////////////////
                 
 Control_unit C0(.OpCode(instr_top[31:26]),
                 .Funct(instr_top[5:0]),
                 .Zero(zero_top),
                 .MemtoReg(MemtoReg_top),
                 .MemWrite(MemWrite_top),
                 .ALUSrc(ALUsrc_top),
                 .RegDst(RegDst_top),
                 .RegWrite(RegWrite_top),
                 .jump(Jump_top),
                 .ALUControl(ALUControl_top),
                 .PCSrc(PCSrc_top)
                 );
                 
           ///////////////////////////////
  instruction_memory #(.INSTR_WIDTH(INST_WIDTH),
                       .INSTR_DEPTH(DATA_WIDTH))
               i0(.pc(PC_top),
                  .instr(instr_top)); 
          ////////////////////////////////////
  Data_Memory #(.DATA_WIDTH(DATA_WIDTH),
                .DATA_DEPTH(DATA_WIDTH))
        D1(.WD(WriteData_top),
            .A(ALUOut_top),
            .clk(clk_top),
            .reset(reset_top),
            .WE(MemWrite_top),
            .RD(ReadData_top),
            .test_value(test_value_top)
            ); 
            
          endmodule                            
  
                 