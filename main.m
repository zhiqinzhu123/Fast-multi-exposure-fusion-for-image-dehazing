clc
clear all

root = 'images\';
save_path = 'results\';
cur_time = datestr(now,30);
log_name = strcat('log_time_',cur_time,'.csv');
fileFolder=fullfile(root);
dirOutput=dir(fullfile(fileFolder,'*.jpg'));
fileNames={dirOutput.name};

clip_range = 0.010;

for i = 1:length(fileNames)
    fid1 = fopen(log_name, 'a');
    tic
    image_file_path = strcat(root, cell2mat(fileNames(i)));
    I_hazy = imread(image_file_path); 


    tic
    amef_im = atif_mef(im2double(I_hazy), clip_range);
    time = toc;


    [m, n, ~] = size(I_hazy);
    disp(['Resolution: ', num2str(m), ' x ', num2str(n)])
    disp(['Processing time: ', num2str(time)])

    raw_name = strsplit(cell2mat(fileNames(i)), '.');
    raw_name = raw_name(1);
    save_file_name = strcat('Proposed_', cell2mat(raw_name), '.tif');
    sace_file_name = strcat(save_path, '/', save_file_name);
    imwrite(amef_im,sace_file_name);
    fprintf(fid1, ['%s',',','%f','\n'], cell2mat(fileNames(i)), time);   
    fclose(fid1);
end