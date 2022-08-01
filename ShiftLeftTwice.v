module Shift_Left_twice #(parameter INPUT_WIDTH=32,
                          parameter OUTPUT_WIDTH=32)
         (input   wire [INPUT_WIDTH-1:0]   INPUT,
          output  reg  [OUTPUT_WIDTH-1:0]  OUTPUT
          );
          
 always@(*)
   begin
     OUTPUT=INPUT<<2;
   end
 endmodule                         
