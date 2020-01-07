function [SP, Erout] = batch_example_paths(A)

mask_ut = triu(true(size(A)),1);

%% integration - shortest paths - efficiency - search-information
[SP.distance,SP.length,SP.B] = get_shortest_path_lengths(1./A); %distance can be expressed as -log(A), as 1./A and in other ways...

Erout = mean(1./SP.distance(mask_ut)); %efficency of routing (usually called global efficiency)

SP.I = get_information_shortest_paths_wei_und(A,SP.length,SP.B,sum(A),1); %compute pairwise search-information
%compute pairwise search-information
Isym=(SP.I+SP.I')/2; % search information is not a symmetric measurement
Isym(logical(eye(size(SP.I))))=0; %set main diagonal to zero


%% shortes-path plots
% figure,
% subplot(1,3,1); imagesc(SP.length); axis square; title('Shortest-paths (length)'); colorbar;
% xlabel('Map regions'); ylabel('Map regions');
% caxis([0,prctile(SP.length(mask_ut),95)]);
% set(gca,'xtick',[]); set(gca,'ytick',[]);
% subplot(1,3,2); imagesc(SP.distance); axis square; title('Shortest-paths (# edges)'); colorbar;
% xlabel('Map regions'); ylabel('Map regions');
% caxis([prctile(SP.distance(mask_ut),5),prctile(SP.distance(mask_ut),95)]);
% set(gca,'xtick',[]); set(gca,'ytick',[]);
% subplot(1,3,3); imagesc(SP.I); axis square; title ('Shortest-paths (search-information)'); colorbar;
% xlabel('Map regions'); ylabel('Map regions');
% caxis([prctile(SP.I(mask_ut),5),prctile(SP.I(mask_ut),95)]);
% set(gca,'xtick',[]); set(gca,'ytick',[]);


end


