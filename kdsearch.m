function [] = kdsearch(node)


global y_model z_model yq m_search L_done pqd pqr pqz b_upper b_lower sort_list node_list

if L_done return, end

if node_list(node,3) == 0 % it's a terminal node, so...
    % first, compute the distances...
    yi = node_list(node,1:2); % index bounds of all y_model to consider
    yt = y_model(:,yi(1):yi(2));
    zt = z_model(:,yi(1):yi(2));
    dist = zeros(size(yt(1,:))); % initialize
    d = length(yq); % get the dimension 
    for j = 1:d, 
        dist = dist + (yt(j,:)-yq(j)).^2; 
    end
    dist = sqrt(dist);
    % and then sort them and load pqd, pqr, and pqz
    pqd = [dist pqd]; % distances ^2
    pqr = [yt pqr];  % current neares neighbors
    pqz = [zt pqz]; % corresponding entries in z
    [pqd, index] = sort(pqd); % distances
    [junk, len] = size(pqz);
    if length(index) > len
        pqr = pqr(:,index(1:length(pqz)));
        pqz = pqz(:,index(1:length(pqz)));
    else
        pqr = pqr(:,index);
        pqz = pqz(:,index);
    end % if statement
    % keep only the first m_search points
    if length(pqd) > m_search, pqd = pqd(1:m_search); end
    [junk, len] = size(pqz);
    if len > m_search
        pqr = pqr(:,1:m_search);
        pqz = pqz(:,1:m_search);
    end % if statement
    if within
        L_done = 1;
    end % if statement
    return
else % it's not a terminal node, so search a little deeper
    disc = sort_list(node,1);
    part = sort_list(node,2);
    if yq(disc) <= part % determine which child node to go to
        temp = b_upper(disc);
        b_upper(disc) = part;
        kdsearch(node_list(node,3))
        b_upper(disc) = temp;
    else
        temp = b_lower(disc);
        b_lower(disc) = part;
        kdsearch(node_list(node,4))
        b_lower(disc) = temp;
    end % of the if statement
    if L_done return, end
    if yq(disc) <= part % determin whether other child node needs to be searched
        temp = b_lower(disc);
        b_lower(disc) = part;
        if overlap
            kdsearch(node_list(node,4)); 
        end
        b_lower(disc) = temp;
    else
        temp = b_upper(disc);
        b_upper(disc) = part;
        if overlap
            kdsearch(node_list(node,3)); 
        end
        b_upper(disc) = temp;
    end % if statement
    if L_done return, end
end % of the outermost if