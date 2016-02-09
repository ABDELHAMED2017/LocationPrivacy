function response = gdb(lat, lon)

load 'databasecalc.mat';
load 'PU_loc.mat';
load 'coverage_area.mat';
load 'tdatabasecalc.mat';

act_resp_pow = pow(lat, lon);
act_resp_blank=blank(lat,lon);

% No obfuscation
%pert_resp = act_resp_pow;
%response.actual_chan=chan(lat,lon);
response.actual_pow = act_resp_pow;
response.actual_blank=act_resp_blank;
response.perturbed_pow = tpow(lat,lon);
response.perturbed_blank=tblank(lat,lon);

end