function L = overlap 

% algorithms from:
% "Data Structures for Range Searching", J.L. Bently, J.H. Friedman,
% ACM Computing Surveys, Vol 11, No 4, p 397-409, December 1979
%
% "An Algorithm for Finding Best Matches in Logarithmic Expected Time", 
% J.H. Friedman, J.L. Bentley, R.A. Finkel, ACM Transactions on 
% Mathematical Software, Vol 3, No 3, p 209-226, September 1977.

global y_model z_model yq m_search L_done pqd pqr pqz b_upper b_lower sort_list node_list

dist = pqd(m_search)^2;
sum = 0;

for i = 1:length(yq)

if yq(i) < b_lower(i)
    sum = sum + (yq(i)-b_lower(i))^2;
    if sum > dist
	L = 0;
	return
    end % of the sum > dist if
elseif yq(i) > b_upper(i)
    sum = sum + (yq(i)-b_upper(i))^2;
    if sum > dist
	L = 0;
	return
    end % of the sum > dist if
end % of the yq(i) <> a bound if

end % of the i loop

L = 1;
return
