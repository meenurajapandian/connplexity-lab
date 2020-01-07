%Input: Filename, eg.: 'C:/.../Filename.gml
%Output: Adjacency matrix, number of node

function [A,nodeNumbers,nodeLabels] = read_gml_into_network(fileName)

inputfile = fopen(fileName);

nodeNumbers=[]; % list of numbered nodes
nodeLabels={};  % list of node labels
edges = [];
weights = [];
tline=0;
while (tline~=-1) %while there are lines in the file to read
      tline = fgetl(inputfile); %read line
      if strfind(tline,'node')
        tline2 = fgetl(inputfile);
        tline3 = fgetl(inputfile);
        aux = regexp(tline3,'\d+','match'); % get ID of the node
        nodeNumbers(end+1,1) = str2num(aux{1});
        tline4 = fgetl(inputfile);
        aux = regexp(tline4,'\s+','split');
        aux = aux{end}; %get label of the node
        aux = aux(2:end-1); %remove quotes
        nodeLabels{end+1,1} = aux;
      end
      if strfind(tline,'edge')
        tline2 = fgetl(inputfile); % [
        tline3 = fgetl(inputfile); % source
        aux = regexp(tline3,'\s+','split');
        source = str2num(aux{end});
        tline4 = fgetl(inputfile); % target
        aux = regexp(tline4,'\s+','split');
        target = str2num(aux{end});
        tline5 = fgetl(inputfile); % ] or value
        if strfind(tline5,'value')
            aux = regexp(tline5,'\s+','split');
            weights(end+1) = str2num(aux{end});
            tline6 = fgetl(inputfile); % ]
        end
        edges(end+1,:) = [source,target];
      end
end

if min(edges(:))==0
    edges = edges+1; %relabel nodes so that they start on 1 and not on zero
end

N = max(edges(:)); %number of nodes
A = zeros(N,N); %adjacency matrix
for i=1:size(edges,1)
    if isempty(weights)
        A(edges(i,1),edges(i,2)) = 1;
    else
        A(edges(i,1),edges(i,2)) = weights(i);
    end
end

%%symmetrize adjacency matrix (only for undirected networks!)
A = A+A';
