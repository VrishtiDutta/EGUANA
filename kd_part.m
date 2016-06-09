function [] = kd_part(y_in, z_in, bin_size);

% Algorithms from:
%
% "Data Structures for Range Searching", J.L. Bently, J.H. Friedman,
% ACM Computing Surveys, Vol 11, No 4, p 397-409, December 1979
%
% "An Algorithm for Finding Best Matches in Logarithmic Expected Time", 
% J.H. Friedman, J.L. Bentley, R.A. Finkel, ACM Transactions on 
% Mathematical Software, Vol 3, No 3, p 209-226, September 1977.

global y_model z_model sort_list node_list

y_model = y_in;
z_model = z_in;
[d, n_y] = size(y_model);
% d: dimension of phase space
% n_y: number of points to put into partitioned database

% Set up first node...
node_list = [1 n_y 0 0];
sort_list = [0 0];

% ...and the information about the number of nodes so far
node = 1;
last = 1;

while node <= last % check if the node can be divided

range = [];
segment = node_list(node,1):node_list(node,2);
for i = 1:d range = [range max(y_model(i,segment))-min(y_model(i,segment))]; end
if max(range) > 0 & length(segment)>= bin_size % it is divisible
   [r_sort, index] = sort(range);
   yt = y_model(:,segment);
   zt = z_model(:,segment);
   [y_sort, y_index] = sort(yt(index(d),:));
   % estimate where the cut should go
   [junk, tlen] = size(yt);
   if rem(tlen,2) % yt has an odd number of elements
      cut = y_sort((tlen+1)/2);
   else % yt has an even number of elements
      cut = (y_sort(tlen/2)+y_sort(tlen/2+1))/2;
   end % of the median calculation
   L = y_sort <= cut;
   if sum(L) == tlen % then the right node will be empty...
      L = y_sort < cut;  % ...so use a slightly different boundary
      cut = (cut+max(y_sort(L)))/2;
   end % of the cut adjustment
   % adjust the order of the data
   y_model(:,segment) = yt(:,y_index);
   z_model(:,segment) = zt(:,y_index);
   % mark this as a non-terminal node
   sort_list(node,:) = [index(d) cut];
   node_list(node,3) = last + 1;
   node_list(node,4) = last + 2;
   last = last + 2;
   % add the information for the new nodes
   node_list = [node_list; segment(1) segment(1)+sum(L)-1 0 0];
   node_list = [node_list; segment(1)+sum(L) segment(tlen) 0 0];
   sort_list = [sort_list; 0 0; 0 0]; % assume they're terminal for the moment
end % of the splitting process

node = node + 1;

end % of the while loop

