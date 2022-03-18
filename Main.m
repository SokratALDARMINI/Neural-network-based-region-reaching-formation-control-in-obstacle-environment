%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program is done to simulate the example that is shown in the work: 
%    [J. Yu, J. Ji, Z. Miao, and J. Zhou, “Neural network-based region reaching formation
%    control for multi-robot systems in obstacle environment,” Neurocomputing, vol. 333,pp.
%    11–21, 2019, doi: 10.1016/j.neucom.2018.12.051.]
% We recommend to check this article for a better theortical background.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=4; % number of agents 
m=3; % mass of the agent
beta=3; % friction coefficient
%intial values of agents positions
x1_0=1;
y1_0=9;
x2_0=1;
y2_0=3;
x3_0=1;
y3_0=-3;
x4_0=1;
y4_0=-9;
%intial values of agents' speed
x1_dot_0=0;
y1_dot_0=0;
x2_dot_0=0;
y2_dot_0=0;
x3_dot_0=0;
y3_dot_0=0;
x4_dot_0=0;
y4_dot_0=0;
%Desired postions (assosiated with the desired formation)
h1_x=5;
h1_y=5;
h2_x=-5;
h2_y=5;
h3_x=-5;
h3_y=-5;
h4_x=5;
h4_y=-5;
%avoidance region
r=2;
R=5;
%Obstacles position
N_obs=1;
obs_x=40;
obs_y=0;
%Desired region for the formation
region_x=80;
region_y=0;
R_reg=15;
%Connections between agents
G1 = [1 2 3 4];
G2 = [2 3 4 1];
G = graph(G1,G2);
figure(1);
plot(G)
L=full(laplacian(G));
% parameters for simulation and controller (check the article for more information about this pr)
alpha_0=1;
beta_0=1;
delta_0=1;
row_0=0;
kp=20;
kapa=3;
ki=diag([150,150]);
gamma=0.1;
% Parameters for the RBF neural networks.
number_of_neurons=8;
b=10;
Gamma=3;
WL_0=rand(number_of_neurons,1)*2;
WR_0=rand(number_of_neurons,1)*2;
c1=rand(8,8)-0.5;
c1(1:2:8,:)=c1(1:2:8,:)*2;
c1(2:2:8,:)=c1(2:2:8,:)*18;
c2=rand(8,8)-0.5;
c2(1:2:8,:)=c2(1:2:8,:)*2;
c2(2:2:8,:)=c2(2:2:8,:)*18;
c3=rand(8,8)-0.5;
c3(1:2:8,:)=c3(1:2:8,:)*2;
c3(2:2:8,:)=c3(2:2:8,:)*18;
c4=rand(8,8)-0.5;
c4(1:2:8,:)=c4(1:2:8,:)*2;
c4(2:2:8,:)=c4(2:2:8,:)*18;
c=rand(8*number_of_neurons*N,1)-0.5;
c(1:2:8*number_of_neurons*N)=c(1:2:8*number_of_neurons*N)*2;
c(2:2:8*number_of_neurons*N)=c(2:2:8*number_of_neurons*N)*18;
%% Plot of  agents' trajectories 
t=out.xy1(:,1);
xy1=out.xy1(:,2:1:3);
xy2=out.xy2(:,2:1:3);
xy3=out.xy3(:,2:1:3);
xy4=out.xy4(:,2:1:3);
len=size(xy1,1);

figure(2);
hold off;
scatter(xy1(1,1),xy1(1,2),100,'b');
hold on;
scatter(xy2(1,1),xy2(1,2),100,'r');
scatter(xy3(1,1),xy3(1,2),100,'g');
scatter(xy4(1,1),xy4(1,2),100,'y');

plot(xy1(:,1),xy1(:,2),'b','LineWidth',2);
plot(xy2(:,1),xy2(:,2),'r','LineWidth',2);
plot(xy3(:,1),xy3(:,2),'g','LineWidth',2);
plot(xy4(:,1),xy4(:,2),'y','LineWidth',2);

scatter(xy1(len,1),xy1(len,2),100,'filled','b');
scatter(xy2(len,1),xy2(len,2),100,'filled','r');
scatter(xy3(len,1),xy3(len,2),100,'filled','g');
scatter(xy4(len,1),xy4(len,2),100,'filled','y');

plot([xy1(len,1),xy2(len,1),xy3(len,1),xy4(len,1),xy1(len,1)],[xy1(len,2),xy2(len,2),xy3(len,2),xy4(len,2),xy1(len,2)],'LineWidth',2);
max_t=max(t);
T=max_t/10;
for i=1:1:9
index=length(t(t<(T*i)));
t(index)
plot([xy1(index,1),xy2(index,1),xy3(index,1),xy4(index,1),xy1(index,1)],[xy1(index,2),xy2(index,2),xy3(index,2),xy4(index,2),xy1(index,2)],':m','LineWidth',1);
end

tita=0:0.1:2*pi+0.1;
plot(r*sin(tita)+obs_x,r*cos(tita)+obs_y,'k','LineWidth',2);
plot(R*sin(tita)+obs_x,R*cos(tita)+obs_y,'k:','LineWidth',2);
plot(R_reg*sin(tita)+region_x,R_reg*cos(tita)+region_y,'k','LineWidth',2);
xlabel('$$q_{i1}$$ or(x)', 'Interpreter', 'LaTeX','FontSize',20);
ylabel('$$q_{i2}$$ or(y)', 'Interpreter', 'LaTeX','FontSize',20);
title('Agents trajectories','FontSize',20);
w={'Obstacle','Desired Region'};
text([40 80], [7 10], w, 'HorizontalAlignment','center', 'VerticalAlignment','middle','FontSize',14)
w={'First agent','Second agent','Third agent','Forth agent'};
text([-5 -5 -5 -5], [9 3 -3 -9], w, 'HorizontalAlignment','center', 'VerticalAlignment','middle','FontSize',14)
set(gca,'FontSize',20);
%% Agents' coordinates as functions of time.
figure();
plot(t,xy1(:,1),t,xy2(:,1),t,xy3(:,1),t,xy4(:,1),'LineWidth',2);
grid on;
leg=legend('$$q_{11}(t)$$','$$q_{21}(t)$$','$$q_{31}(t)$$','$$q_{41}(t)$$', 'Interpreter', 'LaTeX','FontSize',20);
xlabel('Time [sec]', 'Interpreter', 'LaTeX','FontSize',20);
ylabel('$$q_{i1}$$', 'Interpreter', 'LaTeX','FontSize',20);
title('Agent position on x axis','FontSize',20);
set(gca,'FontSize',20);
figure();
plot(t,xy1(:,2),t,xy2(:,2),t,xy3(:,2),t,xy4(:,2),'LineWidth',2);
grid on;
leg=legend('$$q_{12}(t)$$','$$q_{22}(t)$$','$$q_{32}(t)$$','$$q_{42}(t)$$', 'Interpreter', 'LaTeX','FontSize',20);
xlabel('Time [sec]', 'Interpreter', 'LaTeX','FontSize',20);
ylabel('$$q_{i2}$$', 'Interpreter', 'LaTeX','FontSize',20);
title('Agent position on y axis','FontSize',20);
set(gca,'FontSize',20);
%% Agents' speeds as functions of time.
t=out.xy1_dot(:,1);
xy1_dot=out.xy1_dot(:,2:1:3);
xy2_dot=out.xy2_dot(:,2:1:3);
xy3_dot=out.xy3_dot(:,2:1:3);
xy4_dot=out.xy4_dot(:,2:1:3);

figure();
plot(t,xy1_dot(:,1),t,xy2_dot(:,1),t,xy3_dot(:,1),t,xy4_dot(:,1),'LineWidth',1);
grid on;
leg=legend('$$\dot q_{11}(t)$$','$$\dot q_{21}(t)$$','$$\dot q_{31}(t)$$','$$\dot q_{41}(t)$$', 'Interpreter', 'LaTeX','FontSize',20);
xlabel('Time [sec]', 'Interpreter', 'LaTeX','FontSize',20);
ylabel('$$\dot q_{i2}$$', 'Interpreter', 'LaTeX','FontSize',20);
title('Agent speed on x axis','FontSize',20);
set(gca,'FontSize',20);

figure();
plot(t,xy1_dot(:,2),t,xy2_dot(:,2),t,xy3_dot(:,2),t,xy4_dot(:,2),'LineWidth',1);
grid on;
leg=legend('$$\dot q_{12}(t)$$','$$\dot q_{22}(t)$$','$$\dot q_{32}(t)$$','$$\dot q_{42}(t)$$', 'Interpreter', 'LaTeX','FontSize',20);
xlabel('Time [sec]', 'Interpreter', 'LaTeX','FontSize',20);
ylabel('$$\dot q_{i2}$$', 'Interpreter', 'LaTeX','FontSize',20);
title('Agent speed on y axis','FontSize',20);
set(gca,'FontSize',20);
