function C=coordinator(Io,Ihaze)
Ihaze=double(Ihaze);
Image=double(Io);

x_min = 0.15;
I1=rgb2hsv(Image);
I2=rgb2hsv(Ihaze);

a = sum(sum(I1(:,:,3)));
c = sum(sum(I2(:,:,3)));

b = sum(sum(I1(:,:,2)));
d = sum(sum(I2(:,:,2)));

e = sum(sum(((I1(:,:,3)-I1(:,:,2))>x_min).*(I1(:,:,3)-I1(:,:,2))));%a-b
f = sum(sum(((I2(:,:,3)-I2(:,:,2))>x_min).*(I2(:,:,3)-I2(:,:,2))));%c-d

y = e/f;

x = (a - y*(c-d))/b ;
if x<1
    z=1;
else
    z=x;
end

I1(:,:,2) = I1(:,:,2) * z;
C=hsv2rgb(I1);

end
