function struc = fieldset(struc, fields, valvec)
for i = 1:length(fields)
    struc.(fields{i}) = valvec(i);
end
