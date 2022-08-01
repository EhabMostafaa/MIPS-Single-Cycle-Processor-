module alu_mipss #(parameter DATA_SIZE=32)
(
 input   wire  [DATA_SIZE-1:0] SrcA,
 input   wire  [DATA_SIZE-1:0] SrcB,
 input   wire  [2:0]           ALUControl,
 output  wire                   Zero,

 output  reg  [DATA_SIZE-1:0] ALUResult
);


always@(*)
  begin
    case(ALUControl)
      3'b000: ALUResult=SrcA&SrcB;
      3'b001: ALUResult=SrcA|SrcB;
      3'b010: ALUResult=SrcA+SrcB;
      3'b011: ALUResult='b0;
      3'b100: ALUResult=SrcA-SrcB;
      3'b101: ALUResult=SrcA*SrcB;
      //3'b110: ALUResult=(SrcA<SrcB)? 1:0;
      3'b110: ALUResult=((SrcA-SrcB))>>(DATA_SIZE-1);
      3'b111: ALUResult='b0;
      default: ALUResult='b0;
    endcase
  end
  
  assign Zero=(ALUResult=='b0);
endmodule
      