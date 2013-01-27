function [ IntensityMatrix, SpaceMatrix ] = creatSearchSpace( init_ctr1, init_ctr2, img )

% Given two initial contours, returns an intensity matrix.

% Read in a png file into a Matlab matrix
im = imread (img);
% Convert the image to have values in the range 0 - 1
im = double (im);
imax = max ( max (im(:,:,1)));
imin = min ( min (im(:,:,1)));
im = (im - imin )/( imax - imin);
% Display the image
figure (1)
imagesc (im)
colormap ( gray )
axis square

init1 = load(init_ctr1);
hold on % this ensures Matlab plots the contour on the same figure
plot (init1(: ,1) ,init1(: ,2), 'r+-','LineWidth' ,2)
init2 = load(init_ctr2);
hold on % this ensures Matlab plots the contour on the same figure
plot (init2(: ,1) ,init2(: ,2), 'r+-','LineWidth' ,2)

% The number of points each green line contains
M = 80;
% The number of points each contour contains
N = length(init1);

IntensityMatrix = [];
SpaceMatrix = {};

for n = 1: N
    for m = 1: M
        y = round(init2(n,1)+ m/M*(init1(n,1)- init2(n,1)));
        x = round(init2(n,2)+ m/M*(init1(n,2)- init2(n,2)));
        TotalIntensity = zeros(3);
        for xx=-1:1
            for yy=-1:1
                TotalIntensity(x+xx+2,y+yy+2) = im(x+xx,y+yy);
            end
        end
        MinIntensity = max(max(TotalIntensity));
        IntensityMatrix(m,n) = 1 - MinIntensity;
        SpaceMatrix{m,n} = [x,y];
        plot( y,x,'g.');
    end 
end

end


