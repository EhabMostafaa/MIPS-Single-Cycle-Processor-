module Data_Memory#(parameter DATA_WIDTH=32,
                    parameter DATA_DEPTH=32)
   (input   wire      [DATA_WIDTH-1:0]     WD,
    input   wire      [DATA_WIDTH-1:0]     A,
    input   wire                           clk,
    input   wire                           reset,
    input   wire                           WE,
    
    output  reg       [DATA_WIDTH-1:0]     RD,
    output  reg       [15:0]               test_value
    );
    
 reg [DATA_WIDTH-1:0] DATA_mem [DATA_DEPTH-1:0];
 //reg [DATA_WIDTH-1:0] out_help;
 integer k;    

 
always@(*)
   begin
     RD=DATA_mem[A];
      end
     
     
always@(posedge clk or negedge reset)
  begin
    if(!reset)
     begin
        for(k=0;k<DATA_DEPTH;k=k+1)
          DATA_mem[k]<=32'b0;
        end
      else if(WE)
        begin
          DATA_mem[A]<= WD;
        end
      else
        DATA_mem[A]<=DATA_mem[A];
      end
      
always@(*)
begin
     test_value=DATA_mem[0];
     end      
endmodule      
        
         
            
