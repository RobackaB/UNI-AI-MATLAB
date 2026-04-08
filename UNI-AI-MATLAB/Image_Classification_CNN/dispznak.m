% Function to display character
% dataChar - data for character (column vector of size N)
% characters are in grid of size numRows x numCols, i.e. N=numRows*numCols neurons
% numRows is number of rows and numCols is number of columns of grid
% value 0 - white cell, 1 - black cell

function [fig]=dispznak(dataChar,numRows,numCols,percentages)

[N,M]=size(dataChar);
fig=figure;

if nargin<4
    percentages=ones(1,M);
end
percentValue=fix(10000*percentages)/100;
numbers=[2 7 5 4];
for p=1:M
    if M==1
        axis([0 numCols 0 numRows])
        hold on
    else
       %subplot(2,round(M/2),p)
       subplot(1,M,p)
        axis([0 numCols 0 numRows])
        hold on
        %title(['Number ' num2str(numbers(p)) ' - ' num2str(percentValue(p)) '%'])
        axis off
    end
        k=0;

    if N==(numCols*numRows)
       for row=numRows:-1:1
            for col=1:numCols
                k=k+1;
                c=[1-dataChar(k,p) 1-dataChar(k,p) 1-dataChar(k,p)];
                patch([col-1 col col col-1],[row row row-1 row-1],c)
            end
       end
    end
end
hold off
