module program_counter #(parameter ADDRESS_SIZE=32)
  (
  input  wire [ADDRESS_SIZE-1:0] pc_dash,
  input  wire                    clk,
  input  wire                    reset,
  output reg  [ADDRESS_SIZE-1:0] pc
  );
  
  always@(posedge clk or negedge reset)
   begin
     if(!reset)
       begin
         pc<=32'b0;
       end
     else
       begin
         pc<=pc_dash;
       end
     end
   endmodule
