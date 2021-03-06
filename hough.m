function [h,EdgeIm] =  hough ( im , Thresh , nrho , ntheta )
% HOUGH
%
% Function takes a grey scale image , constructs an edge map by applying
% the Canny detector , and then constructs a Hough transform for finding
% lines in the image .
%
% Usage : h = hough (im , Thresh , nrho , ntheta )
%
% arguments :
% im - The grey scale image to be transformed
% Thresh - A 2 -vector giving the upper and lower
% hysteresis threshold values for edge ()
% nrho - Number of quantised levels of rho to use
% ntheta - Number of quantised levels of theta to use
%
% returns ;
% h - The Hough transform
% EdgeIm - edge map created by canny edge detector

% Make the edge map of the image
EdgeIm = edge( im, 'canny', Thresh );

% Initialize an accumulator matrix
accu = zeros( nrho, ntheta );

% Calculate rhomax using the maximum values of the image im and Pythagoras'
% theorem
rows = size( im, 1 );
cols = size( im, 2 );
rhomax = sqrt ( rows ^2 + cols ^2);     % The maximum possible value of rho.
drho = 2* rhomax /( nrho -1);           % The increment in rho between successive
                                        % entries in the accumulator matrix .
                                        % Remember we go between + - rhomax .
dtheta = pi / ntheta ;                  % The increment in theta between entries .
thetas = [0: dtheta :( pi - dtheta )];  % Array of theta values across the
                                        % accumulator matrix .
                                        
% Assign all edge point coordinates
[y,x] = find(EdgeIm);
XY = [x,y];

% Calculate all rho values and start the voting in the accumulator at the
% indices of rho and theta
for i = 1:size(XY,1)
    for j = 1:size(thetas,2)
        rho = XY(i,1)*sin(thetas(j)) - XY(i,2)*cos(thetas(j));
        rhoindex = round ( rho / drho + nrho /2);
        thetaindex = round ( thetas(j) / dtheta + 1);
        accu(rhoindex,thetaindex) = accu(rhoindex,thetaindex)+1;
    end
end
% Assign the accumulator as the Hought Transform and show it
h = accu;                                      
imshow(h,[]);













