module Main_Decoder
  (input      wire  [5:0]    opCode,
  
   output     reg            jump,
   output     reg   [1:0]    aluOp,
   output     reg            memWrite,
   output     reg            regWrite,
   output     reg            regDest,
   output     reg            aluSrc,
   output     reg            memtoReg,
   output     reg            Branch
   );

always@(*)
   begin
      case(opCode)
        6'b10_0011: begin
                      jump=0;
                      aluOp=2'b00;
                      memWrite=0;
                      regWrite=1;
                      regDest=0;
                      aluSrc=1;
                      memtoReg=1;
                      Branch=0;
                    end
                    ///////////////////////////////////
        6'b10_1011: begin
                      jump=0;
                      aluOp=2'b00;
                      memWrite=1;
                      regWrite=0;
                      regDest=0;
                      aluSrc=1;
                      memtoReg=1;
                      Branch=0;
                    end
                    //////////////////////////////////////
        6'b00_0000: begin
                      jump=0;
                      aluOp=2'b10;
                      memWrite=0;
                      regWrite=1;
                      regDest=1;
                      aluSrc=0;
                      memtoReg=0;
                      Branch=0;
                    end
                    ///////////////////////////////////////
        6'b00_1000: begin
                      jump=0;
                      aluOp=2'b00;
                      memWrite=0;
                      regWrite=1;
                      regDest=0;
                      aluSrc=1;
                      memtoReg=0;
                      Branch=0;
                    end
                    /////////////////////////////////////////
        6'b00_0100: begin
                      jump=0;
                      aluOp=2'b01;
                      memWrite=0;
                      regWrite=0;
                      regDest=0;
                      aluSrc=0;
                      memtoReg=0;
                      Branch=1;
                    end
                    //////////////////////////////////////////
        6'b00_0010: begin
                      jump=1;
                      aluOp=2'b00;
                      memWrite=0;
                      regWrite=0;
                      regDest=0;
                      aluSrc=0;
                      memtoReg=0;
                      Branch=0;
                    end
                    ///////////////////////////////////////////
        default    : begin
                      jump=0;
                      aluOp=2'b00;
                      memWrite=0;
                      regWrite=0;
                      regDest=0;
                      aluSrc=0;
                      memtoReg=0;
                      Branch=0;
                    end
                  endcase
                end
              endmodule