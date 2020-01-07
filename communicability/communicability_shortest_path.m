function [X P S]=communicability_shortest_path(A,s,t)

%Communicability_shortest_path       
%	     Generates the communicability distance matrix X of a network. 
%          
% 
%        The entry (i,j) of the matrix X corresponds to the 
%        communicability distance between the nodes i and j in the graph. 
%
%        Then, it obtained the communicability shortest path in a (directed)
%        network between the nodes s and t.
% 
%   Input         A: adjacency matrix 
%                 s: source node
%                 t: end node
% 
%   Output        X: n by n symmetric hollow matrix of communicability 
%                 distances. 
%                 P: nodes in the shortest communicability path starting at
%                 s and ending at t. 
%                 S: length of the shortest communicability path.  
%    
%   Reference:   Estrada, Ernesto, The communicability distance in graphs. 
%                Linear Algebra and its Applications, 436 2012, 4317-4328 
% 
%   Example: [X P S] = communicability_shortest_path(A,1,13);  



% Precalculations              
    A = max(A,A')-diag(diag(A));   
    n = length(A); 
    u = ones(n,1);

% Communicability
 
      G = expm(A);               % Communicability matrix 
     sc = diag(G);               % Vector of self-communicabilities

      
% Communicability distance matrix
    
    CD = (sc*u'+u*sc'-2*G);             %Squared Communicability distance matrix 
     X = CD.^0.5;                       %Communicability distance matrix

% Communicability shortest path

    B = X.*A;						   % Weighted adjacency matrix based on communicability distance matrix 	
    G = digraph(B);                     
    P = shortestpath(G,s,t);            % Shortest communicability path between s and t
    
% Length of the shortest communicability path

    L = length(P)-1; 
    S =0;                  
    
   for i=1:L
      S=S+X(P(i),P(i+1));
   end

