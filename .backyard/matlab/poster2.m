mksqlite('open','H:\work\dryrun\realsim3.sqlite')
str = mksqlite('Select mote, ROUTE_CONF_DEFAULT_LIFETIME, ROUTE_CONF_ENTRIES, max(data) from data where mote = 1 and var = ''loss'' and ROUTE_CONF_DECAY_THRESHOLD = 10  group by mote,ROUTE_CONF_DEFAULT_LIFETIME,  ROUTE_CONF_ENTRIES');

cell = struct2cell(str);
m18_blub = cell2mat(cell);


O = [];
m=m18_blub;
for t = 1:3
    tmp = m(3:4, find(m(2,:) == t*60));
    O(t*2-1:t*2,1:length(tmp)) = tmp;
end

figure('PaperSize',[80,80]);

 %NextPlot add

plot( O(1,:), O(2,:), O(3,:), O(4,:), O(5,:), O(6,:));
 
title('Node 1 (Sink), 20 min')
l = legend('60s lifetime','120s lifetime','180s lifetime');
set(l,...
    'Position',[0.793685756240822 0.552322163433274 0.140088105726872 0.133450911228689]);
ylabel('Packet loss')
xlabel('Routing table entries')





mksqlite('open','H:\work\dryrun\realsim3.sqlite')
str = mksqlite('Select mote, ROUTE_CONF_DEFAULT_LIFETIME, ROUTE_CONF_ENTRIES, max(data) from data where mote = 1 and var = ''energy'' and ROUTE_CONF_DECAY_THRESHOLD = 10  group by mote,ROUTE_CONF_DEFAULT_LIFETIME,  ROUTE_CONF_ENTRIES');

cell = struct2cell(str);
m18_blub = cell2mat(cell);


O = [];
m=m18_blub;
for t = 1:3
    tmp = m(3:4, find(m(2,:) == t*60));
    O(t*2-1:t*2,1:length(tmp)) = tmp;
end
figure('PaperSize',[80,80]);

 %NextPlot add

plot( O(1,:), O(2,:), O(3,:), O(4,:), O(5,:), O(6,:));
 
title('Node 1 (Sink), 20 min')
l= legend('60s lifetime','120s lifetime','180s lifetime')
set(l,...
    'Position',[0.793685756240822 0.552322163433274 0.140088105726872 0.133450911228689]);
ylabel('Energy usage')
xlabel('Routing table entries')