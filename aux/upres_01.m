
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
