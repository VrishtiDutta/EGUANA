function out=mmcxy_rh(arg)
global mmcxy_rh_out
if ~nargin
   Hf=figure(gcf);
   Ha=findobj(Hf,'Type','axes');
   if isempty(Ha), error('No Axes in Current Figure.'), end
   
   Hu=uicontrol(Hf,'Style', 'text',...
      'units','pixels',...
      'position',[1 1 100 15],...
      'HorizontalAlignment','left');
       set(Hf,'Pointer','crosshair',...
      'WindowButtonMotionFcn','mmcxy_rh(''move'')',...
       'Userdata',Hu)
   figure(Hf)
   if nargout
      key=waitforbuttonpress;
      if key,
         out=[];
         mmcxy_rh('end')
      else
         out=mmcxy_rh_out;
      end
      return
   end
elseif strcmp(arg,'move')
   xy = get(gca,'CurrentPoint');
   xy = xy(1,1:2);
   str = strcat(num2str(xy(1),'%.5g'), ' ,  ', num2str(xy(2)),'%.5g');
   Hu=get(gcf,'Userdata');
   set(Hu,'String',str);
elseif strcmp(arg,'end')
   Hu=get(gcf,'Userdata');
   delete(Hu)
   set(gcf,'Pointer','arrow',...
      'WindowButtonMotionFcn','',...
      'WindowButtonDownFcn','',...
      'Userdata',[]);
end

   
