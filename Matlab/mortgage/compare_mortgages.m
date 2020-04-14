function compare_mortgages(firstMortgage, secondMortgage, descrFirst, descrSecond, today)
% COMPARE_MORTGAGES compares two different mortgages showing how their
% loans evolves in the years

fig = figure;

showTodayLine = firstMortgage.Date(1) < today && firstMortgage.Date(end) > today;

% plot first graph: repaid debt
subplot(4, 1, 1);
hold on
title('Repaid debt');
ylabel('Pound (£)');
plot(firstMortgage.Date, firstMortgage.DebtRepaid, 'b');
plot(secondMortgage.Date, secondMortgage.DebtRepaid, 'r');
xline(firstMortgage.Date(end), '--k');
xline(secondMortgage.Date(end), '--k');
if showTodayLine
    xline(today, '--k');
end

% plot second graph: remaining debt
subplot(4, 1, 2);
hold on
title('Remaining debt');
ylabel('Pound (£)');
plot(firstMortgage.Date, firstMortgage.DebtRemaining, 'b');
plot(secondMortgage.Date, secondMortgage.DebtRemaining, 'r');
xline(firstMortgage.Date(end), '--k');
xline(secondMortgage.Date(end), '--k');
if showTodayLine
    xline(today, '--k');
end

% plot third graph: amount of debt paid at each payment
subplot(4, 1, 3);
hold on
title('Debt paid each payment');
ylabel('Pound (£)');
plot(firstMortgage.Date, firstMortgage.UsefulPaid, 'b');
plot(secondMortgage.Date, secondMortgage.UsefulPaid, 'r');
xline(firstMortgage.Date(end), '--k');
xline(secondMortgage.Date(end), '--k');
if showTodayLine
    xline(today, '--k');
end

% plot forth graph: amount of interest paid at each payment
subplot(4, 1, 4);
hold on
title('Interest paid each payment');
ylabel('Pound (£)');
plot(firstMortgage.Date, firstMortgage.InterestPaid, 'b');
plot(secondMortgage.Date, secondMortgage.InterestPaid, 'r');
xline(firstMortgage.Date(end), '--k');
xline(secondMortgage.Date(end), '--k');
if showTodayLine
    xline(today, '--k');
end
legend(descrFirst, descrSecond);
hold off

fig.Name = 'Compare two mortgages';

end
