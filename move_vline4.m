function move_vline4(handle) %subfunction
% This seems to lock the axes position
set(gcf,'Nextplot','Replace')
set(gcf,'DoubleBuffer','on')

h_ax=get(handle,'parent');
h_panel=get(h_ax,'parent');
h_fig=get(h_panel,'parent');

setappdata(h_fig,'h_vline4',handle)
set(handle,'ButtonDownFcn',@DownFcn)

  function DownFcn(hObject,eventdata,varargin) 
    set(gcf,'WindowButtonMotionFcn',@MoveFcn)           
    set(gcf,'WindowButtonUpFcn',@UpFcn)                 
  end 

  function UpFcn(hObject,eventdata,varargin) 
    set(gcf,'WindowButtonMotionFcn',[]) 
    edit2=getappdata(hObject,'edit2');%
    h4=getappdata(hObject,'h_vline4');
    h42=getappdata(hObject,'h_vline42');
    fr = get(h4,'XData');
    fr2 = get(h42,'XData');
    frt=sort([fr(1) fr2(1)]);
    set(edit2,'string',[num2str(frt(1)) ' ' num2str(frt(2))]);
  end 

  function MoveFcn(hObject,eventdata,varargin) 
    h3=getappdata(hObject,'h_vline3');% 
    h4=getappdata(hObject,'h_vline4'); 
    h6=getappdata(hObject,'h_vline6');% 
    h_ax=get(h4,'parent');                             
    cp = get(h_ax,'CurrentPoint');                          
    xpos = cp(1); 
    if(xpos<=6 && xpos>=0)
    XData = get(h4,'XData');                           
    XData(:)=xpos;                                          
    set(h3,'xdata',XData)%
    set(h4,'xdata',XData)
    set(h6,'xdata',XData)%
    end
    %update text                                            
%    text_obj = findobj('Type','Text','Tag','cbar_text');    
%    movex_text(text_obj,xpos)                               
  end 

end %move_vline(subfunction)