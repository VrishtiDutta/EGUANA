% This program is for showing the stiffness figure windows

function [dur3, sumdur3, val00,val01,val02,val03,val04,val05,val06,val07,val08,val09,val010,val011,val012,val013,...
        val014,val015,val016,val017,val018,val019,val020,val021,val0211,val0212,val0213,val0214,val022,val023,...
        val024,val025,val000,val2000] = stiff9010_figure_rh (pos, signal, velocity,...
	ampl,velo1, dur, stiffness, cvalue, percent,ampl2, velo2 ,dur2, stiff2,... 
	cvalue2, percent2, val000, val2000,allind10_90,velocity10_90, lastsubject, trialnum, namevariable)
 
handle = figure('Position', pos,'name',['Kinematic 90-10% values ',...
    namevariable]);
 
clf;
whitebg(handle,'k'); 
subplot('position',[0.08 0.890 0.45 0.09])
%tlines=plot(timetemp,signal,'y');
plot(signal,'y');
hold on
%plot(peaktime,peak,'m^');
%plot(valleytime,valley,'cv')
line(allind10_90,signal(allind10_90),'LineStyle','none','Color','r','Marker','.')
hold off
ylabel('Position (mm)');

subplot('position',[0.08 0.77 0.45 0.09])
%plot(timetemp,velocity);
plot(velocity);
line(allind10_90,velocity10_90,'LineStyle','none','Color','r','Marker','.')
xlabel('Time (samples)');
ylabel('Velocity (mm/s)');

subplot('position', [0.08 0.585 0.45 0.10])
plot((1:length(ampl)),ampl,'yo-',(1:length(ampl2)),ampl2,'ms-');
val00=num2str(mean(ampl));
val01=num2str(std(ampl));
val02=num2str(mean(ampl2));
val03=num2str(std(ampl2));
ylabel('Amplitude (mm)');
title('circle: 1st movement   square: 2nd movement  pentagram: combination');

subplot('position',[0.08 0.44 0.45 0.10])
plot((1:length(velo1)),abs(velo1),'yo-',(1:length(velo2)),abs(velo2),'ms-');
ylabel('Velocity (mm/s)');
val04=num2str(mean(velo1));
val05=num2str(std(velo1));
val06=num2str(mean(velo2));
val07=num2str(std(velo2));

subplot('position',[0.08 0.31 0.45 0.1])
plot((1:length(dur)),dur,'yo-',(1:length(dur)),dur2,'ms-',(1:length(dur)),(dur+dur2),'cp-');
ylabel('Duration (s)')
dur3=dur+dur2;    
val08=num2str(mean(dur));
val09=num2str(std(dur));
val010=num2str(mean(dur2));
val011=num2str(std(dur2));
val012=num2str(mean(dur3));
val013=num2str(std(dur3));
sumdur3=zeros(1,length(dur3));
sumdur3(1)=dur3(1);
         for d3=2:length(dur3)
            sumdur3(d3)=sumdur3(d3-1)+dur3(d3);
         end
        
subplot('position',[0.08 0.18 0.45 0.10])
val014=num2str(mean(stiffness));
val015=num2str(std(stiffness));
val016=num2str(mean(stiff2));
val017=num2str(std(stiff2));
plot((1:length(stiffness)),stiffness,'o-',(1:length(stiff2)),stiff2,'ms-')
ylabel('Stiffness');
	
	
subplot('position',[0.08 0.05 0.45 0.10])
val018=num2str(mean(cvalue));
val019=num2str(std(cvalue));
val020=num2str(mean(cvalue2));
val021=num2str(std(cvalue2));
plot((1:length(cvalue)),cvalue,'o-',(1:length(cvalue2)),cvalue2,'ms-')
xlabel('Index');
ylabel('Constant');
         
         
subplot('position',[0.6 0.82 0.36 0.14])
plot((1:length(percent)),percent,'yo-',(1:length(percent2)),percent2,'ms-');
val0211=num2str(mean(percent));
val0212=num2str(std(percent));
val0213=num2str(mean(percent2));
val0214=num2str(std(percent2));
xlabel('Index');
ylabel('Speed percentage');
         
 subplot('position',[0.6 0.53 0.17 0.2])
 p1=polyfit(dur,stiffness,1);
 p2=polyfit(dur2,stiff2,1);
 duri1=linspace(min(dur),max(dur),100);
 stiffi1=polyval(p1,duri1);
 duri2=linspace(min(dur2),max(dur2),100);
 stiffi2=polyval(p2,duri2);
 plot(dur,stiffness,'yo',dur2,stiff2,'ms',duri1,stiffi1,'y-',duri2,stiffi2,'m-');
 xlabel('Duration')
 ylabel('Stiffness')
 val022=num2str(p1(1));
 val023=num2str(p2(1));
            
subplot('position',[0.81 0.53 0.17 0.2])
p3=polyfit(ampl,cvalue,1);
p4=polyfit(ampl2,cvalue2,1);
ampli1=linspace(min(ampl),max(ampl),100);
cvaluei1=polyval(p3,ampli1);
ampl2i2=linspace(min(ampl2),max(ampl2),100);
cvaluei2=polyval(p4,ampl2i2);
plot(ampl,cvalue,'yo',ampl2,cvalue2,'ms',ampli1,cvaluei1,'y-',ampl2i2,cvaluei2,'m-');
xlabel('Amplitude')
ylabel('Constant')
val024=num2str(p3(1));
val025=num2str(p4(1));
            
           
subplot('position',[0.6 0.01 0.36 0.44]);
text(0.5,1,'Mean');
text(0.75, 1,'Standard deviation');
text(0,0.95,'Amplitude(mm) 1st movement');
text(0.5,0.95,val00);
text(0.75,0.95,val01);
text(0,0.9,'Amplitude(mm) 2nd movement');
text(0.5,0.9,val02);
text(0.75,0.9,val03);
text(0,0.85,'Velocity(mm/s) 1st movement');
text(0.5,0.85,val04);
text(0.75,0.85,val05);
text(0,0.8,'Velocity(mm/s) 2nd movement');
text(0.5,0.8,val06);
text(0.75,0.8,val07);
text(0,0.75,'Duration(s) 1st movement');
text(0.5,0.75,val08);
text(0.75,0.75,val09);
text(0,0.7,'Duration(s) 2nd movement');
text(0.5,0.7,val010);
text(0.75,0.7,val011);
text(0,0.65,'Duration(s) Combination');
text(0.5,0.65,val012);
text(0.75,0.65,val013);
text(0,0.6,'Stiffness 1st movement');
text(0.5,0.6,val014);
text(0.75,0.6,val015);
text(0,0.55,'Stiffness 2nd movement');
text(0.5,0.55,val016);
text(0.75,0.55,val017);
text(0,0.5,'Constant 1st movement');
text(0.5,0.5,val018);
text(0.75,0.5,val019);
text(0,0.45,'Constant 2nd movement');
text(0.5,0.45,val020);
text(0.75,0.45,val021);
text(0,0.4,'Percentage 1st movement');
text(0.5,0.4, val0211);
text(0.75,0.4,val0212);
text(0,0.35,'Percentage 2nd movement');
text(0.5, 0.35,val0213);
text(0.75,0.35,val0214);
text(0.65,0.3,'Slope');
text(0,0.25,'Duration vs Stiffness  1st movement');
text(0.65,0.25,val022);
text(0,0.2,'Duration vs Stiffness  2nd movement');
text(0.65,0.2,val023);
text(0,0.15,'Amplitude vs Constant  1st movement');
text(0.65,0.15,val024);
text(0,0.1,'Amplitude vs Constant  2nd movement');
text(0.65,0.1,val025);
text(0,0.05,'RMS of Velocity: ');
text(0.35,0.05,val000);
text(0.55,0.05,'Number of cycles:');
text(0.92,0.05,val2000);
text(0,0,'subject:');
text(0.2,0,lastsubject);
text(0.4,0,'trial:');
text(0.5,0,trialnum);
text(0.7,0,'channel:');
text(0.9,0,namevariable);
axis off;