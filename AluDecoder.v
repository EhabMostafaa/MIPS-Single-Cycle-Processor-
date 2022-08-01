module ALU_Decoder (
      input   wire  [1:0] ALUOp,
      input   wire  [5:0] Funct,
      
      output  reg  [2:0] ALUControl
      );
      
parameter add=6'b10_0000; 
parameter sub=6'b10_0010; 
parameter slt=6'b10_1010; 
parameter mul=6'b01_1100;   

always@(*)
   begin
     case(ALUOp)
     2'b00:ALUControl=3'b010;
     2'b01:ALUControl=3'b100;
     2'b10: begin
               case(Funct)
               add:ALUControl=3'b010;
               sub:ALUControl=3'b100;
               slt:ALUControl=3'b110;
               mul:ALUControl=3'b101;
               default:ALUControl=3'b010;
             endcase
           end
     default: ALUControl=3'b010;
   endcase    
 end
endmodule       