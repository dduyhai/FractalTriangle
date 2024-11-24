close('all');
clear('all');
addpath('../src/');

y = chaos_game(1e+5);
c = linspace(1, 10, size(y, 1));
scatter(y(:, 1), y(:, 2), [], c);
