clc
a=[-1,3;1,1;1,-1]
b=[10;6;2]
c=[2,3]
x1=0:1:max(b)

x12=(b(1)-a(1,1)*x1)/a(1,2)
x22=(b(2)-a(2,1)*x1)/a(2,2)
x32=(b(3)-a(3,1)*x1)/a(3,2)

x12=max(0,x12)
x22=max(0,x22)
x32=max(0,x32)

cx1=find(x1==0)
c1=find(x12==0)
c2=find(x22==0)
c3=find(x32==0)

line_1=[x1(:,[cx1,c1]);x12(:,[cx1,c1])]
line_2=[x1(:,[cx1,c2]);x22(:,[cx1,c2])]
line_3=[x1(:,[cx1,c3]);x32(:,[cx1,c3])]

line_1=line_1'
line_2=line_2'
line_3=line_3'

store=[]
for i=1:size(a,1)
    a1=a(i,:)
    b1=b(i)

    for j=1+i:size(a,1)
        a2=a(j,:)
        b2=b(j)
        a4=[a1;a2]
        b4=[b1;b2]
        x=a4\b4
        store=[store x]
    end
end

store=store'
points=[line_1;line_2;line_3;store]

const1 = []
const2 = []
const3 = []
for i=1:size(points,1)
    const1=[const1 (a(1,1)*points(i,1)+a(1,2)*points(i,2)-b(1))]
    const2=[const2 (a(2,1)*points(i,1)+a(2,2)*points(i,2)-b(2))]
    const3=[const3 (a(3,1)*points(i,1)+a(3,2)*points(i,2)-b(3))]
    
end
fprintf('size of const2 %f ',size(const1,2))
s1=find(const1>0)
s2=find(const2>0)
s3=find(const3>0)
s=[s1,s2,s3]
points(s,:)=[]
points

[z index]=max(points*c')
X1=points(index,1)
X2=points(index,2)

plot(x1,x12)
hold on
plot(x1,x22)
hold on
plot(x1,x32)
hold on
grid on