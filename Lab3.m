clc
clear

format long %������ 15 ������  
n = 0.01; 

F1 = @(x)x.^3+5.*x-4;
F1_for_simple = @(x) x - (1/(3*x.^2+2)).*(x.^3 + 2.*x + 2); 
F1_ = @(x)3*x.^2 + 5; 
F1__ = @(x) 6*x;

%��� �x
F2 = @(x) 0;

x01 = fzero(F1, 0); %����������� ���� �������
y01 = 0;

figure Name 1
    ezplot(F1),hold on; %������ ������
    ezplot(F2);

plot(x01, y01, 'or');


start_answer = Find_start(F1, F1);

disp_start_answer = ['��������� �����������: ', 'x0 = ', num2str(start_answer)];
disp(disp_start_answer)

disp(Niuton(F1, F1_, start_answer, n))

disp(Half_division(F1, -2, 2, n))

disp(Simple_iteration(F1_for_simple, n))


% ���������
%half division answer
function HDA = Half_division(F, a, b , n)
    while b-a > n
        c = (a + b) / 2;
        if F(b)*F(c) < 0
            a = c;
        else 
            b = c;
        end
    end
    HDA = c;
end 
% ��������� �����������
function find_start_answer = Find_start(F, F__)
    n = 0;
    while F(n)*F__(n) < 0
        n = n +1;
    end
    find_start_answer = n;
end
% �������
function Newton_answer = Niuton(F, F_, start_answer, n)
    %n - �������� ���������
    NA_last = start_answer;
    NA_last = NA_last -F(NA_last)/F_(NA_last);
    Newton_answer = 1;
    counter = 0;
    
    while(abs(Newton_answer-NA_last) > n)
        NA_last = Newton_answer;
        Newton_answer = NA_last -F(NA_last)/F_(NA_last);
        counter = counter + 1;
        Calc_err = abs(Newton_answer-NA_last);
        
        disp('-------------------------------------------')
        %About iteration
        Info_AI = ['�������� ����� - ' num2str(counter), ':'];
        %About iteration method
        Info_AIM = ['������������ ����� - '  num2str(Newton_answer)];
        %About iteration calc
        Info_AIC = ['����������� - '  num2str(Calc_err)];
        
        disp(Info_AI);
        disp(Info_AIM);
        disp(Info_AIC);
    end
end

%����� ������� ��������
function SIM = Simple_iteration(F, n)
    x_ = 0;% ��������� ����������� 
    x0 = 0;% ��������� ����������� 
    x1 = F(x0);% ������ �������� 
    N = 100;% ���������� ��������, ����� �� ���� ������������ 
    for counter = 1 : N %������ �������� 100 ��������
        if (x1 - x0).^2/abs(2*x0-x1-x_) < n
            break
        end
        x_ = x0;
        x0 = x1;
        x1 = F(x0);
    end
    disp(counter);
    SIM = x1;
end