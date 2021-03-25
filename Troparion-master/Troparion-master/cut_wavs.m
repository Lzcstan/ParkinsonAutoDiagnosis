function cut_wavs(file_dir,output_dir,t,t_overlap)
        %�������ĸ���ԴĿ¼�����Ŀ¼����ȡʱ�������ص�ʱ��
        %����һ�²��ص�ʱ����1��55��������ļ������ý�ȡʱ��30s�����ص�ʱ��Ϊ30s����ֻ������һ
        %�Σ�0-30s�����ò��ص���15������2�Σ�0-30s��15-30s���Դ����ƣ�
files=dir(file_dir);
for i =3:length(files)          % ����һ�£���3��ʼ����Ϊǰ�����Ǹ�Ŀ¼".."�͵�ǰĿ¼"."
    if ~exist(output_dir)       % �жϱ���Ŀ¼�Ƿ����
        mkdir(output_dir);      % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end 
    if files(i).isdir           % �жϵ�ǰ�ļ������õ��Ƿ����ļ���
        temp_dir=file_dir;      % �ǣ���ʼ�ݹ飬��������
        now_dir=strcat(temp_dir,'/',files(i).name);
        now_output_dir=strcat(output_dir,'/',files(i).name);
        cut_wavs(now_dir,now_output_dir,t,t_overlap);
        clear temp_dir;
    elseif files(i).name(end-2:end)=='wav' % �����ļ��У��ж��Ƿ���wav�ļ�
        wavfile_name_new = strcat(file_dir,'/', files(i).name);    
        [y,fs]=audioread(wavfile_name_new);% ��ȡ������ֵ�������fs�ǲ�����     
        last_time=length(y)/fs;            % ���ֳ���ʱ�䳤��
        num=fix((last_time-t)/t_overlap+1);% �и�����ֵķ���
        for k=1:num                        % ��ÿ�����ֽ����и����    
            starttime=(k-1)*t_overlap;
            endtime=(k-1)*t_overlap+t;
            y_out=y(starttime*fs+1:endtime*fs+1,:);
            % �������һ�£��ҵ�wav�ļ���˫����������������nx2�Ľṹ��������ǵ�����
            % ��ôӦ����nx1����Ҫ�Ѻ����",:"ȥ��     
            filename=strcat(output_dir,'/',num2str(i-2),'-',num2str(k),'.wav');
            attentions=strcat('Saving...',filename) 
            audiowrite(filename,y_out,fs);
        end     
    end
    end
end

