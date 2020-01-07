function random_walk_centrality(A)
    n = size(A,1);
    P = f_markov_chain(A);
    K = sum(A,2);
    N = sum(sum(A));
    Pinf = K/N;
    
    