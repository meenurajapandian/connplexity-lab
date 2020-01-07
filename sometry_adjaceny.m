clear all;
load('/home/mrajapan/Dropbox/meenu/data/dolphins.mat');
A = dolphins;
n = size(A,1);
% To convert network to draw on cytoscape
% ii = 1;
% jj = 1;
% for i = 1:n
%     for j = 1:n
%         if A(i,j) == 1 && i<j
%             E(ii,1) = i;
%             E(jj,2) = j;
%             ii = ii + 1;
%             jj = jj + 1;
%         end
%     end
% end
% xlswrite('C:\Users\Meenu\Documents\sometry.xlsx', E, 1);
% coln = {'A1' 'B1' 'C1' 'D1' 'E1' 'F1' 'G1' 'H1' 'I1' 'J1' 'K1' 'L1' 'M1' 'N1' 'O1' 'P1' 'Q1' 'R1' 'S1' 'T1' 'U1' 'V1' 'W1' 'X1' 'Y1' 'Z1'};
col = {'r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k'};
J = ones(n,1);
rep = 100;
T = A;
for i = 1:rep
    if i > 1
        T = T * A;
    end        
    %Same as A^k = no. of paths of length k
    W(:,i) = T*J; %Sum of all elements of a row; Sending a person along each path;
    WT(:,i) = W(:,i) ./ sum(W(:,i)); %Normalize it with the highest value ARBITRARY? How do I compare with other nodes.
%    xlswrite('C:\Users\Meenu\Documents\sometry.xlsx', W, 2, coln{i+1});
end

% Estrada's communicability sums from k = 0 to inf for number of walks
WC(:,1) = WT(:,1);
for i = 2:rep
    W(:,i) = W(:,i) + W(:,i-1);
    WC(:,i) = W(:,i) ./ sum(W(:,i));
end

X = 1:rep;
figure;
%Plot of the normalized Connectivity to see if it reaches the threshold
for i = 1:n
    plot(X,WT(i,:),'Color','k');
    hold on;
end
hold off;
figure;
for i = 1:n
    plot(X,WC(i,:),'Color','k');
    hold on;
end
hold off;

P = f_markov_chain(A);
U = P;
for i = 1:rep
    if i > 1
        U = P*U;
    end
    PT(:,i) = sum(U,2); %same as multiplying with a column vector of 1s.
end

PC(:,1) = PT(:,1);
for i = 2:rep
    PC(:,i) = PT(:,i) + PT(:,i-1);
end

figure;
%Plot of the normalized Connectivity to see if it reaches the threshold
for i = 1:n
    plot(X,PT(i,:),'Color','k');
    hold on;
end
hold off;
figure;
for i = 1:n
    plot(X,PC(i,:),'Color','k');
    hold on;
end
hold off;

% Dependence on the degree?
figure, scatter(WT(:,i),sum(A));
% M = zeros(n,rep);

% Dispersion only from the nodes with WT > 0.5
% M(W>0.5) = 1;
% xlswrite('C:\Users\Meenu\Documents\sometry.xlsx', M, 3, 'B1');

% S = sum(M,2);
% S(S>0) = 1;
%% Simulation of dispersion until all nodes have received information
% i = 1;
% Wx(:,i) = A*S;
% while all(Wx(:,i)) == 0
%     i = i+1;
%     Wx(:,i) = A * Wx(:,i-1);
% end
