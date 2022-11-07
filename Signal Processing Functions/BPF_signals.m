function [ft,fr]=BPF_signals(transmitted,received)

%% loading in FIR filter
t_FIR=BPF_FIR;
Num_FIR=t_FIR.Numerator;
h_FIR=impz(Num_FIR);

%% filtering and normalising data
ft=(conv(transmitted,h_FIR));
fr=conv(received,h_FIR);

ft=ft./max(ft);
fr=fr./max(fr);

end