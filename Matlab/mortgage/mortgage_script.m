%% mortgage data

% initial borrowed money
loan = 50000;
% mortgage fix rate
fixRate = 2.69;
% mortgage fix monthly payment
fixMonthlyPayment = 500.10;
firstPaymentDate = '01-01-2020';
% overpayment dates. Dates are in the format 'dd-MM-yyyy'
overpaymentDates = {'30-1-2020', '28-2-2020'};
% overpayment amounts
overpaymentAmounts = [4000.0, 2000.0];
% today datetime
today = datetime(now, 'ConvertFrom', 'datenum');

%% compute mortgage status

[savedMoney, savedPayments, fullDataWithout, fullDataWith] = ...
    compute_mortgage_status(loan, fixRate, fixMonthlyPayment, ...
               firstPaymentDate, overpaymentDates, overpaymentAmounts);
           
%% display money/time saved by overpayments

fprintf("With overpayments:\n")
fprintf("- saved money in interests until the end: £%.2f\n", savedMoney);
actSavedMoney = actual_saving(fullDataWithout, fullDataWith, today);
fprintf("- saved money in interests until now: £%.2f\n", actSavedMoney);
fprintf("- saved time: %d years and %d months\n", ...
                          floor(savedPayments/12), mod(savedPayments, 12));

%% plot mortgage status without and with overpayments

compare_mortgages(fullDataWithout, fullDataWith, ...
    'Without overpayments', 'With overpaymnets', today);

%% clean up workspace

clear loan fix_rate fix_monthly_payment first_payment_date
clear overpayments_date overpayments_amount
clear savedMoney savedPayments fullDataWithout fullDataWith
