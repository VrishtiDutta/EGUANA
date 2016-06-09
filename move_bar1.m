function move_bar1(handle) %subfunction
% This seems to lock the axes position
set(gcf,'Nextplot','Replace')
set(gcf,'DoubleBuffer','on')

%h_ax=get(handle,'parent');
%h_fig=get(h_ax,'parent');
%setappdata(h_fig,'h_vline1',handle)
setappdata(gcf,'bar1',handle)
set(handle,'ButtonDownFcn',@DownFcn)

  function DownFcn(hObject,eventdata,varargin) 
    set(gcf,'WindowButtonMotionFcn',@MoveFcn)           
    set(gcf,'WindowButtonUpFcn',@UpFcn)                 
  end 

  function UpFcn(hObject,eventdata,varargin) 
    set(gcf,'WindowButtonMotionFcn',[])
    edit1=getappdata(hObject,'edit1');
    bar1=getappdata(hObject,'bar1');
    bar2=getappdata(hObject,'bar2');
    points=getappdata(hObject,'points');
    reg=getappdata(hObject,'reg');
    fr = get(bar1,'XData');
    fr2 = get(bar2,'XData');
    frt=sort([fr(1) fr2(1)]);
    set(edit1,'string',[num2str(frt(1)) ' ' num2str(frt(2))]);
    logx=get(points,'XData');
    logy=get(points,'Ydata');   
    ind=find( logx>frt(1) & logx<frt(2));

    x=logx(ind);
    y=logy(ind);
    p=polyfit(x,y,1);
    yr=polyval(p,x);
    set(reg,'Xdata',x,'Ydata',yr)
  end

  function MoveFcn(hObject,eventdata,varargin) 
    bar1=getappdata(hObject,'bar1'); 
    h_ax=get(bar1,'parent');                             
    cp = get(h_ax,'CurrentPoint');
    xpos = cp(1);
    XData = get(bar1,'XData');
    XData(:)=xpos;                                          
    set(bar1,'xdata',XData)                          
  end 

end %move_bar1(subfunction)