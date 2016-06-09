function [out1,out2] = myrinput(out1, out2)
%  MYRINPUT Graphical input from mouse.
%   [X,Y] = GINPUT gathers an unlimited number of points and also deletes the points which 
%   are not useful until the return key is pressed.
% 
b = [];
i=1;
color='g'; %color defalut is green 

fig = gcf;
figure(gcf);

% Remove figure button functions
state = uisuspend(fig);
pointer = get(gcf,'pointer');
set(gcf,'pointer','arrow');
fig_units = get(fig,'units');
char = 0;
set(gcf,'DoubleBuffer','on');  

while char ~= 13   
    % Use no-side effect WAITFORBUTTONPRESS
    waserr = 0;
    try
    keydown = wfbp;
    catch
    waserr = 1;
    end

    if(waserr == 1)
        if(ishandle(fig))
            set(fig,'units',fig_units);
            uirestore(state);
            error('Interrupted');
        else
            error('Interrupted by figure deletion');
        end
    end

    ptr_fig = get(0,'CurrentFigure');
    htype = get(gco,'Type');    
    tag = get(gco,'Tag');

    if(ptr_fig == fig)
                
        if keydown
            char = get(fig, 'CurrentCharacter');
            if char == 'c'
                dots = findobj(fig, 'Tag', 'Dot');
                delete(dots);
                out1 = [];
                out2 = [];
            end
            button = abs(get(fig, 'CurrentCharacter'));
            scrn_pt = get(0, 'PointerLocation');
            set(fig,'units','pixels')
            loc = get(fig, 'Position');
            pt = [scrn_pt(1) - loc(1), scrn_pt(2) - loc(2)];
            set(fig,'CurrentPoint',pt);
        else
            button = get(fig, 'SelectionType');
            if strcmp(button,'open')
                button = 1;
            elseif strcmp(button,'normal')
                button = 1;
            elseif strcmp(button,'extend')
                button = 2;
            elseif strcmp(button,'alt')
                button = 3;
            else
                error('Invalid mouse selection.')
            end
        end %end of keydown

        if button==1 & strcmp(htype,'line') & ~strcmp(tag,'Dot')   
            %This is sloppy, but it works.  The marker is a line named 'Dot'
            %Look up nearest value on line.
            %User-selected point
            cp = get(gca,'CurrentPoint');
            x = cp(1,1);       %first xy values
            y = cp(1,2);       %first xy values

            %Line data
            xl = get(gco,'XData');
            yl = get(gco,'YData');
            [xv,yv] = local_nearest(x,xl,y,yl);

            if(char == 13)
                % if the return key was pressed, char will == 13,
                % and that's our signal to break out of here whether
                % or not we have collected all the requested data
                % points.  
                % If this was an early breakout, don't include
                % the <Return> key info in the return arrays.
                % We will no longer count it if it's the last input.
                break;
            end

            ph = line(xv,yv, ...
            'Color', color, ...
            'Marker','o', ...
            'Tag','Dot', ...
            'UserData',[gco], ...
            'LineStyle','none');

            out1 = [out1;xv];  %add new point into the array
            out2 = [out2;yv];
    
        else if button==3 & strcmp(tag,'Dot')  % delete the point by click the right mouse button
            object=gco;
            x2 = get(gco,'XData'); %get the point
            y2 = get(gco,'YData');
            % color=get(gco, 'Color'); %get the point color
            delete(object); %delete the point from the figure

            c=size(out1, 1);
            [out1, out2]= delete_gco(x2, y2, out1, out2, c); %delete the point from the array
        end 
    end %end fig
end %end while  
end
uirestore(state);
set(fig,'units',fig_units);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function key = wfbp
%WFBP   Replacement for WAITFORBUTTONPRESS that has no side effects.

fig = gcf;
current_char = [];

% Now wait for that buttonpress, and check for error conditions
waserr = 0;
try
  h=findall(fig,'type','uimenu','accel','C');   % Disabling ^C for edit menu so the only ^C is for
  set(h,'accel','');                            % interrupting the function.
  keydown = waitforbuttonpress;
  current_char = double(get(fig,'CurrentCharacter')); % Capturing the character.
  if~isempty(current_char) & (keydown == 1)           % If the character was generated by the 
	  if(current_char == 3)                       % current keypress AND is ^C, set 'waserr'to 1
		  waserr = 1;                             % so that it errors out. 
	  end
  end
  
  set(h,'accel','C');                                 % Set back the accelerator for edit menu.
catch
  waserr = 1;
end
drawnow;
if(waserr == 1)
   set(h,'accel','C');                                % Set back the accelerator if it errored out.
   error('Interrupted');
end

if nargout>0, key = keydown; end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xv,yv]=local_nearest(x,xl,y,yl)
%Inputs:
% x   Selected x value
% xl  Line Data (x)
% y   Selected y value
% yl  Line Data (y)
%Find nearest value of [xl,yl] to (x,y)
%Special Case: Line has a single non-singleton value
time=1
if sum(isfinite(xl))==1
    fin = find(isfinite(xl));
    xv = xl(fin);
    yv = yl(fin);
else
    %Normalize axes
    xlmin = min(xl);
    xlmax = max(xl);
    ylmin = min(yl);
    ylmax = max(yl);
    
    xln = xl;
    xn = x;
    
    yln = yl;
    yn = y;
    %xln = (xl - xlmin)./(xlmax - xlmin);
    %xn = (x - xlmin)./(xlmax - xlmin);
    
    %yln = (yl - ylmin)./(ylmax - ylmin);
    %yn = (y - ylmin)./(ylmax - ylmin);
    
    %Find nearest point using our friend Ptyhagoras
    a = xln - xn;       %Distance between x and the line
    b = yln - yn;       %Distance between y and the line
    c = (a.^2 + b.^2);  %Distance between point and line
    %Don't need sqrt, since we get same answer anyway
    [junk,ind] = min(c);
    
    %Nearest value on the line
    xv = xl(ind);
    yv = yl(ind);
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [n_out1, n_out2]= delete_gco(x2, y2, out1, out2, c)

j=1;
n_out1=[]; n_out2=[];

while j<=c
   
%   if c==1 & x2==out1(j) & y2==out2(j) %delete first and only point in the array
	%	n_out1=[];
  %    n_out2=[];
   %   break;
   %end
   
  if j==c & x2==out1(j) & y2==out2(j) %delete last point in the array
      n_out1=[n_out1];
      n_out2=[n_out2];
      j=j+1;
      break;
  end

   if x2==out1(j) & y2==out2(j) %delete the points
         j=j+1;
   end
   
         n_out1=[n_out1; out1(j)];
      n_out2=[n_out2; out2(j)];
      j=j+1;
   end
   


         
         
         
