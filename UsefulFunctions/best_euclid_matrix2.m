function score_out=best_euclid_matrix2(scores_in,n,mean_scores)

% calculates the best n euclid distance from a matrix of mx3 scores


% normalise scores
 scores3=scores_in./mean_scores;

 % selecte best n points
e_dist=sqrt(scores3(:,1).^2+scores3(:,2).^2);
idx=sort(e_dist);

for j=1:n
    h=idx(j);
    h2=find(h==e_dist);
    h2=h2(1);
    score_out(j,:)=scores_in(h2,:);
end

end