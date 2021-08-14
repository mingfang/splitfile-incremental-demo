# Splitfile For Incremental Updates Across Multiple Splitgraph Engines

## RUN
```shell
./run.sh 2> /dev/null
```

Output should look like below.

The first set of numbers, 4633, reflect the number of rows in the first CSV file across two Splitgraph engines.

The second set of numbers, 4634, are from the sames set of engines but after the second CSV files has been ingested.
```
Waiting for connection....
Initialized empty repository demo/weather

import history-1
Initialized empty repository history-1
Committed history-1 as 7f693ad5964c.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-1', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Tagged incremental:075edf10f7e4db7c8e1335651aaf86bdeb65cfa90c291b11cf043f9fcfda6736 with history-1.
075edf10f7   [HEAD, history-1, latest]  2021-08-14 18:55:45  INSERT INTO rdu (        SELECT * FROM "history-1".rdu    )
929ac2e0f3                              2021-08-14 18:55:44  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-1".rdu    WITH NO DATA
0000000000                              2021-08-14 18:55:44
push to engine_2
Pushing incremental to demo/weather on remote engine_2
demo/weather:075edf10f7e4db7c8e1335651aaf86bdeb65cfa90c291b11cf043f9fcfda6736 depends on:
history-1:7f693ad5964cb64e29fb55c10c72f4ff4c7b3f470376ce411459533b45ea4ece
demo/weather:0000000000000000000000000000000000000000000000000000000000000000
4633
clone from engine_2 to engine_3
Checked out demo/weather:075edf10f7e4.
demo/weather:075edf10f7e4db7c8e1335651aaf86bdeb65cfa90c291b11cf043f9fcfda6736 depends on:
history-1:7f693ad5964cb64e29fb55c10c72f4ff4c7b3f470376ce411459533b45ea4ece
demo/weather:0000000000000000000000000000000000000000000000000000000000000000
4633
clean up
Repository history-1 will be deleted.
Repository incremental will be deleted.

import history-2
Initialized empty repository history-2
Committed history-2 as bb7a175e9267.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-2', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Tagged incremental:806f319ee2cc04e90b76bba6e42800fe758e236036fdc2b772044cb72fcec5b3 with history-2.
806f319ee2   [HEAD, history-2, latest]  2021-08-14 18:55:55  INSERT INTO rdu (        SELECT * FROM "history-2".rdu    )
20f1747dfe                              2021-08-14 18:55:54  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-2".rdu    WITH NO DATA
075edf10f7   [history-1]                2021-08-14 18:55:45  INSERT INTO rdu (        SELECT * FROM "history-1".rdu    )
929ac2e0f3                              2021-08-14 18:55:44  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-1".rdu    WITH NO DATA
0000000000                              2021-08-14 18:55:54
push to engine_2
Pushing incremental to demo/weather on remote engine_2
demo/weather:806f319ee2cc04e90b76bba6e42800fe758e236036fdc2b772044cb72fcec5b3 depends on:
demo/weather:075edf10f7e4db7c8e1335651aaf86bdeb65cfa90c291b11cf043f9fcfda6736
history-2:bb7a175e926736d0c38968024b7177de34e0a690a8183bd4c51df316ad9bd011
4634
clone from engine_2 to engine_3
Checked out demo/weather:806f319ee2cc.
demo/weather:806f319ee2cc04e90b76bba6e42800fe758e236036fdc2b772044cb72fcec5b3 depends on:
demo/weather:075edf10f7e4db7c8e1335651aaf86bdeb65cfa90c291b11cf043f9fcfda6736
history-2:bb7a175e926736d0c38968024b7177de34e0a690a8183bd4c51df316ad9bd011
4634
clean up
Repository history-2 will be deleted.
Repository incremental will be deleted.
```