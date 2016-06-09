% Detrended fluctuation analysis.
%	Eke, A., Hermal, P., Kocsis, L., & Kozak, L.R. (2002). Fractal characterization
%	of complexity in temporal physiological signals. Physiol. Meas., 23: R1-R38.

function m = dfa(dx, dt, tMinFit, tMaxFit, generatePlot)

nWinSizes = 100;

markerSize = 12;
lineWidth = 2.5;
fontSize = 16;
fontWeight = 'bold';

xUnits = 'periods';
yUnits = 's';

x = cumsum(dx);
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
	abscissa = 1:winSize(i);
	
	% Least-squares detrending.
	for j = 1 : nWin
		yy = xx(:, j);
		X = [ones(winSize(i), 1) abscissa'];	%'
		a = X \ yy;
		yfit = X * a;
		
		xx(:, j) = xx(:, j) - yfit;
	end
	
	% RMS fluctuation for this window size.
	sigma(i) = mean(sqrt(mean(xx.^2)));
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
	%h = loglog(time, sigma, '.');
	h = loglog(time, sigma, 'k.');
	set(h, 'LineWidth', lineWidth, 'MarkerSize', markerSize);
	
	yfit = exp(X * a);
	
	hold on;
	%h = loglog(time(i0:i1), yfit, 'r-');
	h = loglog(time(i0:i1), yfit, 'k-');
	set(h, 'LineWidth', lineWidth, 'MarkerSize', markerSize);

	h = gca();
	set(h,'FontSize', fontSize, 'fontweight', fontWeight);
	hold off;
	
	h = xlabel(['Window Size (' xUnits ')']);
	set(h,'FontSize', fontSize, 'FontWeight', fontWeight);
	
	h = ylabel(['RMS Fluctuation (' yUnits ')']);
	set(h,'FontSize', fontSize, 'FontWeight', fontWeight);
end

end
