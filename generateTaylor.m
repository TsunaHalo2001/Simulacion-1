function p = generateTaylor(ft, vart, g, c, valint)
	% ft: function handle for the function f(x)
	% ct: point around which the Taylor polynomial is generated
	% valt: value at which the Taylor polynomial is evaluated
	% gt: degree of the Taylor polynomial
	% vart: variable of the function

	ftemp = ['@(', vart, ') ', ft];
    f = str2func(ftemp);

	p = taylorPolynomial(f, c, g);

	fs = sym(f);

	figure;
	hold on;

	fplot([p, fs], [0 valint*2]);

	y_limits = ylim;

	line([valint, valint], y_limits, 'Color', 'r', 'LineStyle', '--');

	y_intersect1 = subs(p, vart, valint);
	y_intersect2 = subs(fs, vart, valint);

	plot(valint, double(y_intersect1), 'bo', 'MarkerFaceColor', 'b');
	plot(valint, double(y_intersect2), 'bo', 'MarkerFaceColor', 'b');

	text(valint, double(y_intersect1), sprintf('(%.2f, %.10f)', valint, double(y_intersect1)), ...
		'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
	text(valint, double(y_intersect2), sprintf('(%.2f, %.10f)', valint, double(y_intersect2)), ...
		'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'FontSize', 10);

	formulaText1 = latex(p);
	text(0.1, 0.9, ['$', formulaText1, '$'], 'Interpreter', 'latex', 'FontSize', 14, 'Units','normalized');
	formulaText = latex(fs);
	text(0.9, 0.1, ['$', formulaText, '$'], 'Interpreter', 'latex', 'FontSize', 14, 'Units','normalized');

	xlabel('x');
	ylabel('y');
	lgd = legend('p', 'f', 'Intersection Point');
	lgd.Location = "southwest";

	grid on;
	hold off;
end