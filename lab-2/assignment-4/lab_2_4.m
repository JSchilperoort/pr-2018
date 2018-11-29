n = 1000000;
scores = zeros(1, n);

for i = 1:n  % players
    score = 0;
    for j = 1:100 % turns
        r = rand;
        if r > 0.5 % tails
            score = score + 1;
        end
    end
    scores(i) = score;
end

val = unique(scores);
cnt = histc(scores, val);

plot(val, cnt);