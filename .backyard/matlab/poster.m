mksqlite('open','H:\work\dryrun\long.sqlite')
str = mksqlite('SELECT time, data, COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS FROM data WHERE VAR= ''energy'' AND mote=18');
cell = struct2cell(str);
m18_good = cell2mat(cell);

%%
mksqlite('open','H:\work\dryrun\long_bad_rep.sqlite')
str = mksqlite('SELECT time, data, COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS FROM data WHERE VAR= ''energy'' AND mote=18');
cell = struct2cell(str);
m18_bad = cell2mat(cell);

mksqlite('open','H:\work\dryrun\long.sqlite')
str = mksqlite('SELECT time, data, COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS FROM data WHERE VAR= ''energy'' AND mote=3');
cell = struct2cell(str);
m3_good = cell2mat(cell);

%%
mksqlite('open','H:\work\dryrun\long_bad_rep.sqlite')
str = mksqlite('SELECT time, data, COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS FROM data WHERE VAR= ''energy'' AND mote=3');
cell = struct2cell(str);
m3_bad = cell2mat(cell);

%%
O = [];
m=m3_good;
for t = 1:7
    tmp = m(2, find(m(3,:) == t))';
    O(t,1:length(tmp)) = tmp;
end

O3_good = O';

%%
O = [];
m=m3_bad;
for t = 1:7
    tmp = m(2, find(m(3,:) == t))';
    O(t,1:length(tmp)) = tmp;
end

O3_bad = O';
%%
O = [];
m=m18_good;
for t = 1:7
    tmp = m(2, find(m(3,:) == t))';
    O(t,1:length(tmp)) = tmp;
end

O18_good = O';

%%
O = [];
m=m18_good;
for t = 1:7
    tmp = m(2, find(m(3,:) == t))';
    O(t,1:length(tmp)) = tmp;
end


O18_bad = O';

%%
figure('PaperSize',[80,80]);

plot(O3_good)
legend1 = legend('1', '2','3','4','5','6','7')
title('Node 18, tx:90%,rx90%')
set(legend1,...
    'Position',[0.0781770155645172 0.468556326978049 0.0626102292768959 0.386831275720165]);


figure('PaperSize',[80,80]);
plot(O3_bad)
legend1 = legend('1', '2','3','4','5','6','7')
title('Node 3, tx:95%,rx70%')
set(legend1,...
    'Position',[0.0781770155645172 0.468556326978049 0.0626102292768959 0.386831275720165]);

figure('PaperSize',[80,80]);
plot(O18_good)
legend1 = legend('1', '2','3','4','5','6','7')
title('Node 18, tx:90%,rx90%')
set(legend1,...
    'Position',[0.0781770155645172 0.468556326978049 0.0626102292768959 0.386831275720165]);

figure('PaperSize',[80,80]);
plot(O18_bad)
legend1 = legend('1', '2','3','4','5','6','7')
title('Node 18, tx:95%,rx70%')
set(legend1,...
    'Position',[0.0781770155645172 0.468556326978049 0.0626102292768959 0.386831275720165]);
