module Data_Path #(parameter DATA_WIDTH=32,
                   parameter INST_WIDTH=32)
  (input  wire                      clk_dp,
   input  wire                      reset_dp,
   input  wire                      RegWrite_dp,
   input  wire                      RegDst_dp,
  
   input  wire                      ALUsrc_dp,
   input  wire                      MemtoReg_dp,
   input  wire                      PCSrc_dp,
   input  wire                      Jump_dp,
  
   input  wire   [2:0]              ALUControl_dp,
   input  wire   [DATA_WIDTH-1:0]   ReadData_dp,
   input  wire   [INST_WIDTH-1:0]   instr_Dp,
  
   output wire                      zero_dp,
   output wire   [INST_WIDTH-1:0]   PC_dp,
   output wire   [DATA_WIDTH-1:0]   ALUOut_dp,
   output wire   [DATA_WIDTH-1:0]   WriteData_dp
   );
             
             
             
wire  [DATA_WIDTH-1:0]       SrcA_dp;
wire  [DATA_WIDTH-1:0]       SrcB_dp;
wire  [DATA_WIDTH-1:0]       SignImm_dp;

wire  [INST_WIDTH-1:0]       PCBranch_dp;
wire  [INST_WIDTH-1:0]       PCPlus4_dp;
wire  [INST_WIDTH-1:0]       PCdash_dp;
wire  [INST_WIDTH-1:0]       PCJump_dp;

wire  [INST_WIDTH-1:0]       sh2_out_dp;
wire  [27:0]                 sh1_out_dp;

wire  [DATA_WIDTH-1:0]       mux_result_out_dp;//5
wire  [4:0]                  mux_write_reg_dp;//4
wire  [INST_WIDTH-1:0]       mux_PCSrc_out_dp;//1
             
                  
assign  PCJump_dp= {PCPlus4_dp[31:28],sh1_out_dp}; 


reg_file #()
        rg(.A1(instr_Dp[25:21]),
           .A2(instr_Dp[20:16]),
           .A3(mux_write_reg_dp),
           .WD3(mux_result_out_dp),
           .clk(clk_dp),
           .WE3(RegWrite_dp),
           .reset(reset_dp),
           .RD1(SrcA_dp),
           .RD2(WriteData_dp));
                   
      /////////////////////////////////////////////
alu_mipss #(.DATA_SIZE(DATA_WIDTH))
      alu(.SrcA(SrcA_dp),
          .SrcB(SrcB_dp),
          .ALUControl(ALUControl_dp),
          .ALUResult(ALUOut_dp),
          .Zero(zero_dp));
      ///////////////////////////////////////////////
MUX #(.WIDTH(DATA_WIDTH))
   m1(.In1(PCPlus4_dp),
      .In2(PCBranch_dp),
      .sel(PCSrc_dp),
      .out(mux_PCSrc_out_dp));
      /////////////////////////////////////////////////
MUX #(.WIDTH(DATA_WIDTH))
   m2(.In1(mux_PCSrc_out_dp),
      .In2(PCJump_dp),
      .sel(Jump_dp),
      .out(PCdash_dp)); 
      /////////////////////////////////////////////////
MUX #(.WIDTH(DATA_WIDTH))
   m3(.In1(WriteData_dp),
      .In2(SignImm_dp),
      .sel(ALUsrc_dp),
      .out(SrcB_dp)); 
      ///////////////////////////////////////////
MUX #(.WIDTH(5))
   m4(.In1(instr_Dp[20:16]),
      .In2(instr_Dp[15:11]),
      .sel(RegDst_dp),
      .out(mux_write_reg_dp));  
      ///////////////////////////////////////////
MUX #(.WIDTH(DATA_WIDTH))
   m5(.In1(ALUOut_dp),
      .In2(ReadData_dp),
      .sel(MemtoReg_dp),
      .out(mux_result_out_dp));
      ////////////////////////////////////////////
Sign_Extend #(.UNEXTEND(16),
              .EXTEND(DATA_WIDTH)) 
            s1(.instr(instr_Dp[15:0]),
               .SignImm(SignImm_dp));   
      //////////////////////////////////////////       
Shift_Left_twice #(.INPUT_WIDTH(26),
                   .OUTPUT_WIDTH(28))
                   sh1 (.INPUT(instr_Dp[25:0]),
                        .OUTPUT(sh1_out_dp));          
      /////////////////////////////////////////      
Shift_Left_twice #(.INPUT_WIDTH(DATA_WIDTH),
                   .OUTPUT_WIDTH(DATA_WIDTH))
                   sh2 (.INPUT(SignImm_dp),
                        .OUTPUT(sh2_out_dp));
      /////////////////////////////////////////
ADDER #(.WIDTH(DATA_WIDTH))
    a0 (.A(sh2_out_dp),
        .B(PCPlus4_dp),
        .C(PCBranch_dp));  
        /////////////////////////////////////
ADDER #(.WIDTH(DATA_WIDTH))
    a1 (.A(PC_dp),
        .B(32'b100),
        .C(PCPlus4_dp));  
      ////////////////////////////////////////
program_counter #(.ADDRESS_SIZE(INST_WIDTH))
     p1 (.pc_dash(PCdash_dp),
         .clk(clk_dp),
         .reset(reset_dp),
         .pc(PC_dp));
endmodule         
                                                