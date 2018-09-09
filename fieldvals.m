function rval = fieldvals(struc, fields)
N = length(fields);
rval = zeros(1, N);
for i = 1:N
    rval(i) = struc.(fields{i});
end
