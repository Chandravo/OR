clc
a = [2 3 -1 4;1 -1 6 -7]
b= [8;3]
c = [2 3 4 7]%Objective matrix
m =size(a,1) %no. of contraints
n = size(a,2)%no. of variable
if n>m
    ncm=nchoosek (n,m) % binomial
    p = nchoosek (1:n,m)%all combination of choosing m number
    sol = []
    for i =1:ncm
       y = zeros(n,1) %creating zeros matrix 1 column n rows
       a1 = a(:,p(i,:))% matrix from a only 2x2 matrix
       x = a1\b % matrix division
       if all (x>=0 & x~=inf)
            y(p(i,:),:) = x % storing x
            sol = [sol y]
       end
    end
else
    error('no. of constraint greater than number of variable')
end
c*sol
[obj index ] =max(c*sol) % finding optimal solution
x8 =sol(index,1) %storing x1
x9 =sol(index,2)
x10=sol(index,3)
x11=sol(index,4)
BFS = sol(:,index)  % storing optimal solution matrix in BFS
optval =[BFS' ,obj] 
fprintf('max value is %f at (%f %f %f %f)',obj,x8,x9,x10,x11)
array2table(optval,'VariableNames',{'x1','x2','x3','x4','z'})
