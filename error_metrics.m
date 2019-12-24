clear

MAX_VAL         = 7             ;
N_BITS_APPROX   = 2              ;

N_ITERATION     = (MAX_VAL+1) * (MAX_VAL+1) ;
N_BITS          = log2(MAX_VAL+1)   ;

Iteration_Count = 0                ;
S_out           = 0                ;
C_out           = 0                ;
count           = 0                ;
count_loa      = 0                ;


for i = 0 : MAX_VAL
  if (Iteration_Count >= 1000 )
      break;
    endif
  for j = 0: MAX_VAL
    Iteration_Count = Iteration_Count +1 ;
    if (Iteration_Count >= 1000 )
      break;
    endif
    
    
    
    Num1_bin  = dec2bin(i,N_BITS);
    Num2_bin  = dec2bin(j,N_BITS);
    
    C_out_bin_conv = dec2bin(C_out  ,N_BITS);
    S_out_bin_conv = dec2bin(S_out  ,N_BITS);
    
    C_out_bin_maafa = dec2bin(C_out  ,N_BITS);
    S_out_bin_maafa = dec2bin(S_out  ,N_BITS);

    C_out_bin_loa = dec2bin(C_out  ,N_BITS);
    S_out_bin_loa = dec2bin(S_out  ,N_BITS);    
    

      
%% Conventional Adder 
    for b = N_BITS : -1 : 1           
      A_xor_B         = xor(str2num(Num1_bin(b)), str2num(Num2_bin(b)));
      
      if(b == N_BITS )
        A_xor_B_xor_Cin = xor(A_xor_B , 0       );
      else
        A_xor_B_xor_Cin = xor(A_xor_B , str2num(C_out_bin_conv(b+1)));
      endif
      
        S_out_bin_conv(b) = num2str(A_xor_B_xor_Cin);
      
      if(b == N_BITS )
        A_xor_B_and_Cin = and(A_xor_B , 0       );
      else
        A_xor_B_and_Cin = and(A_xor_B , str2num(C_out_bin_conv(b+1)));
      endif
     
      A_and_B              = and(str2num(Num1_bin(b))    , str2num(Num2_bin(b)));
      C_out_bin_conv(b)    = num2str(or(A_xor_B_and_Cin      , A_and_B        ));
      
    endfor
    %disp([num2str(Num1(i)),"\t + \t",num2str(Num2(j)),"\t= \t", (S_out_bin_conv),"(",num2str(bin2dec(S_out_bin_conv)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
 
%disp("Modified Adder \n");
 %% Modified Adder
 for b = N_BITS : -1 : 1 
       
      A_and_B         = and(str2num(Num1_bin(b)), str2num(Num2_bin(b)));
      
      if(b == N_BITS )
        B_and_Cin         = and(str2num(Num2_bin(b)), 0);
        Cin_and_A         = and(str2num(Num1_bin(b)), 0);
      else
        B_and_Cin         = and(str2num(Num2_bin(b)), str2num(C_out_bin_maafa(b+1)));
        Cin_and_A         = and(str2num(Num1_bin(b)), str2num(C_out_bin_maafa(b+1)));
      endif
        
        C_out_bin_maafa(b) = num2str(or(A_and_B, B_and_Cin, Cin_and_A));
        if ( b == N_BITS )
          S_out_bin_maafa(b) = num2str(and(or(str2num(Num1_bin(b)), str2num(Num2_bin(b)), 0),  not(str2num(C_out_bin_maafa(b)))));
        else
          S_out_bin_maafa(b) = num2str(and(or(str2num(Num1_bin(b)), str2num(Num2_bin(b)), str2num(C_out_bin_maafa(b+1))),  not(str2num(C_out_bin_maafa(b)))));
        endif
        
    endfor
 
%disp("Modified Adder \n");
 %% Modified Adder
 for b = N_BITS : -1 : 1 
       
      S_out_bin_loa(b) = num2str(or(str2num(Num1_bin(b)), str2num(Num2_bin(b))));
        
    endfor
        if( S_out_bin_conv == S_out_bin_loa)
       count_loa = count_loa +1;
       endif
    
    %disp([num2str(Num1(i)),"\t + \t",num2str(Num2(j)),"\t= \t", (S_out_bin_maafa),"(",num2str(bin2dec(S_out_bin_maafa)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
    
    error_maafa(Iteration_Count) = bin2dec(S_out_bin_conv) - bin2dec(S_out_bin_maafa);
    
    
    error_loa(Iteration_Count) = (bin2dec(S_out_bin_conv) - bin2dec(S_out_bin_loa));
    
    
       disp("Conventional Adder \n");
       disp([num2str((i)),"\t + \t",num2str((j)),"\t= \t", (S_out_bin_conv),"(",num2str(bin2dec(S_out_bin_conv)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
       disp("maafa Adder \n");
       disp([num2str((i)),"\t + \t",num2str((j)),"\t= \t", (S_out_bin_maafa),"(",num2str(bin2dec(S_out_bin_maafa)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
       disp("loa Adder \n");
       disp([num2str((i)),"\t + \t",num2str((j)),"\t= \t", (S_out_bin_loa),"(",num2str(bin2dec(S_out_bin_loa)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
       disp(["error_maafa = \t", (S_out_bin_conv), " - ", (S_out_bin_maafa), " = " , num2str(str2num(S_out_bin_conv) - str2num(S_out_bin_maafa))]);
       disp(["error_loa = \t", (S_out_bin_conv), " - ", (S_out_bin_loa), " = " , num2str(str2num(S_out_bin_conv) - str2num(S_out_bin_loa))]);
       
 

  
  
  
  
  
  
  
  
  
  endfor
endfor
disp ("loa results");
disp (["difference =", num2str(Iteration_Count - count_loa)]);
disp (["Error  =", num2str((Iteration_Count - count_loa)/(Iteration_Count)),"%"]);


