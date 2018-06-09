function float = binaryToFloat( bin, range )
%present bit string to float number in specific range
integer = polyval(bin, 2);
float = integer*((range(2)-range(1))/(2^length(bin)-1)) + range(1);

end

