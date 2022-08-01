module Sign_Extend #(parameter UNEXTEND=16,
                     parameter EXTEND=32)
    (input      wire  [UNEXTEND-1:0] instr,
     output     reg   [EXTEND-1:0]   SignImm
     );
     
    always@(*)
      begin
       
       SignImm={({(EXTEND-UNEXTEND){instr[UNEXTEND-1]}}),instr};//replicate inside concat
     end
   endmodule    
