function plot_curve(CD,CD_PPCA,SEP,SEP_PPCA,SNR_range,Missing_range)

figure('Name','CD')

for i=1:length(SNR_range)
    subplot(1,length(SNR_range),i)
    name =strcat('SNR:=',string(SNR_range(i)),'dB');
    plot(Missing_range*100,CD(i,:),'LineWidth',3.5,'Marker',"*")
    hold on
    plot(Missing_range*100,CD_PPCA(i,:),'LineWidth',3.5,'Marker',"diamond")
    grid on
    
    xlabel(" Missing Rate",'FontName','Times New Roman','Fontsize',16)
    ylabel("Chordal Distance ",'FontName','Times New Roman','Fontsize',16)
    kk=legend('SISHY','PPCA');
    set(kk,'FontName','Times New Roman','Fontsize',14);
    title(name)
end

figure('Name','SEP')

for i=1:length(SNR_range)
    subplot(1,length(SNR_range),i)
    name =strcat('SNR:=',string(SNR_range(i)),'dB');
    plot(Missing_range*100,SEP(i,:),'LineWidth',3.5,'Marker',"*")
    hold on
    plot(Missing_range*100,SEP_PPCA(i,:),'LineWidth',3.5,'Marker',"diamond")
    grid on
    
    xlabel(" Missing Rate",'FontName','Times New Roman','Fontsize',16)
    ylabel("SEP ",'FontName','Times New Roman','Fontsize',16)
    kk=legend('SISHY','PPCA');
    set(kk,'FontName','Times New Roman','Fontsize',14);
    title(name)
end
