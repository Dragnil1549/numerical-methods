clc
clear

X = [5 9 15 19 22 28 30 33 37 40];
Y = [11 12 13 16 17 17 19 19 23 25];
N = length(X); %���������� ����� ������ �������� ��������� �������
plot(X, Y, 'b--');

%���� ����������
sum_x = 0; %����� x
sum_x_sqr = 0; %����� x^2
sum_x_cube = 0; %����� x^3
sum_x_4 = 0; %����� �^4
sum_xy = 0; %����� � * �
sum_x2y = 0; %����� �^2 * y 
sum_y = 0; %����� y
mid_x = 0; %x �������
mid_y = 0; %y �������
top_a = 0; %��������� ������������ �
bottom_a = 0; %����������� ������������ �

%���� ����������
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
%���������� ����������� ���������� ��������� 
for i = 1:N
   top_a = top_a + ((X(i) - mid_x) .* (Y(i) - mid_y));
   bottom_a = bottom_a + (X(i) - mid_x).^2;
end

a = top_a ./ bottom_a;
b = mid_y - a .* mid_x;


%���������� ��� ��� �������� �������
f = Y;
for i = 1:N
    f(i) = a .* X(i) + b;
end
hold on;
plot(X, f);
hold off;


%��� ��� �������������� �������
matr = [N sum_x sum_x_sqr;
        sum_x sum_x_sqr sum_x_cube;
        sum_x_sqr sum_x_cube sum_x_4;];

%������� ������� ����� �������� �������
invMatr = inv(matr);
sums = [sum_y; sum_xy; sum_x2y];


%�������� �������  = ������������ a b c
A = invMatr * sums;
c_1 = A(1);
b_1 = A(2);
a_1 = A(3);

%���������� ��� ��� �������������� �������
F(8) = 1;
for i = 1:N
    F(i) = a_1 .* (X(i))^2 + b_1 .* X(i) + c_1;
end

hold on; % ������������ ����������� ������ �������� � ������� ����
plot(X, F);
grid on; % ������� ������������ ����� 
title('���');
legend('�������������� ������', '-0.74� + 2.4679', '-0.0137x^2 -1.2901x + 7.0164') 
hold off;