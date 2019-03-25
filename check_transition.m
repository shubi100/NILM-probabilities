function p = check_transition(i,j, idx)

s=0;
for c=1:length(idx)-1 % minus one here is bcz for c=144 index exceeds no. of array elements while iteration.
    if idx(c)==i && idx(c+1)==j % here both i and j are fixed in 
                                % their looping scenarios.
       s=s+1;
    end
end
p = s/(length(idx)-1);
end