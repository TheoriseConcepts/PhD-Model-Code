%% fillstairs
% - Method which draws two stair-functions and fills the area between them
% - Created by Florian Krause on 2016-01-25 (V1.0)
% - Use it as you like.
function fillstairs(X, Y1, Y2, h)
% Create "Stairs-Function"
Xi = [X(sort([1:length(X), 2:length(X)])), X(end)+(X(end)-X(end-1))];
Y1i = [Y1(sort([1:length(X), 1:length(X)]))];
Y2i = [Y2(sort([1:length(X), 1:length(X)]))];
% Plot Stairs
figure(h)
%plot(Xi, Y1i, 'r-');
hold on;
%plot(Xi, Y2i, 'k-');
% Fill Stairs
for i = 1:2:length(Xi)
    if ( Y1i(i) > Y2i(i) )      % Upper
        xx = [Xi(i:i+1), fliplr(Xi(i:i+1))]; 
        yy = [Y1i(i:i+1), fliplr(Y2i(i:i+1))]; 
        fill(xx, yy,[128 193 219]./255,'FaceAlpha',0.5,'edgecolor', 'none'); 
    elseif ( Y2i(i) > Y1i(i) )  % Lower
        xx = [Xi(i:i+1), fliplr(Xi(i:i+1))]; 
        yy = [Y1i(i:i+1), fliplr(Y2i(i:i+1))]; 
        fill(xx, yy,[128 193 219]./255,'FaceAlpha',0.5,'edgecolor', 'none');        
    else                        % Identical
        % do nothing
    end
end
% Draw Lines Again
hold on;
%plot(Xi, Y1i, 'r-');
hold on;
%plot(Xi, Y2i, 'k-');
end