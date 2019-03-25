clear 
close all

% 1st we are analysing our data.

rfg = load('channel_5.dat');
rfg = downsample(rfg,20);
x1 = rfg(:,1);
x2 = rfg(:,2);
plot(x1,x2);

% finding the number of unique VA values in coloumn 2 of rfg dataset
a=x2(x2~=0);

B = unique(a);

% now finding how many times each number is ocurring in rfg dataset
Ncount = histc(a, B);  

stem(B, Ncount);
z= [B  Ncount];
z = medfilt1(z);

% next we are going to use kmeans clustering algorithm with its syntax

iNumClusters = 3;
iNumReplicates = 10;
[idx,C] = kmeans(z,iNumClusters,'Distance','cityblock',...
    'Replicates',iNumReplicates);

% Now plot the cluster and cluster centroids...


plot(z(idx==1,1),z(idx==1,2),'r.','MarkerSize',12)
hold on
plot(z(idx==2,1),z(idx==2,2),'b.','MarkerSize',12)
hold on
plot(z(idx==3,1),z(idx==3,2),'k.','MarkerSize',12)
%hold on
% plot(log10(rfg(idx==3,1)), rfg(idx==3,2) ,'g.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)

% legend('Cluster 1','Cluster 2','Cluster 3','Centroids',...
%        'Location','NW')
title 'Cluster Assignments and Centroids'
hold off



% Transition probabilities calculation.
A=[];
for i=1:max(idx)     % this loop is for no. of rows formation
    for j=1:max(idx) % this loop is for no. of columns formation in a matrix.
        A(i,j)=check_transition(i,j,idx);
    end
end

% Initial probabilities calculation.
Pi=[];
i=1;
for j=1:max(idx)
    Pi(i,j)=initial_probabilities(i,j,idx);
end

% Emission probabilities calculation.
B=[];
for i=1:max(idx)
    w=Ncount(idx==i);
    for j=1:length(w)
        B(i,j)= emission_probabilities(i,j,w);
    end
end
