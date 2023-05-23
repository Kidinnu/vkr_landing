clear all; clc;
% Гладкая аппроксимация sign
sgn_a   = @(x) tanh(50*x);
% Гладкая аппроксимация abs
abs_a   = @(x) tanh(50*x).*x;
% Гладкая аппроксимация step (сигмоида)
stp_a   = @(x) 1./(1+exp(-50*x));
subplot(3,1,1);
fplot(sgn_a,[-1,1],'LineWidth',2);
subplot(3,1,2);
fplot(abs_a,[-1,1],'LineWidth',2);
subplot(3,1,3);
fplot(stp_a,[-1,1],'LineWidth',2);

%%
tmesh = linspace(0,5,100);
% Границы управления
p.umax =  1;
p.umin = -1;

solinit = bvpinit(tmesh, @guess);
options = bvpset('RelTol',1e-4,'Stats','on') ;
sol = bvp4c(@(t,q) dqdt(t,q,p), @bcfun, solinit,options);
%
subplot(3,1,1)
plot(sol.x,sol.y(1,:),'-','LineWidth',2)
subplot(3,1,2)
plot(sol.x,sol.y(2,:),'-','LineWidth',2)
subplot(3,1,3)
u = sgn_a(sol.y(5,:)).*stp_a(abs_a(sol.y(5,:))-1);
plot(sol.x,u,'-','LineWidth',2)

% Начальное приближение
function y = guess(x)    
    y = [(1+sin(pi*x/5-pi/2))*0.5*pi;(0+pi/5*cos(pi*x/5-pi/2))*0.5*pi;0; -0.1;1;-1];
end

% Функция правых частей
function dq = dqdt(t,q,p)
    phi = q(1);
    w   = q(2);
    m   = q(3);
    p1  = q(4);
    p2  = q(5);
    p3  = q(6);

    sgn_a   = @(x) tanh(50*x);
    abs_a   = @(x) tanh(50*x)*x;
    stp_a   = @(x) 1/(1+exp(-50*x));
    % Управление, как функция p2
    u   = sgn_a(p2)*stp_a(abs_a(p2)-1);
    % 
    dq  = [w; u; u*u; 0; p1; 0];
end

% Краевые условия
function res = bcfun(qa,qb)
    res = [qa(1); qa(2); qa(3); qb(1)-pi; qb(2); qb(6)+1];
end