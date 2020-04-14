function savedMoney = actual_saving(mortgageNoOverpayments, mortgageOverpayments, today)
% ACTUAL_SAVING returns the amount of saved interests thanks to the
% overpayments since the start until today

if mortgageNoOverpayments.Date(1) < today && mortgageNoOverpayments.Date(end) > today
    indexes = mortgageNoOverpayments.Date < today;
    fullInterests = sum(mortgageNoOverpayments.InterestPaid(indexes));
    lowerInterests = sum(mortgageOverpayments.InterestPaid(indexes));
    
    savedMoney = fullInterests - lowerInterests;
else
    savedMoney = 0.0;
end

end
