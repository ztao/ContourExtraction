function [contour1, contour2] = createInitialContours()

contour1 = zeros(60,2)
contour2 = zeros(60,2)
for x = 1:60

	%contour1(x,:) = [110+2*x,80]
	%contour2(x,:) = [110+2*x,170]
	% Initial Contours for another image
	contour1(x,:) = [20+6*x,340-x]
	contour2(x,:) = [20+6*x,140-x]


end

end