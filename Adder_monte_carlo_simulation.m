clear
ADDER_TYPE      = "SE"       ;
MAX_VAL         = 15             ;
N_BITS_APPROX   = 2              ;

N_ITERATION     = MAX_VAL * MAX_VAL ;
N_BITS          = log2(MAX_VAL+1)   ;
N_BITS_CONV     = N_BITS - N_BITS_APPROX ;
Num1            = randperm(MAX_VAL);
Num2            = randperm(MAX_VAL);
Iteration_Count = 0                ;
S_out           = 0                ;
C_out           = 0                ;
count           = 0                ;
count_comp      = 0                ;


for i = 1 : MAX_VAL
  if (Iteration_Count >= 5000000 )
      break;
    endif
  for j = 1: MAX_VAL
    Iteration_Count = Iteration_Count +1 ;
    if (Iteration_Count >= 5000000 )
      break;
    endif
    
    
    
    Num1_bin  = dec2bin(Num1(i),N_BITS);
    Num2_bin  = dec2bin(Num2(j),N_BITS);
    
    C_out_bin       = dec2bin(C_out  ,N_BITS);
    S_out_bin       = dec2bin(S_out  ,N_BITS);
    
    C_out_bin_conv = dec2bin(C_out  ,N_BITS);
    S_out_bin_conv = dec2bin(S_out  ,N_BITS);
    
    C_out_bin_maafa = dec2bin(C_out  ,N_BITS);
    S_out_bin_maafa = dec2bin(S_out  ,N_BITS);

    C_out_bin_comp = dec2bin(C_out  ,N_BITS);
    S_out_bin_comp = dec2bin(S_out  ,N_BITS);
    
    
if ( strcmp(ADDER_TYPE,"SA"))
      
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
    
    %disp([num2str(Num1(i)),"\t + \t",num2str(Num2(j)),"\t= \t", (S_out_bin_maafa),"(",num2str(bin2dec(S_out_bin_maafa)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
    
    
    
    if( S_out_bin_conv == S_out_bin_maafa)
       count = count +1;
    else
       disp("Conventional Adder \n");
       disp([num2str(Num1(i)),"\t + \t",num2str(Num2(j)),"\t= \t", (S_out_bin_conv),"(",num2str(bin2dec(S_out_bin_conv)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
       disp("Modified Adder \n");
       disp([num2str(Num1(i)),"\t + \t",num2str(Num2(j)),"\t= \t", (S_out_bin_maafa),"(",num2str(bin2dec(S_out_bin_maafa)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
    endif
 elseif( strcmp(ADDER_TYPE,"SE"))
   
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
   
   %Modified Adder Approx section
   for b = N_BITS : -1 : N_BITS_CONV + 1 
       
      A_and_B         = and(str2num(Num1_bin(b)), str2num(Num2_bin(b)));
      
      if(b == N_BITS )
        B_and_Cin         = and(str2num(Num2_bin(b)), 0);
        Cin_and_A         = and(str2num(Num1_bin(b)), 0);
      else
        B_and_Cin         = and(str2num(Num2_bin(b)), str2num(C_out_bin(b+1)));
        Cin_and_A         = and(str2num(Num1_bin(b)), str2num(C_out_bin(b+1)));
      endif
        
        C_out_bin(b) = num2str(or(A_and_B, B_and_Cin, Cin_and_A));
        if ( b == N_BITS )
          S_out_bin(b) = num2str(and(or(str2num(Num1_bin(b)), str2num(Num2_bin(b)), 0),  not(str2num(C_out_bin(b)))));
        else
          S_out_bin(b) = num2str(and(or(str2num(Num1_bin(b)), str2num(Num2_bin(b)), str2num(C_out_bin(b+1))),  not(str2num(C_out_bin(b)))));
        endif
        
    endfor
    
    
    %% Modified Adder Accurate Section
    for b = N_BITS_CONV : -1 : 1           
      A_xor_B         = xor(str2num(Num1_bin(b)), str2num(Num2_bin(b)));
      
      
        A_xor_B_xor_Cin = xor(A_xor_B , str2num(C_out_bin(b+1)));
      
      
        S_out_bin(b) = num2str(A_xor_B_xor_Cin);
      
      
        A_xor_B_and_Cin = and(A_xor_B , str2num(C_out_bin(b+1)));
      
     
      A_and_B              = and(str2num(Num1_bin(b))    , str2num(Num2_bin(b)));
      C_out_bin(b)    = num2str(or(A_xor_B_and_Cin      , A_and_B        ));
      
    endfor
    
    
    
    %Modified Adder Approx section
   for b = N_BITS : -1 : N_BITS_CONV + 1 
       
      A_and_B         = and(str2num(Num1_bin(b)), str2num(Num2_bin(b)));
      
      if(b == N_BITS )
        B_and_Cin         = and(str2num(Num2_bin(b)), 0);
        Cin_and_A         = and(str2num(Num1_bin(b)), 0);
      else
        B_and_Cin         = and(str2num(Num2_bin(b)), str2num(C_out_bin_comp(b+1)));
        Cin_and_A         = and(str2num(Num1_bin(b)), str2num(C_out_bin_comp(b+1)));
      endif
        
        C_out_bin_comp(b) = num2str(or(A_and_B, B_and_Cin, Cin_and_A));
        
        S_out_bin_comp(b) = num2str(not(str2num(C_out_bin_comp(b))));
        
        
    endfor
    
    
    %% Modified Adder Accurate Section
    for b = N_BITS_CONV : -1 : 1           
      A_xor_B         = xor(str2num(Num1_bin(b)), str2num(Num2_bin(b)));
      
      
        A_xor_B_xor_Cin = xor(A_xor_B , str2num(C_out_bin_comp(b+1)));
      
      
        S_out_bin_comp(b) = num2str(A_xor_B_xor_Cin);
      
      
        A_xor_B_and_Cin = and(A_xor_B , str2num(C_out_bin_comp(b+1)));
      
     
      A_and_B              = and(str2num(Num1_bin(b))    , str2num(Num2_bin(b)));
      C_out_bin_comp(b)    = num2str(or(A_xor_B_and_Cin      , A_and_B        ));
      
    endfor
    
    error(Iteration_Count) = bin2dec(S_out_bin_conv) - bin2dec(S_out_bin);
    
    
    if( S_out_bin_conv == S_out_bin)
       count = count +1;
    else
       disp("Conventional Adder \n");
       disp([num2str(Num1(i)),"\t + \t",num2str(Num2(j)),"\t= \t", (S_out_bin_conv),"(",num2str(bin2dec(S_out_bin_conv)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
       disp("Modified Adder \n");
       disp([num2str(Num1(i)),"\t + \t",num2str(Num2(j)),"\t= \t", (S_out_bin),"(",num2str(bin2dec(S_out_bin)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
    endif
   
##      if( S_out_bin_conv == S_out_bin_comp)
##       count_comp = count_comp +1;
##    else
##       disp("Conventional Adder \n");
##       disp([num2str(Num1(i)),"\t + \t",num2str(Num2(j)),"\t= \t", (S_out_bin_conv),"(",num2str(bin2dec(S_out_bin_conv)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
##       disp("Modified Adder Comp \n");
##       disp([num2str(Num1(i)),"\t + \t",num2str(Num2(j)),"\t= \t", (S_out_bin_comp),"(",num2str(bin2dec(S_out_bin_comp)),")","\t","Iteration_Count = \t", num2str(Iteration_Count),"\n"]);
##    endif 
    
  
  endif
  
  
  
  
  
  
  
  
  
  endfor
endfor
disp ("Maafa results");
disp (["difference =", num2str(Iteration_Count - count)]);
disp (["Error  =", num2str((Iteration_Count - count)/(Iteration_Count)),"%"]);
disp ("Paper results");
disp (["difference =", num2str(Iteration_Count - count_comp)]);
disp (["Error  =", num2str((Iteration_Count - count_comp)/(Iteration_Count)),"%"]);