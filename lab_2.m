clc
clear

X = [5 9 15 19 22 28 30 33 37 40];
Y = [11 12 13 16 17 17 19 19 23 25];
N = length(X); %возвращает длину самого большого измерения массива
plot(X, Y, 'b--');

%Блок переменных
sum_x = 0; %сумма x
sum_x_sqr = 0; %сумма x^2
sum_x_cube = 0; %сумма x^3
sum_x_4 = 0; %сумма х^4
sum_xy = 0; %сумма х * у
sum_x2y = 0; %сумма х^2 * y 
sum_y = 0; %сумма y
mid_x = 0; %x среднее
mid_y = 0; %y среднее
top_a = 0; %числитель коэффициента а
bottom_a = 0; %знаменатель коэффициента а

%Блок вычислений
for i = 1:N
    sum_x = sum_x + X(i);
    sum_x_sqr = sum_x_sqr + X(i) .^ 2;
    sum_x_cube = sum_x_cube + X(i) .^ 3;
    sum_x_4 = sum_x_4 + X(i) .^ 4;
    sum_x2y = sum_x2y + (X(i)).^2 .* Y(i);
    sum_xy = sum_xy + X(i) .* Y(i);
    mid_x = sum_x ./ N;
    sum_y = sum_y + Y(i);
    mid_y = sum_y ./ N;
end
%нахождение минимизации наименьших квадратов 
for i = 1:N
   top_a = top_a + ((X(i) - mid_x) .* (Y(i) - mid_y));
   bottom_a = bottom_a + (X(i) - mid_x).^2;
end

a = top_a ./ bottom_a;
b = mid_y - a .* mid_x;


%Построение МНК для линейной функции
f = Y;
for i = 1:N
    f(i) = a .* X(i) + b;
end
hold on;
plot(X, f);
hold off;


%МНК для квадратической функции
matr = [N sum_x sum_x_sqr;
        sum_x sum_x_sqr sum_x_cube;
        sum_x_sqr sum_x_cube sum_x_4;];

%Решение системы через обратную матрицу
invMatr = inv(matr);
sums = [sum_y; sum_xy; sum_x2y];


%Элементы матрицы  = коэффициенты a b c
A = invMatr * sums;
c_1 = A(1);
b_1 = A(2);
a_1 = A(3);

%Построение МНК для квадратической функции
F(8) = 1;
for i = 1:N
    F(i) = a_1 .* (X(i))^2 + b_1 .* X(i) + c_1;
end

hold on; % обеспечивает продолжение вывода графиков в текущее окно
plot(X, F);
grid on; % наносит координатную сетку 
title('МНК');
legend('Первоначальный массив', '-0.74х + 2.4679', '-0.0137x^2 -1.2901x + 7.0164') 
hold off;