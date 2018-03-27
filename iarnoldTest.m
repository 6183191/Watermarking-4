function [ iminverse ] = iarnold(newim,num)
[irown,icoln]=size(newim);
iminverse = zeros(irown);
for inc=1:num
for irow=1:irown
    for icol=1:icoln
        
        inrowp = irow;
        incolp=icol;
        for ite=1:inc
            inewcord =[2 -1;-1 1]*[inrowp incolp]';
            inrowp=inewcord(1);
            incolp=inewcord(2);
        end
        iminverse(irow,icol)=newim((mod(inrowp,irown)+1),(mod(incolp,icoln)+1));
        
    end
end

end
