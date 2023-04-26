
cost=[-2 0 -1 0 0 0];
a=[-1 -1 1 1 0 ; -1 2 -4 0 1];
b=[-5;-8];
A=[a b];
BV= [4,5];
zjcj= cost(BV)*A-cost;
simplextable=[zjcj;A];
Var={'x1' ,'x2' , 'x3' ,'s1' ,'s2','sol'};
array2table(simplextable,'VariableNames',Var)
run = true;
while run
        sol=A(:,end)
        if any(sol<0)
            fprintf('current solution is not feasible')
            [leavingvalue, pivotrow]= min(sol);
            for i=1:size(A,2)-1
                if A(pivotrow,i)<0
                    ratio(i)=abs(zjcj(i)/A(pivotrow,i));
                else
                    ratio(i)=inf;
                end
            end
            [entryvalue, pivotcol]=min(ratio);
            BV(pivotrow)=pivotcol;
            pivotkey=A(pivotrow,pivotcol);
            A(pivotrow,:) = A(pivotrow,:)./pivotkey;
            for i =1:size(A,1)
                if i~=pivotrow
                    A(i,:)= A(i,:)-A(i,pivotcol).*A(pivotrow,:);
                end
            end
            bm=cost(BV);
            zjcj= bm*A-cost;
            next_table=[zjcj;A];
            array2table(next_table,'VariableNames',Var)
        else
        run=false;
        fprintf('optimal value is %f \n',zjcj(end))
        end

end