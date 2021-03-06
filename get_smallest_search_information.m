% input:    D - refer search_information
% output:   D is the distance between all pairs of elements
%           P is the number of edges in the path
%           B is a matrix whose element b_ij is the last node
%           in the shortest path between i and j
function [D P B] = get_smallest_search_information(D)
 
P = double(D>0);
%D(D == 0) = inf;
n = size(D,1);

B = repmat(1:n,n,1);
for k=1:n
    
    i2k_k2j = bsxfun(@plus, D(:,k),D(k,:));
    
    if nargout>1 
        path = bsxfun(@gt, D, i2k_k2j);
        [i j] = find(path);  
        P(path) = P(i,k) + P(k,j)';
        B(path) = B(i,k);
    end
    D = min(D, i2k_k2j);
    %D(i2k_k2j<D)=i2k_k2j(i2k_k2j<D);
end

