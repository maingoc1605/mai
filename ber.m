clear all;
clc;
Nsc = 128% 
M1 = 4;
M2= 64;
M3 = 16;
Nsmb = 1024;
Ne=3000% number of bits in error
ht = modem.qammod(M1);
hr = modem.qamdemod(M1);
ht1 = modem.qammod(M2);
hr1 = modem.qamdemod(M2);
ht2 = modem.qammod(M3);
hr2 = modem.qamdemod(M3);

c= 0;
for snr = 0:1:25
    c= c+1;
    nEr= 0;% dem so bit loi
    nSmb = 0; % so symbol ofdm simulated
    while ((nEr<Ne)&&(nSmb<Nsmb))
        Dg=randi([0 M1-1],1,Nsc);
        Dmod=modulate(ht,Dg);
        dAM_mod=ifft(Dmod,Nsc);
        dAM_mod_noisy=awgn(dAM_mod,snr,'measured');
        amdemod=fft(dAM_mod_noisy,Nsc);
         y=demodulate(hr,amdemod);
         [n, r]=biterr(Dg,y);
         nEr=nEr+r;
    nSmb=nSmb+1;
    end
    berRslt(c)=nEr/(log2(M1)*nSmb);
end

c1=0
for snr = 0:1:25
    c1= c1+1;
    nEr= 0;% dem so bit loi
    nSmb = 0; % so symbol ofdm simulated
    while ((nEr<Ne)&&(nSmb<Nsmb))
        Dg=randi([0 M2-1],1,Nsc);
        Dmod=modulate(ht1,Dg);
        dAM_mod=ifft(Dmod,Nsc);
        dAM_mod_noisy=awgn(dAM_mod,snr,'measured');
        amdemod=fft(dAM_mod_noisy,Nsc);
         y=demodulate(hr1,amdemod);
         [n, r]=biterr(Dg,y);
         nEr=nEr+r;
         nSmb=nSmb+1;
    end
    berRslt1(c1)=nEr/(log2(M2)*nSmb);
end

c2=0;
for snr = 0:1:25
    c2= c2+1;
    nEr= 0;% dem so bit loi
    nSmb = 0; % so symbol ofdm simulated
    while ((nEr<Ne)&&(nSmb<Nsmb))
        Dg=randi([0 M3-1],1,Nsc);
        Dmod=modulate(ht2,Dg);
        dAM_mod=ifft(Dmod,Nsc);
        dAM_mod_noisy=awgn(dAM_mod,snr,'measured');
        amdemod=fft(dAM_mod_noisy,Nsc);
         y=demodulate(hr2,amdemod);
         [n, r]=biterr(Dg,y);
         nEr=nEr+r;
    nSmb=nSmb+1;
    end
    berRslt2(c2)=nEr/(log2(M3)*nSmb);
end
snr=0:1:25
semilogy(snr,berRslt,'-OK','linewidth',2,'markerfacecolor','k','markersize',8,'markeredgecolor','k');
grid on ;
hold on 
semilogy(snr,berRslt2,'--','linewidth',2,'markerfacecolor','k','markersize',8,'markeredgecolor','k');
hold on 
semilogy(snr,berRslt1,'-.','linewidth',2,'markerfacecolor','k','markersize',8,'markeredgecolor','k');
title('OFDM Bit Error Rate vs SNR');
ylabel('Bit Error Rate');
xlabel('SNR [dB]');
legend (' 4-QAM', '16-QAM','64-QAM')

    
        
    


