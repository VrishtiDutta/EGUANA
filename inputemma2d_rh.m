%**************************************************************************
%FUNCTION: inputemma
%Upgraded by: Michael Novati, University of Toronto
%Date Created: N/A
%Last Modified: August 8th, 2005
%**************************************************************************
%DESCRIPTION: 
%   Facilitates input from AG100 data file
%PARAMETERS:
%   move1 - filename for channels 1-5
%   number_ch - the number of channels to be examined
%   move2 - filename for channels 6-10
%   checkch - channel information
%   checkac - info regarding loading the sound file
%   finame - filename of the acoustic data
%   ratemo - rate of position data gathering
%   rate - rate of acoustic data recording
%   starttime - start time
%   stoptime - stop time
%   mav - info regarding loading of MAVIS along with data
%**************************************************************************
function [ac,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10]=inputemma2d_rh(move1,number_ch,move2,checkch,checkac,finame,rate,ratemo) %,starttime,stoptime,mav)
  
%LOAD ACOUSTIC DATA IF NECESSARY
if (checkac==1)
    fp1=fopen(finame,'r');
    if (fp1==-1)
        %reply=...
        questdlg('File not found. You might enter wrong file name.','ERROR','OK','OK');
        ac=0;
    else
        ac=fread(fp1,inf,'int16');
        fclose(fp1);
%         if (starttime~=0 && stoptime~=0)
%             endpoint=length(ac);
%             startpoint=fix(starttime*rate)-1;
%             stoppoint=fix(stoptime*rate)+1;
%             ac(stoppoint:endpoint)=[];
%             ac(1:startpoint)=[];
%         end
        [bb,aa]=butter(3,80/rate,'high');         
        ac=filtfilt(bb,aa,ac);
        ac=detrend(ac);
    end
else
    ac=0;
end
  
%FOR 5 CHANNEL DATA - i.e. only one data file
if (number_ch==5)
    [x1,x2,x3,x4,x5,y1,y2,y3,y4,y5]=readdatam_rh(move1);
    x6=0;x7=0;x8=0;x9=0;x10=0;y6=0;y7=0;y8=0;y9=0;y10=0;
    %adjust for start/stop times
%     if (starttime~=0)
%         endpoint=length(x1);
%         startpoint=fix(starttime*ratemo)-1;
%         stoppoint=fix(stoptime*ratemo)+1;
%         x1(stoppoint:endpoint)=[];x1(1:startpoint)=[];
%         x2(stoppoint:endpoint)=[];x2(1:startpoint)=[];
%         x3(stoppoint:endpoint)=[];x3(1:startpoint)=[];
%         x4(stoppoint:endpoint)=[];x4(1:startpoint)=[];
%         x5(stoppoint:endpoint)=[];x5(1:startpoint)=[];
%         y1(stoppoint:endpoint)=[];y1(1:startpoint)=[];
%         y2(stoppoint:endpoint)=[];y2(1:startpoint)=[];
%         y3(stoppoint:endpoint)=[];y3(1:startpoint)=[];
%         y4(stoppoint:endpoint)=[];y4(1:startpoint)=[];
%         y5(stoppoint:endpoint)=[];y5(1:startpoint)=[];
%     end
    %check if the user wants to change the names of articulator for each channel.
   % p1={'The current names of articulator for each channel are as follows:                            Channel 1--tongue tip  Channel 2--tongue body  Channel 3--upper lip              Channel 4--lower lip  Channel 5--jaw                                                       Enter 1 if you want to change the name of articulator for each channel. Otherwise, enter 0:'};
   % r1=inputdlg(p1,'The name of articulator for each channel',1);
    %default labels:
   % ch5_1='tongue tip';ch5_2='tongue body';ch5_3='upper lip';ch5_4='lower lip';ch5_5='jaw';

    %if ~isempty(r1)
    %    checkarticulator=eval(r1{1});
    %    if (checkarticulator==1)% Input the name of articulator for each channel by user.
    %        for i = 1:5
    %            p2{i} = strcat('Enter the name of articulator for channel ', num2str(i), ':');
    %        end
    %        r2=inputdlg(p2,'Change the name of articulator for each
    %        channel',1);
   %			if ~isempty(r2)
   %				ch5_1=r2{1};ch5_2=r2{2};ch5_3=r2{3};ch5_4=r2{4};ch5_5=r2{5};
   %			end
%		end
	%end

    if (checkac==1) % display acoustic data with movement data if there are acoustic data.
        mname={['ac/' finame],['x1&y1/' ch5_1],['x2&y2/' ch5_2],['x3&y3/' ch5_3],['x4&y4/' ch5_4],['x5&y5/' ch5_5]};
        msrate={rate,ratemo,ratemo,ratemo,ratemo,ratemo};
        msignal={ac,[x1 y1],[x2 y2],[x3 y3],[x4 y4],[x5 y5]};
    else % displace movement data only if there are no acoustic data.
        mname={['x1&y1/' ch5_1],['x2&y2/' ch5_2],['x3&y3/' ch5_3],['x4&y4/' ch5_4],['x5&y5/' ch5_5]};
        msrate={ratemo,ratemo,ratemo,ratemo,ratemo};
        msignal={[x1 y1],[x2 y2],[x3 y3],[x4 y4],[x5 y5]};
    end
end

%FOR 10 CHANNEL DATA - i.e. two data files
if (number_ch==10)
    %load data
    [x1,x2,x3,x4,x5,y1,y2,y3,y4,y5]=readdatam_rh(move1);
    [x6,x7,x8,x9,x10,y6,y7,y8,y9,y10]=readdatam_rh(move2);
    %adjust for start/stop time
%     if (starttime~=0) 
%         endpoint=length(x1);
%         startpoint=fix(starttime*ratemo)-1;
%         stoppoint=fix(stoptime*ratemo)+1;
%         x1(stoppoint:endpoint)=[];x1(1:startpoint)=[];
%         x2(stoppoint:endpoint)=[];x2(1:startpoint)=[];
%         x3(stoppoint:endpoint)=[];x3(1:startpoint)=[];
%         x4(stoppoint:endpoint)=[];x4(1:startpoint)=[];
%         x5(stoppoint:endpoint)=[];x5(1:startpoint)=[];
%         x6(stoppoint:endpoint)=[];x6(1:startpoint)=[];
%         x7(stoppoint:endpoint)=[];x7(1:startpoint)=[];
%         x8(stoppoint:endpoint)=[];x8(1:startpoint)=[];
%         x9(stoppoint:endpoint)=[];x9(1:startpoint)=[];
%         x10(stoppoint:endpoint)=[];x10(1:startpoint)=[];
%         y1(stoppoint:endpoint)=[];y1(1:startpoint)=[];
%         y2(stoppoint:endpoint)=[];y2(1:startpoint)=[];
%         y3(stoppoint:endpoint)=[];y3(1:startpoint)=[];
%         y4(stoppoint:endpoint)=[];y4(1:startpoint)=[];
%         y5(stoppoint:endpoint)=[];y5(1:startpoint)=[];
%         y6(stoppoint:endpoint)=[];y6(1:startpoint)=[];
%         y7(stoppoint:endpoint)=[];y7(1:startpoint)=[];
%         y8(stoppoint:endpoint)=[];y8(1:startpoint)=[];
%         y9(stoppoint:endpoint)=[];y9(1:startpoint)=[];
%         y10(stoppoint:endpoint)=[];y10(1:startpoint)=[];
%     end

    if (checkch==6) % If the user wants to display 6-channel-data, do following process.
        %p6={'The current names of articulator for each channel are as follows:                  Channel 1--tongue root  Channel 2--tongue body  Channel 3--tongue tip                       Channel 6--upper lip  Channel 7--lower lip  Channel 8--jaw                                            Enter 1 if you want to change the name of articulator for each channel. Otherwise, enter 0:'};
        %r6=inputdlg(p6,'The name of articulator for each channel',1);
        %if ~isempty(r6)
        %    checkar6=eval(r6{1});
        %    ch6_1='tongue root';ch6_2='tongue body';ch6_3='tongue tip';ch6_6='upper lip';ch6_7='lower lip';ch6_8='jaw';
        %		if (checkar6==1)% input the new names of articular for each channel by user.
        %            p6_2={'Enter the name of articulator for channel 1:',...
        %                  'Enter the name of articulator for channel 2:',...
        %                  'Enter the name of articulator for channel 3:',...
        %                  'Enter the name of articulator for channel 6:',...
        %                  'Enter the name of articulator for channel 7:',...
        %                  'Enter the name of articulator for channel 8:'};
        %            r6_2=inputdlg(p6_2,'Change the name of articulator for each channel',1);
        %            if ~isempty(r6_2)
        %                ch6_1=r6_2{1};ch6_2=r6_2{2};ch6_3=r6_2{3};ch6_6=r6_2{4};ch6_7=r6_2{5};ch6_8=r6_2{6};
        %            end
        %        end
        %    end
        
        if (checkac==1)% display the acoustic data with the movement data if there are acoustic data.
            mname={['ac/' finame],['x1&y1/' ch6_1],['x2&y2/' ch6_2],['x3&y3/' ch6_3],['x6&y6/' ch6_6],['x7&y7/' ch6_7],['x8&y8/' ch6_8]};
            msrate={rate,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo};
            msignal={ac,[x1 y1],[x2 y2],[x3 y3],[x6 y6],[x7 y7],[x8 y8]};
        else % display the movement data only if there are no acoustic data.
            mname={['x1&y1/' ch6_1],['x2&y2/' ch6_2],['x3&y3/' ch6_3],['x6&y6/' ch6_6],['x7&y7/' ch6_7],['x8&y8/' ch6_8]};
            msrate={ratemo,ratemo,ratemo,ratemo,ratemo,ratemo};
            msignal={[x1 y1],[x2 y2],[x3 y3],[x6 y6],[x7 y7],[x8 y8]};
        end
    end

    if (checkch==10)% If the user wants to display 10-channel-data, do following process.
        %p10={'The current names of articulator for each channel are as follows:                             Channel 1--tongue root  Channel 2--tongue body  Channel 3--tongue tip                                 Channel 4--nose   Channel 5--upper jaw  Channel 6--upper lip                                Channel 7--lower lip  Channel 8--jaw  Channel 9--calib 1  Channel 10--calib 2                                Enter 1 if you want to change the name of articulator for each channel. Otherwise, enter 0:'};
        %t10='The name of articulator for each channel';
        %r10=inputdlg(p10,t10,1);
        %if ~isempty(r10)
        %    checkar10=eval(r10{1});
            ch10_1='tongue root';ch10_2='tongue body';ch10_3='tongue tip';ch10_4='nose';ch10_5='upper jaw';
            ch10_6='upper lip';ch10_7='lower lip';ch10_8='jaw';ch10_9='calib 1';ch10_10='calib 2';
        %    if (checkar10==1)% input the new names of articulator for each channel by user.
        %        for i = 1:10
        %           p10_2{i} = strcat('Enter the name of articulator for channel ', num2str(i), ':');
        %        end
        %        r10_2=inputdlg(p10_2,'Change the name of articulator for each channel',1);
        %        if ~isempty(r10_2)
        %            ch10_1=r10_2{1};ch10_2=r10_2{2};ch10_3=r10_2{3};ch10_4=r10_2{4};ch10_5=r10_2{5};
        %            ch10_6=r10_2{6};ch10_7=r10_2{7};ch10_8=r10_2{8};ch10_9=r10_2{9};ch10_10=r10_2{10};
        %        end
        %    end
        %end
        if (checkac==1)% display the acoustic data with the movement data if there are acoustic data.
            mname={['ac/' finame],['x1&y1/' ch10_1],['x2&y2/' ch10_2],['x3&y3/' ch10_3],['x4&y4/' ch10_4],['x5&y5/' ch10_5],['x6&y6/' ch10_6],['x7&y7/' ch10_7],['x8&y8/' ch10_8],['x9&y9/' ch10_9],['x10&y10/' ch10_10]};
            msrate={rate,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo};
            msignal={ac,[x1 y1],[x2 y2],[x3 y3],[x4 y4],[x5 y5],[x6 y6],[x7 y7],[x8 y8],[x9 y9],[x10 y10]};
        else % display the movement data only if there are no acoustic data.
            mname={['x1&y1/' ch10_1],['x2&y2/' ch10_2],['x3&y3/' ch10_3],['x4&y4/' ch10_4],['x5&y5/' ch10_5],['x6&y6/' ch10_6],['x7&y7/' ch10_7],['x8&y8/' ch10_8],['x9&y9/' ch10_9],['x10&y10/' ch10_10]};
            msrate={ratemo,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo,ratemo};
            msignal={[x1 y1],[x2 y2],[x3 y3],[x4 y4],[x5 y5],[x6 y6],[x7 y7],[x8 y8],[x9 y9],[x10 y10]};
        end
    end 
end
mav=0;
if mav == 1
    dataSet=struct('NAME',mname,'SRATE',msrate,'SIGNAL',msignal);% the format of mavis' input is struct. also pay attention to the formats of mname,msrate and msignal above.
    mview(dataSet,'LPROC','lp_findgest')% call the function mview.
end