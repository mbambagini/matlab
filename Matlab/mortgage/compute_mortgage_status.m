function [savedMoney, savedPayments, fullDataWithout, fullDataWith] = ...
    compute_mortgage_status(borrowedMoney, fixRate, fixMonthlyPayment, ...
    firstPaymentDate, overpaymentsDate, overpaymentsAmount)
% COMPUTE_MORTGAGE_STATUS computes all the mortgage payments with and
% without overpayments

% convert overpayments dates into DateTime format and sort them from the
% oldest to the newest
overpayment_datetime = datetime(overpaymentsDate, 'InputFormat', 'dd-MM-yyyy');
[overpayment_datetime, indexes] = sort(overpayment_datetime);
overpaymentsAmount = overpaymentsAmount(indexes);
% convert first_payment_date in DateTime format
firstPaymentDate = datetime(firstPaymentDate, 'InputFormat', 'dd-MM-yyyy');
% compute montly interest rate
interestFactor = (fixRate/100)/12;

% compute mortgage evolution without overpayments
fullDataWithout = compute_payments(firstPaymentDate, ...
    borrowedMoney, fixMonthlyPayment, interestFactor, {}, []);
% compute mortgage evolution with overpayments
if ~isempty(overpaymentsDate)
    fullDataWith = compute_payments(firstPaymentDate, ...
        borrowedMoney, fixMonthlyPayment, interestFactor, ...
        overpayment_datetime, overpaymentsAmount);
    savedMoney = fullDataWithout.TotalInterests - fullDataWith.TotalInterests;
    savedPayments = fullDataWithout.NumPayments - fullDataWith.NumPayments;
else
    fullDataWith = [];
    savedMoney = 0;
    savedPayments = 0;
end
end

function res = compute_payments(firstPaymentDate, amount, fixMonthlyPayment, ...
                  interestFactor, overpaymentDates, overpaymentAmount)
    % this method computes all the mortgage payments
    
    interest = [];
    paid = [];
    remaining = [];
    totalPaid = [];
    paymentDays = firstPaymentDate; % this is just a placeholder to let
                                    % us append a new date with end+1
    loanMoney = amount;
    day = firstPaymentDate;
    
    while amount > 0.0
        % until there is loan to pay...
        paymentDays(end+1) = day;
        % check if overpayments are done since the last payment
        if ~isempty(overpaymentDates)
            toConsider = overpaymentDates < day;
            if any(toConsider)
                overpaymentDates(toConsider) = [];
                overpayments = overpaymentAmount(toConsider);
                overpaymentAmount(toConsider) = [];
                amount = amount - sum(overpayments);
            end
        end
        % compute interests for this payment
        interest(end+1) = amount * interestFactor;
        % compute part of the loan repaid with this payment
        net = fixMonthlyPayment - interest(end);
        if net > amount
            to_pay = amount;
        else
            to_pay = net;
        end
        paid(end+1) = to_pay;
        % update remaining loan
        amount = amount - paid(end);
        remaining(end+1) = amount;
        % update total paid load
        totalPaid(end+1) = loanMoney - amount;
        % next payment date
        day.Month = day.Month + 1;
    end
    % remove fictiuos first payment date
    paymentDays(1) = [];
    
    res = struct('Date', paymentDays, ...
                 'UsefulPaid', paid, ...
                 'InterestPaid', interest, ...
                 'DebtRepaid', totalPaid, ...
                 'DebtRemaining', remaining, ...
                 'NumPayments', length(paymentDays), ...
                 'TotalInterests', sum(interest));
end
