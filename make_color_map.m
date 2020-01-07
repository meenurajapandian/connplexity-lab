function mycmap = make_color_map(color, range)
mycmap = zeros(range+1, 3);
r = (255 - color(1))/range;
g = (255 - color(2))/range;
b = (255 - color(3))/range;
if color(1) < 255
    mycmap(:,1) = 255:-r:color(1);
else
    mycmap(:,1) = 255;
end
if color(2) < 255
    mycmap(:,2) = 255:-g:color(2);
else
    mycmap(:,2) = 255;
end
if color(3) < 255
    mycmap(:,3) = 255:-b:color(3);
else
    mycmap(:,3) = 255;
end
mycmap = mycmap ./ 255;