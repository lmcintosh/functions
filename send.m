% pushover notification script
% Niru Maheswaranathan
% Mon Aug 13 14:21:43 2012
% send(msgTitle, msgText)

function send(msgTitle, msgText)

    userKey    = 'VnKXLJ5EfypjQb9GLRkRKV6z63daQf';
    appToken   = 'S6F9y5CccnW7wVqkUqb9sXrKAXe6uV';
    deviceName = 'phone';

    params = { ...
        'token',   appToken, ...
        'user',    userKey, ...
        'device',  deviceName, ...
        'title',   msgTitle, ...
        'message', msgText};

    url = 'https://api.pushover.net/1/messages.json';

    s = urlread(url,'POST',params);
