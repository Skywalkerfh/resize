clear
clc
fid=fopen('err_pic.txt', 'w');
picAddress = 'I:\baitong\new_pic\img';
picAll = dir(picAddress);
for i = 3:size(picAll, 1)
    try
        picRaw = imread([picAddress '\' picAll(i,1).name]);
        picGray = cell(1);
        [lenX,lenY,z] = size(picRaw);
        maxL = max(lenX, lenY);
        lenDiff = abs(lenX-lenY);
        if mod(lenDiff,2) == 0
            supF = lenDiff/2; supS = lenDiff/2;
        else
            supF = (lenDiff+1)/2; supS = (lenDiff-1)/2;
        end
        backImage = uint8(255*ones(maxL,maxL,3));
        if lenX < lenY
            backImage(supF:end-supS-1,:,:) = picRaw;
        elseif lenX > lenY
            backImage(:,supF:end-supS-1,:) = picRaw;
        elseif lenX == lenY
            backImage = picRaw;
        end
        picNew{1,1} = backImage;
        imwrite(picNew{1,1},['I:\baitong\new_pic\result' '\' picAll(i,1).name])
    catch
        fprintf(fid,'%s\r\n',picAll(i,1).name);
        continue
    end
end
fclose(fid);