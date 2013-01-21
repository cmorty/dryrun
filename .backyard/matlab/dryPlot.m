%%
mksqlite('open','H:\work\dryrun\long.sqlite')
dat = mksqlite('SELECT mote, MAX(data), COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS FROM data WHERE VAR= ''energy'' GROUP BY mote,  COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS');
dat = struct2cell(dat);
m = cell2mat(dat);

%%
figure
for t = 0:19
    plot(m(3, (30*(t)+1):(30*t)+7), m(2,  (30*(t)+1):(30*t)+7));
    hold all;
end

%%
mksqlite('open','H:\work\dryrun\test1.sqlite')
dat2 = mksqlite('SELECT mote, MAX(data), COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS FROM data WHERE VAR= ''energy'' GROUP BY mote,  COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS');
dat2 = struct2cell(dat2);
m2 = cell2mat(dat2);
%%
figure
for t = 0:19
    plot(m2(3, (30*(t)+1):(30*t)+7), m2(2,  (30*(t)+1):(30*t)+7));
    hold all;
end

%%
mksqlite('open','H:\work\dryrun\long.sqlite')
str3 = mksqlite('SELECT time, data, COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS FROM data WHERE VAR= ''energy'' AND mote=18');
cell3 = struct2cell(str3);
m3_good = cell2mat(cell3);

%%
mksqlite('open','H:\work\dryrun\long_bad_rep.sqlite')
str3 = mksqlite('SELECT time, data, COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS FROM data WHERE VAR= ''energy'' AND mote=18');
cell3 = struct2cell(str3);
m3_bad = cell2mat(cell3);

%%
O = [];
for t = 1:12
    tmp = m3(2, find(m3(3,:) == t))';
    O(t,1:length(tmp)) = tmp;
end

%%
figure
plot(O3_good)



