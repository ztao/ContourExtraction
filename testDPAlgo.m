% Test the dynamic programming 
% Test different initial contours or images by changing uncomment the corresponding line.

% Initial contours 1
init_ctr1 = 'init1.ctr';
init_ctr2 = 'init2.ctr';
% Initial contours 2
init_ctr1a = 'init1a.ctr';
init_ctr2a = 'init2a.ctr';
% Initial contours 3
init_ctr1b = 'init1b.ctr';
init_ctr2b = 'init2b.ctr';
% test image 1
img1 = 'tongue.png';
% test image 2
img2 = 'test.png';
% test image 1
img3 = 'test1.png';

tic

[ optimal_contour ] = findPathDP( init_ctr1, init_ctr2, img1 );
%%[ optimal_contour ] = findPathDP( init_ctr1a, init_ctr2a, img1 );
%%[ optimal_contour ] = findPathDP( init_ctr1b, init_ctr2b, img2 );
%%[ optimal_contour ] = findPathDP( init_ctr1b, init_ctr2b, img3 );

%{
figure(2);
imagesc(IntensityMatrix);
colormap(gray);
%}

toc