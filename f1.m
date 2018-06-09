function output = f1( x,y )
%first objective function
    output = 100.*power((y-power(x,2)),2) + power(1-x,2);
end

