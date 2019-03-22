clear all
close all

u_hat = rand(3, 2, 4);

u_hat(1, 1, 1) = 0.6; u_hat(1, 2, 1) = 0.7;
u_hat(1, 1, 2) = 0.61; u_hat(1, 2, 2) = 0.71;
u_hat(1, 1, 3) = 0.62; u_hat(1, 2, 3) = 0.72;
u_hat(1, 1, 4) = 0.63; u_hat(1, 2, 4) = 0.73;

u_hat(2, 1, 1) = 0.1; u_hat(2, 2, 1) = 0.1;
u_hat(2, 1, 2) = 0.9; u_hat(2, 2, 2) = 0.9;
u_hat(2, 1, 3) = 0.1; u_hat(2, 2, 3) = 0.1;
u_hat(2, 1, 4) = 0.9; u_hat(2, 2, 4) = 0.9;


b = zeros(3, 1, 4);
a = zeros(3, 1, 4);
v = zeros(3, 2);
r = 19;

for ii = 1:r
  # softmax b
  c = exp(b)./sum(exp(b), 1);

  s = sum(u_hat .* c, 3);

  # squash
  square = s.^2;
  square_sum = sum(square, 2);
  s_norm = square_sum.^(0.5);
  s_factor = (s_norm.^2)./(s_norm .* (1 + s_norm.^2));
  v = s_factor .* s
  
  figure(1)
  hold on
  grid on
  axis equal
  plot(v(1, 1), v(1, 2), 'ob')
  plot(v(2, 1), v(2, 2), 'or')

  %axis equal;xlim([-1 1]);ylim([-1 1]);
  
  a = u_hat .* v;
  b = b + sum(a, 2);
endfor
