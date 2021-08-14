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
Committed history-1 as 541f1f6daa6b.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-1', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Tagged incremental:479b0b58966ef4187fa3506108c4e23196d241ce240b4bb4519d14f158e35a03 with history-1.
479b0b5896   [HEAD, history-1, latest]  2021-08-14 14:42:10  INSERT INTO rdu (        SELECT * FROM "history-1".rdu    )
a6431cc142                              2021-08-14 14:42:09  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-1".rdu    WITH NO DATA
0000000000                              2021-08-14 14:42:09
push to engine_2
Pushing incremental to demo/weather on remote engine_2
demo/weather:479b0b58966ef4187fa3506108c4e23196d241ce240b4bb4519d14f158e35a03 depends on:
demo/weather:0000000000000000000000000000000000000000000000000000000000000000
history-1:541f1f6daa6b91af425aaf71a20d24d352900bf3b19333c995d292015edf42ba
4633
clone from engine_2 to engine_3
demo/weather:479b0b58966ef4187fa3506108c4e23196d241ce240b4bb4519d14f158e35a03 depends on:
history-1:541f1f6daa6b91af425aaf71a20d24d352900bf3b19333c995d292015edf42ba
demo/weather:0000000000000000000000000000000000000000000000000000000000000000
4633
clean up
Repository history-1 will be deleted.
Repository incremental will be deleted.

import history-2
Initialized empty repository history-2
Committed history-2 as a4e86526562d.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-2', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Tagged incremental:432887c3fbb29445b88db15913b74bfb596b0a0775d1cc954c7c43d5abcf068f with history-2.
432887c3fb   [HEAD, history-2, latest]  2021-08-14 14:42:20  INSERT INTO rdu (        SELECT * FROM "history-2".rdu    )
55b3ea10d1                              2021-08-14 14:42:20  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-2".rdu    WITH NO DATA
479b0b5896   [history-1]                2021-08-14 14:42:10  INSERT INTO rdu (        SELECT * FROM "history-1".rdu    )
a6431cc142                              2021-08-14 14:42:09  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-1".rdu    WITH NO DATA
0000000000                              2021-08-14 14:42:19
push to engine_2
Pushing incremental to demo/weather on remote engine_2
demo/weather:432887c3fbb29445b88db15913b74bfb596b0a0775d1cc954c7c43d5abcf068f depends on:
history-2:a4e86526562d610ce6c07229c343adee4291e52b6d2b1240b7b5ae87fc2814c8
demo/weather:479b0b58966ef4187fa3506108c4e23196d241ce240b4bb4519d14f158e35a03
4634
clone from engine_2 to engine_3
demo/weather:432887c3fbb29445b88db15913b74bfb596b0a0775d1cc954c7c43d5abcf068f depends on:
history-2:a4e86526562d610ce6c07229c343adee4291e52b6d2b1240b7b5ae87fc2814c8
demo/weather:479b0b58966ef4187fa3506108c4e23196d241ce240b4bb4519d14f158e35a03
4634
clean up
Repository history-2 will be deleted.
Repository incremental will be deleted.
```