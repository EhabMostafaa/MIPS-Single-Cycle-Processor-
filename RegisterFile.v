module reg_file #(parameter REG_WIDTH=32,
                  parameter REG_DEPTH=32,
                  parameter Address_Width =5
                  )
  ( input   wire   [Address_Width-1:0]           A1,
    input   wire   [Address_Width-1:0]           A2,
    input   wire   [Address_Width-1:0]           A3,
    input   wire   [REG_WIDTH-1:0]               WD3,          
    input   wire                                 clk,
    input   wire                                 WE3,
    input   wire                                 reset,
    
    output  reg    [REG_WIDTH-1:0]               RD1,
    output  reg    [REG_WIDTH-1:0]               RD2
    );
    
 reg [REG_WIDTH-1:0] reg_file [REG_DEPTH-1:0];   
 integer k;
    
always@(*)
  begin
   RD1= reg_file[A1];
   RD2= reg_file[A2];
 end
 
always@(posedge clk or negedge reset)
  begin
    if(!reset)
     begin
   for(k=0;k<32;k=k+1)
    reg_file[k]<=32'b0;
  end
else if(WE3)
  begin
    reg_file[A3]<=WD3;
  end
  else 
    begin
       reg_file[A3]<= reg_file[A3];
       end
end
endmodule        