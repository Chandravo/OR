A=[1,2,-1;1,1,-3;2,3,1]
b=[4,5,6]'
s=eye(size(A,1))
% ineq=[1,-1,-1]
% for i=1:size(A,1)
%     s(i,i)=s(i,i)*ineq(i)
% end
ineq=[0,1,1]
ind = find(ineq>0)
s(ind,:)=-s(ind,:)
mat=[A s]