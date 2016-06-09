% This function is sorting the points in the array and find the peak and valley points 

function [peakindex, peak, valleyindex, valley]=sort_pt(fig_pt)

peakindex=[]; valleyindex=[]; peak=[]; valley=[];
i=1;
c=size(fig_pt, 1);
% sorting the points in the arrray
while i<c
    if fig_pt(i+1)<fig_pt(i)
       temp=fig_pt(i,:);
        fig_pt(i,:)=fig_pt(i+1,:);
        fig_pt(i+1,:)=temp;
        n=1;
        m=i;
        while n~=m & n<m
            if fig_pt(m)<fig_pt(n)
                temp=fig_pt(n, :);
                fig_pt(n, :)=fig_pt(m,:);
                fig_pt(m, :)=temp;
               
            end
            n=n+1;
        end
            
        
    end
    i=i+1;
end

fig_pt;
i=1;

% find the peak and valley points
if fig_pt(i,2)>fig_pt(i+1,2) % compare the first and second points to decide the first point is peak 
    while i<c
        peakindex=[peakindex; fig_pt(i)];
        peak=[peak; fig_pt(i,2)];
        valleyindex=[valleyindex; fig_pt(i+1)];
        valley=[valley; fig_pt(i+1,2)];
        i=i+2;
        if i==c
           peakindex = [peakindex;fig_pt(i)];
           peak=[peak; fig_pt(i,2)];
           valleyindex = [valleyindex];
           valley=[valley];
        end
        
    end
 
i=1;
elseif fig_pt(i,2)<fig_pt(i+1,2)% compare the first and second points to decide the first point is valley
        while i<c
            valleyindex=[valleyindex; fig_pt(i)];
            valley=[valley; fig_pt(i,2)];
            peakindex=[peakindex; fig_pt(i+1)];
            peak=[peak; fig_pt(i+1,2)];
            i=i+2;
        if i==c
           peakindex = [peakindex];
           peak=[peak];
           valleyindex = [valleyindex; fig_pt(i)];
           valley=[valley; fig_pt(i,2)];
        end

        end
end
    


    
    
