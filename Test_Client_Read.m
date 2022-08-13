clear all;
close all;

Succeed=0;
Failed=0;

t = tcpclient("192.168.1.24",80,"Timeout",10)

pause(2);
Number_Iteration=10;

Line=t.readline();
SplitLine=split(Line,",");

Data=zeros(Number_Iteration, length(SplitLine));

f=figure;
tiledlayout(2,1);
ax1=nexttile;
h1=plot(NaN,NaN,'-+b');
ylabel('Humidity')
xlabel('Time')
ylim([0 100])
ax2=nexttile;
h2=plot(NaN,NaN,'-+r');
ylabel('Temperature')
xlabel('Time')
ylim([0 50])

%set(p1,'Visible','off')

tic
for i = 1:Number_Iteration
    
   
    Line=t.readline();
    if  ~isempty(Line)
        SplitLine=split(Line,",");
        Data(i,:)=str2double(SplitLine)';
    
        h1.XData=Data(1:i,1);
        h1.YData=Data(1:i,2);
        
        h2.XData=Data(1:i,1);
        h2.YData=Data(1:i,3);
        drawnow;  
    end
    
    
pause(1);
%save('Discharging_Battery_Volmeter','Data');


end

clear t;

toc



