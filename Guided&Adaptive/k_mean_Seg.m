function [num,mask]=k_mean_Seg(src,k)

src=double(src);
img=src;       
src=src(:);     
mi=min(src);    
src=src-mi+1;   
L=length(src);
m=max(src)+1;

hist=zeros(1,m);
histc=zeros(1,m);
for i=1:L
  if(src(i)>0)
      hist(src(i))=hist(src(i))+1;
  end
end

ind=find(hist);
hl=length(ind);
num=(1:k)*m/(k+1);

while(true)
  prenum=num;
  for i=1:hl
      c=abs(ind(i)-num);
      cc=find(c==min(c));
      histc(ind(i))=cc(1);
  end
  for i=1:k
      a=find(histc==i);
      num(i)=sum(a.*hist(a))/sum(hist(a));
  end
  if(num==prenum)
      break;
  end 
end

L=size(img);
mask=zeros(L);

for i=1:L(1)
    for j=1:L(2)
        c=abs(img(i,j)-num);
        a=find(c==min(c)); 
        mask(i,j)=a(1);
    end

end
num=num+mi-1;   