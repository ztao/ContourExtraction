function [ optimal_contour ] = findPathDP( init_ctr1, init_ctr2, img )

% Creat Search space, acuire intensity matrix and its corresponding space
% matrix
[IntensityMatrix, SpaceMatrix] = creatSearchSpace(init_ctr1, init_ctr2, img);
% A matrix of MxN, M is the number of points in every green line, N is the
% length
[M,N] = size(IntensityMatrix);
% The regularisation parameter lambda
lbd = 0.5;
% Index is used to control the begin of the contour within the search space
index = 0;
%Creat position matrix and energy matrix
PositionMatrix(M,N) = 0;
EnergyMatrix(M,M) = 0;
% Initial Energy: all S(v1,v0) = 0
S(M) = 0;
n = 2;
% First case
for m2 = 1:M 
    for m1 = 1:M
        for m0 = 1:M
            v_dividend = (norm(SpaceMatrix{m2,n+1}-2*SpaceMatrix{m1,n}+SpaceMatrix{m0,n-1}))^2;
            v_divsor = (norm(SpaceMatrix{m2,n+1} - SpaceMatrix{m0,n-1}))^2;
            E = lbd*v_dividend/v_divsor + (1-lbd)*IntensityMatrix(m1,n);
            if S[m1] == 0 || EnergyMatrix(m2,m1) > S(m0) + E
               EnergyMatrix(m2,m1) = S(m1) + E;
            end
        end
        PositionMatrix(m1,n) = m0;
    end
[S(m2), PositionMatrix(m2,n+1)] = min(EnergyMatrix(m2,:));
end 
n = n+1;
% Rest of the interations
while n <= N-1
    for m2 = 1:M
        for m1 = 1:M
            % Assign the point in the previous line
            m0 = PositionMatrix(m1,n);
            % Energy formula
            v_dividend = (norm(SpaceMatrix{m2,n+1}-2*SpaceMatrix{m1,n}+SpaceMatrix{m0,n-1}))^2;
            v_divsor = (norm(SpaceMatrix{m2,n+1} - SpaceMatrix{m0,n-1}))^2;
            E = lbd*v_dividend/v_divsor + (1-lbd)*IntensityMatrix(m1,n);
            EnergyMatrix(m2,m1) = S(m1) + E;
        end
        [S(m2),PositionMatrix(m2,n+1)] = min(EnergyMatrix(m2,:));
    end
n = n+1;
end

optimal_contour(N,2) = 0;
[MinS,p] = min(S);
n = N;
begin = 1;
while n >= 1

    optimal_contour(n,:) = SpaceMatrix{p,n};
    % Find the previous point
    p = PositionMatrix(p,n);
    n = n-1;
end
% Plot the optimal contour
plot (optimal_contour(:,2) , optimal_contour(:,1), 'r+-','LineWidth', 2);

end

