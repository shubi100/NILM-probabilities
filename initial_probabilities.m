function f=initial_probabilities(i,j,idx)
f=0;
for c=1:length(idx)
    
    if idx(c)==j % here j is fixed for their respective iterations.
        f=f+1;   % i.e. for j=1__ c values goes from 1 to length of idx.
    end
end
f=f/length(idx);
end