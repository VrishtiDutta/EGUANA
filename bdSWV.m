% Scaled windowed analysis using bridge detrending.
%	Eke, A., Hermal, P., Kocsis, L., & Kozak, L.R. (2002). Fractal characterization
%	of complexity in temporal physiological signals. Physiol. Meas., 23: R1-R38.

function m = bdSWV(x, dt, tMinFit, tMaxFit, generatePlot)

nWinSizes = 100;

nx = length(x);

winMin = 4;
winMax = round(nx / 2);
if (~generatePlot)
	winMin = max([winMin floor(tMinFit / dt)]);
	winMax = min([winMax  ceil(tMaxFit / dt)]);
end

nw = winMax - winMin + 1;
if (nw < 8)
	m = 0;
	return;
end

if (nw <= nWinSizes)
	% Linearly spaced window sizes.
	winSize = linspace(winMin, winMax, nw);
else
	% Logarithmically spaced window sizes.
	winSize = unique(round(exp(linspace(log(winMin), log(winMax), nWinSizes))));
	nw = length(winSize);
end

sigma = zeros(1, nw);

% Loop over window sizes.
for i = 1 : nw
	nWin = floor(nx / winSize(i));
	last = nWin * winSize(i);
	xx = reshape(x(1:last), winSize(i), nWin);
	
	% Bridge detrending.
	for j = 1 : nWin
		xx(:, j) = xx(:, j) - linspace(xx(1, j), xx(end, j), winSize(i))';
	end
	
	% Standard deviation for this window size.'
	sigma(i) = mean(std(xx));
end

% Fit slope of line.
time = winSize*dt;
index = find(time >= tMinFit & time <= tMaxFit);
i0 = index(1);
i1 = index(end);
ny = length(index);
X = [ones(ny, 1) log(winSize(i0:i1)')];
y = log(sigma(i0:i1)');

a = X \ y;

m = a(2);

if (generatePlot)
	loglog(time, sigma, '.');
	
	yfit = exp(X * a);
	
	hold on;
	loglog(time(i0:i1), yfit, 'r-');
	hold off;
	
	xlabel('Window Size (s)');
	ylabel('\sigma (N)');
end

end
