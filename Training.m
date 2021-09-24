

    for iijk = 1:50
        
    A = load(['Dataset\',num2str(iijk),'.mat']);
    
%     figure,
%     
%     plot(A.val(1:1000)/1000);
    
    A = A.val(1:1000);
    
%     ylim([0.9 1.3]);
%     
%     xlim([0 1000]);
%     
%     title('Noisy Input Signal','fontsize',11,'fontname',...
%         'Cambria','Color','black');
    
%     xlabel('Sample');
%     
%     ylabel('Amplitude')
%     
%     grid on;
    %     set(handles.text2,'string',['Mean Of Input Signal = ',num2str(mean(A(1:1000)))]);
    %
    %     set(handles.text3,'string',['Std. Deviation = ',num2str(std(A(1:1000)))]);
    
    
    
    % -- FIR -- %
    tic
    % y = A.val;
    y = A;
    y = y + 0.5 * rand(size(y));                  % Adding noise
    
    b = fir1(34,0.5,'low',chebwin(35,30));    % FIR filter design
    
    b1 = designfilt('lowpassfir','DesignMethod','equiripple','SampleRate',1e3, ...
        'PassbandFrequency',100,'StopbandFrequency',120, ...
        'PassbandRipple',0.5,'StopbandAttenuation',60);
    %     freqz(b,1,512);                 % Frequency response of filter
    
    output = filtfilt(b,1,y);       % Zero-phase digital filtering
    
%     figure(2),
%     
%     plot(output(1:1000)/1000,'r');
%     ylim([0.9 1.3]);
%     xlim([0 1000]);
    
    % grid on;
    
%     xlabel('Sample');
%     
%     ylabel('Amplitude')
%     
%     title('FIR Filtered Signal')
%     
%     grid on;
    %     set(handles.text4,'string',...
    %         ['Mean Of Filtered Signal = ',num2str(mean(output(1:1000)))]);
    %
    %     set(handles.text5,'string',...
    %         ['Std. Deviation = ',num2str(std(output(1:1000)))]);
    
%     TIME1 = toc;
    
%     msgbox(['Time Estimated for FIR is :: ',num2str(TIME1),' sec']);
    
%     tic
    % ----- NLMS ------ %
    
    % fima = NLmeansfilter(A.val,5,2,0.1);
%     fima = NLmeansfilter(A,5,2,0.1);
    
%     figure(3),
%     
%     plot(fima(1:1000)/1000,'k');
%     ylim([0.9 1.3]);
%     
%     % grid on;
%     
%     xlabel('Samples')
%     
%     ylabel('Amplitude');
%     
%     title('NLMS Filtered Signal','FontSize',12,...
%         'FontName','Times New Roman');
    
    %     set(handles.text6,'string',...
    %         ['Mean Of Filtered Signal = ',num2str(mean(fima(1:1000)))]);
    %
    %     set(handles.text7,'string',...
    %         ['Std. Deviation = ',num2str(std(fima(1:1000)))]);
%     grid on;
    
%     TIME2 = toc;
    
%     msgbox(['Time Estimated for NLMS is :: ',num2str(TIME2),' sec']);
    
    %  -- Feature
    
    output_fft = fft(output);
%     fima_fft = fft(fima);
    
%     figure,
%     td = uitable('data',output_fft);
    
    % -- Mean
    
    MN1 = mean(output);
%     MN2 = mean(fima);
    
    % -- STD
    
    St1 = std(output);
%     St2 = std(fima);
    
    Features = [output_fft MN1 St1];
    
    % -- Feature Selection -- %
    
    
    [optimop,optimop2]=PSO(Features,Features);

    Trainfea(iijk,:) = [optimop optimop2];
    
    end
    
    save Trainfea Trainfea