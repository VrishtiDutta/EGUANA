function move_vline2(handle) %subfunction
% This seems to lock the axes position
set(gcf,'Nextplot','Replace')
set(gcf,'DoubleBuffer','on')

h_ax=get(handle,'parent');
h_panel=get(h_ax,'parent');
h_fig=get(h_panel,'parent');

setappdata(h_fig,'h_vline2',handle)
set(handle,'ButtonDownFcn',@DownFcn)

  function DownFcn(hObject,eventdata,varargin) 
    set(gcf,'WindowButtonMotionFcn',@MoveFcn)           
    set(gcf,'WindowButtonUpFcn',@UpFcn)                 
  end 

  function UpFcn(hObject,eventdata,varargin) 
    set(gcf,'WindowButtonMotionFcn',[])
    edit1=getappdata(hObject,'edit1');%
    h2=getappdata(hObject,'h_vline2');
    h22=getappdata(hObject,'h_vline22');
    fr = get(h2,'XData');
    fr2 = get(h22,'XData');
    frt=sort([fr(1) fr2(1)]);
    set(edit1,'string',[num2str(frt(1)) ' ' num2str(frt(2))]);
  end 

  function MoveFcn(hObject,eventdata,varargin) 
    h2=getappdata(hObject,'h_vline2'); 
    h1=getappdata(hObject,'h_vline1');% 
    h5=getappdata(hObject,'h_vline5');% 
    h_ax=get(h2,'parent');                             
    cp = get(h_ax,'CurrentPoint');                          
    xpos = cp(1);      
    if(xpos<=6 && xpos>=0)
    XData = get(h2,'XData');                           
    XData(:)=xpos;                                          
    set(h2,'xdata',XData)
    set(h1,'xdata',XData)%
    set(h5,'xdata',XData)%
    end
    %update text                                            
%    text_obj = findobj('Type','Text','Tag','cbar_text');    
%    movex_text(text_obj,xpos)                               
  end 

end %move_vline(subfunction)