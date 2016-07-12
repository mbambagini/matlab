% only on Windows
% required DAQmx

%% DAQ Data AcQuisition Toolbox
% IO = digitalio   ('nidaq', 'Dev3');
% ai = analoginput ('nidaq', 'Dev3');
% ai0 = addchannel(ai, 0);
% getsample(ai0);
% ao = analogoutput('nidaq', 'Dev3');
% ao1 = addchannel(a0, 1);
% putsample(ao1, 10.0);
% delete(ai0);
% delete(ao1);

%% how to find the device USB-6009
% daqhwinfo()
% daqhwinfo('nidaq')
% daq.getVendors()
% daq.getDevices()
