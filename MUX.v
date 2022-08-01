module MUX #(parameter WIDTH=32)
  (input  wire   [WIDTH-1:0] In1,
   input  wire   [WIDTH-1:0] In2,
   input  wire               sel,
   output reg    [WIDTH-1:0] out
   );
   
 always@(*)
   begin
    if(sel)
        out=In2;
    else
        out=In1;
      end
endmodule   
