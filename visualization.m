f = figure;
colormap gray;
b = uicontrol('Parent',f,'Style','slider', 'SliderStep',[1/1069, 1/1069],...
    'Position',[90,0,419,23],'value',1, 'min',1, 'max',1069);
bgcolor = f.Color;
bl1 = uicontrol('Parent',f,'Style','text','Position',[60,0,23,23],...
                'String','1','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f,'Style','text','Position',[510,0,30,23],...
                'String','1069','BackgroundColor',bgcolor);
% bl3 = uicontrol('Parent',f,'Style','text','Position',[240,0,100,23],...
%                 'String','Image Index','BackgroundColor',bgcolor);
h = 1;          
b.Callback = @plotImageCallback;

function plotImageCallback(src, event)
    td = evalin('base', 'temporal_d');
    imgs = evalin('base', 'images');
    value = round(src.Value);
    subplot(1,2,1), image(imgs(:,:,value), 'CDataMapping', 'scaled');
%     subplot(1,2,2), image(imgs(:,:,value + 1), 'CDataMapping', 'scaled');
    subplot(1,2,2), image(td(:,:,value), 'CDataMapping', 'scaled');
end