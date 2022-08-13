clear variables;
close all;
%% Launch TCP client


t = datetime('now')

if t.Minute > 15 || t.Minute <14
    msg = 'Minute is not between 14 and 15';
    disp(msg)
%    return
    quit
end

%% parameters

Number_Iteration=1000000;
%Data=zeros(Number_Iteration,4);

if isfile('Data_ESP_Mildiou.mat')
    
    load('Data_ESP_Mildiou.mat');
    
else
    
    Data = table('Size',[Number_Iteration 4],'VariableTypes',{'datetime','double','double','double',});
    Data.Var1.TimeZone='local'; %set timezone is needed later to combine datetime
    iteration = 0;
end



Connection=false;
Number_of_try=0;
Max_Number_Of_Try=10;
while Connection==false
    Number_of_try = Number_of_try + 1
    
    if Number_of_try>Max_Number_Of_Try
%         return;
          disp("Max number try reached; quitting matlab..");
          quit;
    end
    
    
    try
        tcp_client = tcpclient("192.168.1.24",80,"ConnectTimeout",10);
        Connection= true;
        break;
    catch error
        disp(error);
    end
end
pause(0.01);
iteration
tic
while   tcp_client.NumBytesAvailable>0
    
%    tic
    iteration=iteration+1;
    
    Line=tcp_client.readline();
    if  ~isempty(Line)
        
        SplitLine=split(Line,",");
        Double_Line=num2cell(str2double(SplitLine))';
        Data(iteration,2:4)=Double_Line;
        Wanted_DateTime =datetime(table2array(Data(iteration,2)), 'convertfrom', 'posixtime', 'Format', 'yyyy-MM-dd HH:mm:ss','TimeZone','local');
        Data(iteration,1)={Wanted_DateTime};
        
    end
%    pause(0.003);
%    T(iteration)= toc;
    
end
T=toc
iteration

f=figure;
tiledlayout(2,1);
ax1=nexttile;
plot(Data.Var1(1:iteration),Data.Var3(1:iteration),'-+b')
ylabel('Humidity')
xlabel('Time')
ylim([0 100])

ax2=nexttile;
plot(Data.Var1(1:iteration),Data.Var4(1:iteration),'-+r')
ylabel('Temperature')
xlabel('Time')
ylim([0 50])

savefig('F:\Documents\MATLAB\ESP_Mildiou\Figure_ESP_Mildiou.fig');
close(gcf);

save('Data_ESP_Mildiou.mat','Data','iteration','T');
toc
t = datetime('now')
disp("Data and figure saved and updated");

clear variables;