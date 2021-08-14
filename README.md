# Splitfile For Incremental Updates Across Multiple Splitgraph Engines and PostgREST

## RUN
```shell
./run.sh 2> /dev/null
```

Output should look like below.

The first set of numbers, 4633, reflect the number of rows in the first CSV file across Splitgraph engine and PostREST.

The second set of numbers, 4634, are from the sames set of engines but after the second CSV files has been ingested.
```
Waiting for connection....
Initialized empty repository demo/weather

import history-1
Initialized empty repository history-1
Committed history-1 as ea50b2ee27cc.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-1', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Tagged incremental:4ee090d4e870979557c384b57ee3d2c4c2d573b0aaf0ca5945f06d314c7c4621 with history-1.
4ee090d4e8   [HEAD, history-1, latest]  2021-08-14 22:22:58  INSERT INTO rdu (        SELECT * FROM "history-1".rdu    )
35681ddaac                              2021-08-14 22:22:57  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-1".rdu    WITH NO DATA
0000000000                              2021-08-14 22:22:56
push to engine_2
Pushing incremental to demo/weather on remote engine_2
checkout on engine_3 from engine_2
Checked out demo/weather:4ee090d4e870.
demo/weather:4ee090d4e870979557c384b57ee3d2c4c2d573b0aaf0ca5945f06d314c7c4621 depends on:
demo/weather:0000000000000000000000000000000000000000000000000000000000000000
history-1:ea50b2ee27ccaf4cab8e3576b7965fb39e161e0ff488ffe3b3f5c106260f1da9
engine_3 4633
PostgREST Content-Range: 0-4632/4633
clean up
Repository history-1 will be deleted.
Repository incremental will be deleted.

import history-2
Initialized empty repository history-2
Committed history-2 as 9e3fe554c6bf.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-2', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Tagged incremental:bdcf9abd2acadda138029fe22aecbb569610cc081e1a3794325b1f5af14e64e5 with history-2.
bdcf9abd2a   [HEAD, history-2, latest]  2021-08-14 22:23:07  INSERT INTO rdu (        SELECT * FROM "history-2".rdu    )
ba6276170d                              2021-08-14 22:23:06  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-2".rdu    WITH NO DATA
4ee090d4e8   [history-1]                2021-08-14 22:22:58  INSERT INTO rdu (        SELECT * FROM "history-1".rdu    )
35681ddaac                              2021-08-14 22:22:57  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-1".rdu    WITH NO DATA
0000000000                              2021-08-14 22:23:06
push to engine_2
Pushing incremental to demo/weather on remote engine_2
checkout on engine_3 from engine_2
Checked out demo/weather:bdcf9abd2aca.
demo/weather:bdcf9abd2acadda138029fe22aecbb569610cc081e1a3794325b1f5af14e64e5 depends on:
demo/weather:4ee090d4e870979557c384b57ee3d2c4c2d573b0aaf0ca5945f06d314c7c4621
history-2:9e3fe554c6bf5821fe719f9b8459753cbf03dbf9baebdc62a5cb6ea89dc0260b
engine_3 4634
PostgREST Content-Range: 0-4633/4634
clean up
Repository history-2 will be deleted.
Repository incremental will be deleted.
```