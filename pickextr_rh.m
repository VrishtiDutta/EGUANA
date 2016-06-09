function [peak, peaktime,valley,valleytime,Data] = pickextr_rh(Data, rc, rc_int, dt)
%PICKEXTR Pick significant peaks and valleys in data.
%
% [Peaks, Valls] = pickextr(Data, rc, rc_int, dt) picks significant
% extrema in "Data". Significance is determined by the relative
% criterion "rc" (0 < rc < 1) and the time-interval "rc_int" (> 0).
% The absolute criterion is determined by "rc" times the range in
% an interval "rc_int" before and after the current point. In formula:
% index = find((time >= time(i)-rc_int) & (time <= time(i)+rc_int));
% crit(i) = rc*(max(data(index)) - min(data(index)))
%
% The optional fourth argument "dt" allows for specification of the
% sampling interval. Giving this speeds up the code signifcantly.
%
% The first column of Peaks and Valls contains the extrema, the
% second the time of occurence and the third the absolute criterion
% used in establishing significance.
%
% Input:  Data     N by 2+ first col: data, second col: time
%         rc       1 by 1  relative criterion, 0 < rc < 1
%         rc_int   1 by 1  interval of relative criterion, rc_int > 0
% (opt)   dt       1 by 1  sample time, dt > 0
% Output:peak, peaktime,valley,valleytime,Data

%	Note:(1)The smaller the rc is, the more peaks and valls can be detected.
%			(2)The smaller the rc_int is, the more peaks and valleies can be detected.
%			(3)dt=1/sample rate

% Version 1.0, 14 august 1996 by Tjeerd Dijkstra.
% This routine is part of "RelPhase.Box", a toolbox for relative
% phase analysis of oscillatory systems. See the manual or README
% file for conditions under which this software may be used.
%
% % Tested with MATLAB 4.2c on a PowerMac 6100 under System 7.5.1

% Notes: I made the choice that the first or last data point can never
% be an extremum. This assumption makes the code more compact.

%% first some checking of the arguments
if (nargin ~= 3) && (nargin ~= 4),
	fprintf('Error in pickextr: Number of arguments is %d, ', nargin);
	fprintf('should be 3 or 4\n'); peak = []; peaktime=[]; 
    valley = []; valleytime=[]; Data=[]; return;
end
[N, M] = size(Data);
if M < 2,
	fprintf('Error in pickextr: Data has %d columns, should be 2+\n', M);
	peak = []; peaktime=[]; 
    valley = []; valleytime=[]; Data=[]; return;
end
if N < 3,
	fprintf('Error in pickextr: Data has less than 3 datapoints\n');
	peak = []; peaktime=[]; 
    valley = []; valleytime=[]; Data=[]; return;
end
index = find(diff(Data(:, 2)) < 0, 1);
if ~isempty(index),
	fprintf('Error in pickextr: time is not strictly increasing\n');
	peak = []; valley = []; return;
end
if (rc <= 0) || (rc >= 1) || (rc_int <= 0),
	fprintf('Error in pickextr: rc or rc_int out of range\n');
	peak = []; peaktime=[]; 
    valley = []; valleytime=[]; Data=[]; return;
end
if nargin == 4,
	if dt <= 0,
		fprintf('Error in pickextr: dt is negative\n');
	 	peak = []; peaktime=[]; 
        valley = []; valleytime=[]; Data=[]; return;
	end
end

%% saves the incresings and decresing times by 1 and -1
diff_data = diff(Data(:, 1)); 
index = find(diff_data > 0);
diff_data(index) = ones(1, length(index));
if isempty(index),
	fprintf('Error in pickextr: Data is non-increasing\n');
	peak = []; peaktime=[]; 
    valley = []; valleytime=[]; Data=[]; return;
end
index = find(diff_data < 0);
diff_data(index) = -ones(1, length(index));
if isempty(index),
	fprintf('Error in pickextr: Data is non-decreasing\n');
	peak = []; peaktime=[]; 
    valley = []; valleytime=[]; Data=[]; return;
end

% first treat the points with diff exactly zero
index = find(diff_data == 0); len_index = length(index);
len = length(diff_data); cand_extr = [];
if len_index > 0,
	if index(1) == 1, % throw away leading zeros of diff_data
		j = 2;
		while diff_data(j) == 0,		
			j = j + 1;
		end
		index = index(j:length(index));
		len_index = len_index - j + 1;
	end
end
if len_index > 0,
	if index(len_index) == len, % throw away trailing zeros
		j = len - 1;
		while diff_data(j) == 0,		
			j = j - 1;
		end
		index = index(1:len_index - (len - j));
		len_index = len_index - (len - j);
	end
end
if len_index > 0,	
	i = 1; k= 1; % treat the zeros in the middle
	while i <= len_index,
		j = 1;
		while diff_data(index(i) + j) == 0,		
			j = j + 1;
		end
		cand_extr(k) = index(i) + j/2;
		k = k + 1;
		i = i + j;
	end
end

% collect all extrema
% I am adding the first and last point so that (1) I always find an
% extremum when there is only one and (2) I do not need an extra test
% to establish signigifance of the last candidate.
index = find(abs(diff(diff_data)) > 1);
data = [Data(1, 1); Data((index + ones(size(index))), 1); Data(N, 1)];
time = [Data(1, 2); Data((index + ones(size(index))), 2); Data(N, 2)];
if ~isempty(cand_extr),
	data2 = mean([Data(floor(cand_extr), 1)'; Data(ceil(cand_extr), 1)'])';
	time2 = mean([Data(floor(cand_extr), 2)'; Data(ceil(cand_extr), 2)'])';
	[time, index] = sort([time; time2]);
	data = [data; data2]; data = data(index);
end

% establish the absolute criterion for significance
[max_data, max_index] = max(data);
[min_data, min_index] = min(data);
if 2*rc_int >= (max(time) - min(time)),
	crit = rc*(max_data - min_data)*ones(size(data));
else
	crit = zeros(size(data));
	for i = 1:length(data),
		index = find((time >= time(i) - rc_int) & ...
						(time <= time(i) + rc_int));
		if nargin == 4,
			lo = max([round((time(i) - time(1) - rc_int)/dt), 1]);
			hi = min([round((time(i) - time(1) + rc_int)/dt), N]);
			index1 = 0;	% dummy value
		else
			index1 = find((Data(:, 2) >= time(i) - rc_int) & ...
						(Data(:, 2) <= time(i) + rc_int));
			lo = index1(1);
			hi = index1(length(index1));
		end
		if isempty(index) || isempty(index1),
			fprintf('Warning in pickextr: Could not calculate ');
			fprintf('absolute criterion at time %f.\n', time(i));
			fprintf('I suggest increasing rc_int\n');
			crit(i) = rc*(max_data - min_data);
		else
			crit(i) = rc*(max([data(index); Data(lo, 1)]) - ...
						min([data(index); Data(hi, 1)]));
		end
	end
end

% find the significant extrema.
% first find a signifcant extremum and then find the others.
if crit(max_index) > crit(min_index),
	start_extr = max_data; start_i = max_index; start_type = 1;
else
	start_extr = min_data; start_i = min_index; start_type = -1;
end

% find extrema from start_i to end of data
peak_index = zeros(1, length(data)); vall_index = zeros(1, length(data));
prev_extr = start_extr; prev_index = start_i; prev_type = start_type;
for i = start_i+1:length(data),
	if prev_type > 0, % previous extremum maximum, now look for minimum
		if (prev_extr - data(i) >= crit(i)) && ...
				(prev_extr - data(i) >= crit(prev_index)),
			peak_index(prev_index) = 1;
			prev_extr = data(i); prev_index = i; prev_type = -1;
		elseif prev_extr < data(i),
			prev_extr = data(i); prev_index = i;
		end
	else              % previous extremum minimum, now look for maximum
		if (data(i) - prev_extr >= crit(i)) && ...
				(data(i) - prev_extr >= crit(prev_index)),
			vall_index(prev_index) = 1;
			prev_extr = data(i); prev_index = i; prev_type = 1;
		elseif data(i) < prev_extr,
			prev_extr = data(i); prev_index = i;
		end
	end
end

% find extrema from start_i to begin of data
prev_extr = start_extr; prev_index = start_i; prev_type = start_type;
for i = start_i-1:-1:1,
	if prev_type > 0, % previous extremum maximum, now look for minimum
		if (prev_extr - data(i) >= crit(i)) && ...
				(prev_extr - data(i) >= crit(prev_index)),
			peak_index(prev_index) = 1;
			prev_extr = data(i); prev_index = i; prev_type = -1;
		elseif prev_extr < data(i),
			prev_extr = data(i); prev_index = i;
		end
	else              % previous extremum minimum, now look for maximum
		if (data(i) - prev_extr >= crit(i)) && ...
				(data(i) - prev_extr >= crit(prev_index)),
			vall_index(prev_index) = 1;
			prev_extr = data(i); prev_index = i; prev_type = 1;
		elseif data(i) < prev_extr,
			prev_extr = data(i); prev_index = i;
		end
	end
end


% Weed out the first and the last point
peak_index = find(peak_index > 0);
if ~isempty(peak_index),
	if peak_index(length(peak_index)) == N,
		peak_index = peak_index(1:length(peak_index)-1);
	end
end
if ~isempty(peak_index),
	if peak_index(1) == 1,
		peak_index = peak_index(2:length(peak_index));
	end
end
%Peaks = [data(peak_index), time(peak_index), crit(peak_index)];
peak = data(peak_index);
peaktime = time(peak_index);

vall_index = find(vall_index > 0);
if ~isempty(vall_index),
	if vall_index(length(vall_index)) == N,
		vall_index = vall_index(1:length(peak_index)-1);
	end
end
if ~isempty(vall_index),
	if vall_index(1) == 1,
		vall_index = vall_index(2:length(vall_index));
	end
end

%Valls = [data(vall_index), time(vall_index), crit(vall_index)];
valley = data(vall_index);
valleytime = time(vall_index);





%%if N_fit > 0,	%	do the quadratic fit
%%	j = 1;
%%	for i = 1:length(data),
%%		j = j - 1 + find(Data(j:N, 2) == time(i));
%%		index = [max([1, (j-N_fit)]):min([N, (j+N_fit)])]';
%%		p = polyfit(Data(index, 2) - time(i), Data(index, 1), 2);
%%		max_time = -p(2)/(2*p(1));
%	following limits the maximal time shift to 1 time step, seems
%		reasonable but might be relaxed.
%%		if abs(max_time) < min(diff(Data(j-1:j+1, 2))),
%%			time(i) = time(i) + max_time;
%%			data(i) = p(1)*max_time^2 + p(2)*max_time + p(3);
%%		end
%%	end
%%en
