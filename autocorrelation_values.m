 function r = autocorrelation_values(h)
 
%h are the transfer functions of the different paths for each channel
    for i = 1:4
        r0(i) = h(i,1)^2+h(i,2)^2+h(i,3)^2;
        r1(i) = h(i,1)*h(i,2)+h(i,2)*h(i,3);
        r2(i) = h(i,1)*h(i,3);
    end
    r = [r0; r1; r2];
 end