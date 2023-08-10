
modsF = (abs(F)).^2;

lambda = 12.3984/En;
theta = asind(lambda./2*sqrt((Q(:,1)/aa).^2+(Q(:,2)/bb).^2+(Q(:,3)/cc).^2));
extinction = (1+1e-3*extpar*modsF*lambda^3./sind(2*theta)).^(-1/2);

yy = scale * extinction .* modsF;

end

