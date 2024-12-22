function c = generateNoLineal(inputStr, inputX, inputN)
	x0 = inputX;
	n = inputN;
	for i = 1:length(inputStr)
		fInput = inputStr{i};
		ftemp = ['@(x, y) ', fInput];
		f{i} = str2func(ftemp);
	end

	if length(x0) == 2
		syms x y;
		var = [x, y];

		for i = 1:2
			for j = 1:2
				df_d{i, j} = diff(f{i}(x, y), var(j));
			end
		end

		J = [df_d{1, 1}, df_d{1, 2}; df_d{2, 1}, df_d{2, 2}];
		Jinv = inv(J);

		Jinv = matlabFunction(Jinv);

		xf = [cell2mat(x0(1)), cell2mat(x0(2))];
		for i = 1:n
			delta = Jinv(xf(1), xf(2)) * [f{1}(xf(1), xf(2)); f{2}(xf(1), xf(2))];
			xf = xf - delta';
			result{i} = xf;
		end
	end

	for i = 1:n
		tablevaluesx{i, 1} = result{i}(1);
		tablevaluesy{i, 1} = result{i}(2);
	end

	tablevalues = [tablevaluesx, tablevaluesy];

	figure;
	hold on;

	% Se crea una linea vertical para cada valor de x
	for i = 1:n
		plot(result{i}(1), result{i}(2), 'o');
	end

	t = uitable ('Data', tablevalues, 'Position', [20 20 260 200]);

	hold off;
end

%inputStr = {'x^2 + x * y - 10', 'y + 3 * x * y^2 - 57'};
%inputX = [1, 1];
%inputN = 10;
%generateNoLinea(inputStr, inputX, inputN);