function v = valoresExpansion(retorno, coeffs, i, numDerivatives, h)
	% Actualmente se conocen los valores desde 0 hasta 2 derivadas
	if retorno == "diagonal"
		if numDerivatives == 0
			% Se obtiene el valor de la funcion
			v = 1;
		elseif numDerivatives == 1
			% Se obtiene el valor de la derivada
			v = -coeffs(2, i)
		elseif numDerivatives == 2
			% Se obtiene el valor de la segunda derivada
			v = -coeffs(2, i) - (2 / h^2);
		end
	elseif retorno == "adyDerecha"
		if numDerivatives == 0
			% Se obtiene el valor de la funcion
			v = 0;
		elseif numDerivatives == 1
			% Se obtiene el valor de la derivada
			v = 1 / (2 * h);
		elseif numDerivatives == 2
			% Se obtiene el valor de la segunda derivada
			v = -(coeffs(1, i) / (2 * h)) + (1 / h^2);
		end
	elseif retorno == "adyIzquierda"
		if numDerivatives == 0
			% Se obtiene el valor de la funcion
			v = 0;
		elseif numDerivatives == 1
			% Se obtiene el valor de la derivada
			v = -1 / (2 * h);
		elseif numDerivatives == 2
			% Se obtiene el valor de la segunda derivada
			v = (coeffs(1, i) / (2 * h)) + (1 / h^2);
		end
	elseif retorno == "b"
		v = coeffs(3, i);
	elseif retorno == "b0"
		v = coeffs(3, 2);
	elseif retorno == "bf"
		v = coeffs(3, i)
	end
end