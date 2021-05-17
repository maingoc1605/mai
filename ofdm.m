N=256;
% Number of subcarriers or size of IFFT/FFT
N_data_symbol=1024;
% Number of symbol to IFFT
GI=16;
M=4;
N_Iteration=500;
% Number of iteration
SNR=[0:1:15];
% Signal to Noise Ratio in dB
for i=1:length(SNR)
snr=SNR(i);
for k=1:N_Iteration
 tx_bits=randi(N_data_symbol,1,M);
 % Input Bit Streams to Transmit
 % Modulation
 tx_bits_Mod=reshape(qammod(de2bi(tx_bits),M),[],1);
 input_symbol=[zeros((N-N_data_symbol)/2,1); tx_bits_Mod;zeros((N-N_data_symbol)/2,1)];
 %IFFT and Circular Prefix Addition
 ofdm_symbol_ifft=ifft(input_symbol,N);
 % Guard Interval insertion (CP)
 guard_symbol=ofdm_symbol_ifft(N-GI+1:N);
 % Add the cyclic prefix to the ofdm symbol
 ofdm_symbol=[guard_symbol; ofdm_symbol_ifft];
 %sig_pow=ofdm_symbol'.*conj(ofdm_symbol);
 ofdm_spectrum=ofdm_symbol;
 
 h=1; %AWGN
 y1=filter(h,1,ofdm_symbol);
 %y=x*h
 % Adding AWGN Noise
 y=awgn(y1,snr,'measured');
 %y=x*h+n
end
end
figure(1); 
index=1:272; 
plot( index,y,'g'); 
figure(2)
plot( index,y1,'r')



