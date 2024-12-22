function c = generateFinite(inputStr, inputX0, inputY0, inputXf, inputYf, inputN)
	x0 = inputX0;
	y0 = inputY0;
	xf = inputXf;
	yf = inputYf;
	N = inputN;

	% Se eliminan los espacios
	inputStr = strrep(inputStr, ' ', '');

	% Se divide la ecuaci?n en el lado izquierdo y derecho
	termsStr = strsplit(inputStr, '=');
	termsStrMat = termsStr{2};

	% Se separan los terminos por '+'
	terms = strsplit(termsStrMat, '+');
	coeffsStr = cell(1, length(terms));

	% Se obtienen los coeficientes de los terminos
	for i = 1:length(terms)
		% Se revisa si el termino contiene y
		if contains(terms{i}, 'y')
			aux = strsplit(terms{i}, 'y');
			% Se obtiene el coeficiente
			coeffsStr{i} = aux{1};
		elseif contains(terms{i}, 'x')
			coeffsStr{i} = terms{i};
		end
	end

	% Se obtiene el numero de derivadas a partir del numero de coeficientes
	numDerivatives = length(coeffsStr) - 1;

	% Se inicializa la matriz que un arreglo de textos
	coeffs = cell(1, length(coeffsStr));
	% Se obtiene el termino con x

	for i = 1:length(coeffsStr)
		% Se eliminan los parentesis
		% Se obtiene el coeficiente
		atemp = ['@(x) ', coeffsStr{i}];
		coeffs{i} = atemp;
	end

	% Se obtiene h
	h = (xf - x0) / (N + 1);

	% Se obtiene el arreglo de x
	xi = linspace(x0, xf, N + 2);

	% Se evalua cada coeficiente en cada xi
	coeffsEval = zeros(length(coeffs), length(xi));
	for i = 1:length(coeffs)
		for j = 1:length(xi)
			fcoeffs = str2func(coeffs{i});
			coeffsEval(i, j) = fcoeffs(xi(j))
		end
	end

	% Se inicializa en ceros el vector columna de valores internos
	b = zeros(N, 1);

	% Se crea la matriz identidad
	A = eye(N, N);
	for i = 1:N
		% Se multiplica la matriz identidad por el valor segun su derivada
		A(i, i) = A(i, i) * valoresExpansion("diagonal", coeffsEval, i, numDerivatives, h);
	end

	% Se asignan los valores adyacentes a la diagonal
	for i = 1:N - 1
		% Se asigna el valor segun su derivada
		A(i, i + 1) = valoresExpansion("adyDerecha", coeffsEval, i, numDerivatives, h);
		A(i + 1, i) = valoresExpansion("adyIzquierda", coeffsEval, i, numDerivatives, h);
		b(i) = valoresExpansion("b", coeffsEval, i + 1, numDerivatives, h);
	end

	b(1) = valoresExpansion("b0", coeffsEval, 1, numDerivatives, h) - valoresExpansion("adyIzquierda", coeffsEval, 1, numDerivatives, h) * y0;
	b(N) = valoresExpansion("bf", coeffsEval, N + 1, numDerivatives, h) - valoresExpansion("adyDerecha", coeffsEval, N, numDerivatives, h) * yf;

	A
	b

	y = inv(A) * b;
	y = [y0; y; yf];
	[xi' y];
	figure;
	hold on;
	% Se obtiene la tabla de valores
	t = uitable('Data', [xi' y], 'Position', [20 20 260 200]);

	% Se grafica la solucion
	plot(xi, y, 'r');
	

	% Se muestra la cuadricula
	grid on;
	hold off;
end