
clear all;
close all;

% quelques soucis en utilisant timetable car quand il y a des NaN, il passe
% tout en cell array et le plot echoue. Je tente donc en récupérant les
% données en simple matrice.

%data = thingSpeakRead(2164382,'Fields',[1,2,3,4],NumPoints=8000,OutputFormat='TimeTable',ReadKey='S70X6KZIY8TM6TMR');
%data = thingSpeakRead(2164382,'Fields',[1,2,3,4],NumDays=1,OutputFormat='TimeTable',ReadKey='S70X6KZIY8TM6TMR');

[data,timestamps,channelInfo] = thingSpeakRead(2164382,'Fields',[1,2,3,4],NumPoints=8000,ReadKey='S70X6KZIY8TM6TMR');

f=figure;
tiledlayout(2,2);
ax1=nexttile;
h1=plot(timestamps,data(:,1),'-+b');
ylabel('Temperature')
xlabel('Time')
ylim([0 70])


ax2=nexttile;
h2=plot(timestamps,data(:,2),'-+r');
ylabel('Humidity')
xlabel('Time')
ylim([0 100])


ax3=nexttile;
h1=plot(timestamps,data(:,3),'-+c');
ylabel('Analog read')
xlabel('Time')
ylim([1800 2425])


ax4=nexttile;
h2=plot(timestamps,data(:,4),'-+g');
ylabel('Battery Level')
xlabel('Time')
ylim([0 100])