module instruction_memory #(parameter INSTR_WIDTH=32,
                            parameter INSTR_DEPTH=32)
  (input  wire     [INSTR_WIDTH-1:0]  pc,
   output reg      [INSTR_WIDTH-1:0] instr);
   
   reg [INSTR_WIDTH-1:0] instr_mem [INSTR_DEPTH-1:0];
   
   initial
    begin

  // $readmemh ("      E:\courses\digital design\MIPS IEEE\yousef\Program 2_MachineCode.txt",instr_mem);
   $readmemh ("Program 2_Machine Code.txt",instr_mem);
    end

always@(*)
 begin
    instr =instr_mem[pc>>2];
  end
 endmodule                          
