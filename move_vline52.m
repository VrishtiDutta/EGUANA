function move_vline52(handle) %subfunction
% This seems to lock the axes position
set(gcf,'Nextplot','Replace')
set(gcf,'DoubleBuffer','on')

h_ax=get(handle,'parent');
h_panel=get(h_ax,'parent');
h_fig=get(h_panel,'parent');

setappdata(h_fig,'h_vline52',handle)
set(handle,'ButtonDownFcn',@DownFcn)

  function DownFcn(hObject,eventdata,varargin) 
    set(gcf,'WindowButtonMotionFcn',@MoveFcn)           
    set(gcf,'WindowButtonUpFcn',@UpFcn)                 
  end 

  function UpFcn(hObject,eventdata,varargin) 
    set(gcf,'WindowButtonMotionFcn',[])
    edit1=getappdata(hObject,'edit1');%
    h5=getappdata(hObject,'h_vline5');
    h52=getappdata(hObject,'h_vline52');
    fr = get(h5,'XData');
    fr2 = get(h52,'XData');
    frt=sort([fr(1) fr2(1)]);
    set(edit1,'string',[num2str(frt(1)) ' ' num2str(frt(2))]);
  end 

  function MoveFcn(hObject,eventdata,varargin) 
    h52=getappdata(hObject,'h_vline52'); 
    h12=getappdata(hObject,'h_vline12');% 
    h22=getappdata(hObject,'h_vline22');% 
        h_ax=get(h12,'parent');                             
    cp = get(h_ax,'CurrentPoint');                          
    xpos = cp(1);   
    if(xpos<=6 && xpos>=0)
    XData = get(h12,'XData');                           
    XData(:)=xpos;                                          
    set(h52,'xdata',XData)
    set(h12,'xdata',XData)%
    set(h22,'xdata',XData)%
    end
    %update text                                            
%    text_obj = findobj('Type','Text','Tag','cbar_text');    
%    movex_text(text_obj,xpos)                               
  end 

end %move_vline(subfunction)