clear
clc
a=[1 2 1 0 0;1 1 0 1 0; 1 -1 0 0 1];
b = [10 ;6 ;2];
A =[a b];
cost =[2 1 0 0 0 0];
Var={'x1' ,'x2' , 's1' ,'s2' ,'s3','sol'};
BV =[3 4 5];
A
bm=cost(BV);
bm
zjcj= (bm*A)- cost;


Run=true;

sol=A(:,end)
%ratio=zeros(1,size(A,1))
%ratio=ratio'
simplextable=[A;zjcj];
array2table(simplextable,'VariableNames',Var)
while Run
    if any (zjcj(1:end-1)< 0)
        [enterval, pivotcol] = min(zjcj(1:end-1));
        if all (A(:,pivotcol)<=0)
            error('unbounded lpp')
        
        else
            col= A(:,pivotcol);
            for i = 1:size(A,1)
                if(col(i)>=0)
                    ratio(i) = sol(i,:)/col(i,:);
                else
                    ratio(i) = inf
                end
            end
            
            [leavevalue ,pivotrow]=min(ratio);
            pivotrow
            pivotcol
            BV(pivotrow) = pivotcol;
            BV
            pvt_key = A(pivotrow,pivotcol)
            A(pivotrow,:) = A(pivotrow,:)/pvt_key
            for i =1:size(A,1)
                if i~=pivotrow
                    A(i,:)= A(i,:)-A(i,pivotcol)*A(pivotrow,:);
                end
            end
            zjcj = cost(BV)*A-cost
            next_table = [A;zjcj]
            array2table(next_table,'VariableNames',Var)
        end
    else
        Run=false;
        fprintf('optimal value is %f\n',zjcj(end))
    end
end