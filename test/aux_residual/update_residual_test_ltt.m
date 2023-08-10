function reply=update_residual_test_ltt(fitpar0,tofit)
reply = 0; % initializing the reply to not successful creation of residual script

head_code=fileread('~/isodistort2matlab/test/aux_residual/calulate_residual_test_ltt_head.m');

spacer = {' ';' ';'new';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';'new';' ';' ';' ';' ';'new';' ';' ';' ';' ';' ';' ';' ';'new';' ';' ';'new';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';'new';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';' ';'new';};
pars_code=[newline 'pars = ['];
ipar=1;
for idx=1:length(fitpar0)
    if tofit(idx)
        pars_code=[pars_code,sprintf('xx(%d)',ipar)];
        ipar=ipar+1;
    else
        pars_code=[pars_code,sprintf('%e',fitpar0(idx))];
    end
    if strcmp(spacer{idx},'new')
        pars_code=[pars_code,'...' newline];
    else
        pars_code=[pars_code,spacer{idx}];
    end
end
pars_code=[pars_code,'];' newline];

tail_code=fileread('~/isodistort2matlab/test/aux_residual/calulate_residual_test_ltt_tail.m');

full_code=[head_code,pars_code,tail_code];

% saving
full_name=['~/isodistort2matlab/test/calulate_residual_test_ltt.m'];


fid = fopen(full_name, 'w');
if fid < 0, error(['Cannot open file ',full_name]); end
fwrite(fid,full_code);
fclose(fid);

reply = 1;

end

