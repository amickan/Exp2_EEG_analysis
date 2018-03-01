%% Loading all preprocessed data 

subjects = [301]; % subjects that should be included in grand average
cd('\\cnas.ru.nl\wrkgrp\STD-Back-Up-Exp2-EEG\'); % directory with all preprocessed files 
cfg = [];
cfg.keeptrials='yes';

for i = 1:length(subjects)
    % condition 1 for each participant
    filename1 = strcat('PreprocessedData\', num2str(subjects(i)), '_data_clean_cond1');
    dummy = load(filename1);
    Condition1{i} = ft_timelockanalysis(cfg, dummy.data_clean_cond1);
    % condition 2 for each participant
    filename2 = strcat('PreprocessedData\', num2str(subjects(i)), '_data_clean_cond2');
    dummy2 = load(filename2);
    Condition2{i} = ft_timelockanalysis(cfg, dummy2.data_clean_cond2);
end

% grand-average over subjects per condition 
cfg = [];
cfg.keeptrials='yes';
cond1 = ft_timelockgrandaverage(cfg, Condition1{:});
cond2 = ft_timelockgrandaverage(cfg, Condition2{:});

% plotting average
cfg = [];
cfg.demean = 'yes'; %baseline
cfg.baselinewindow = [-0.5 0]; %baseline
cfg.layout = 'actiCAP_64ch_Standard2.mat';
cfg.interactive = 'yes';
cfg.showoutline = 'yes';
cfg.showlabels = 'yes'; 
cfg.fontsize = 6; 
% cfg.ylim = [-3e-13 3e-13];
ft_multiplotER(cfg, cond1, cond2);