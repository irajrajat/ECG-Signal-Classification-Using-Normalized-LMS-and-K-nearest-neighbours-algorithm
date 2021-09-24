function [optimop,optimop2]=PSO(inp1,inp2)
D=19; 
ps=19; 
populationm=ones(D,1)*-50;
populationn=ones(D,1)*50; 
varia=[populationm,populationn];
position=40*rand(ps,D)-20;
vactorop=8*rand(ps,D)-4; 
max_vec=200;
iw=1; 
iw1 = 0.9;   
iw2 = 0.4;
iwe = 19;
ac1=2;
ac2=2;
flagg=1; 
ergrd=1e-5;
fitg=5;
mv=4;
pbest=position;
% for i=1:ps
%     p=position(i,:);  
%     out(i)=pv_mi(p(1),p(2),p(3),inp1,inp2);
% end
pbestval=rand(1,19);      
[gbestval,idx]=max(pbestval);
gbest=pbest(idx,:);   
tr(1)=gbestval;  
cnt=0; 
cnt2=0; 
for i=1:max_vec
    for j=1:ps
        if flagg==1   
            randnum1=rand(1);
           randnum2=rand(1);
        end
        p=position(j,:);  
%        out(j)=pv_mi(p(1),p(2),p(3),inp1,inp2);
        out(j,:)=rand(1,19);
        e(j)=out(j);
        if pbestval(j)<=e(j)
            pbestval(j)=e(j);
            pbest(j,:)=position(j,:);
        end
        [iterbestval,idx1]=max(pbestval);
        if gbestval<=iterbestval
            gbestval=iterbestval;
            gbest=pbest(idx1,:);   
        end
        tr(i+1)=gbestval;
        te=i;
        if i<=iwe
            iwt(i)=((iw2-iw1)/(iwe-1))*(i-1)+iw1; 
        else
            iwt(i)=iw2;
        end
        if flagg==2    
        for dimcnt=1:D
            randnum1=rand(1);
            randnum2=rand(1);
            vactorop(j,dimcnt)=iwt(i)*vactorop(j,dimcnt)...
                    +ac1*randnum1*(pbest(j,dimcnt)-position(j,dimcnt))...
                    +ac2*randnum2*(gbest(1,dimcnt)-position(j,dimcnt));
        end
        else  
            vactorop(j,:)=iwt(i)*vactorop(j,:)...
                 +ac1*randnum1*(pbest(j,:)-position(j,:))...
                 +ac2*randnum2*(gbest(1,:)-position(j,:));
        end
        position(j,:)=position(j,:)+vactorop(j,:);
        for dimcnt=1:D
            if vactorop(j,dimcnt)>mv
                vactorop(j,dimcnt)=mv;
            end
            if vactorop(j,dimcnt)<-mv
                vactorop(j,dimcnt)=-mv;
            end    
            if position(j,dimcnt)>=varia(dimcnt,2)
                position(j,dimcnt)=varia(dimcnt,2);
            end
       
            if position(j,dimcnt)<=varia(dimcnt,1)
               position(j,dimcnt)=varia(dimcnt,1);
            end             
         end
    end  
    temp=gbest';
    fprintf('%f,%f,%f,%f\n',temp(1),temp(2),temp(3),gbestval);
    Y(i)=gbestval;
    X(i)=i;
    tmp1=abs(tr(i)-gbestval);
    if tmp1>ergrd
        cnt2=0;
    elseif tmp1<=ergrd
        cnt2=cnt2+1;
        if cnt2>=fitg
         break
        end
    end       
end 
optimop=gbest;
optimop2=gbestval;
% axes(handles.axes1)
% plot(X,Y);
% title('Output from PSO');
% xlabel('No of Generation');
% ylabel('Fitness Value');