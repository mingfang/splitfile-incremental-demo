# Splitfile For Incremental Updates Across Multiple Splitgraph Engines and PostgREST
```
CSV -import-> Engine_1 -push-> Engine_2 -checkout-> Engine_3 -read-> PostgREST 
```
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
Committed history-1 as 3455822ae918.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-1', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Tagged incremental:c0752350bf707b1622a56dbaf2873e3197a8f889934d4ea279aaba360b24c30c with history-1.
c0752350bf   [HEAD, history-1, latest]  2021-08-14 22:57:23  INSERT INTO rdu (        SELECT * FROM "history-1".rdu    )
1f7e87467a                              2021-08-14 22:57:22  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-1".rdu    WITH NO DATA
0000000000                              2021-08-14 22:57:22
push to engine_2
Pushing incremental to demo/weather on remote engine_2
clone on engine_3 from engine_2
demo/weather:c0752350bf707b1622a56dbaf2873e3197a8f889934d4ea279aaba360b24c30c depends on:
demo/weather:0000000000000000000000000000000000000000000000000000000000000000
history-1:3455822ae9186abca9c863ff04b6f2e6774035adf531d0f4d4123ee34bf4f900
checkout layered on engine_3 from engine_2
Checked out demo/weather:c0752350bf70.
engine_3 Aggregate  (cost=11.58..11.59 rows=1 width=8)
->  Foreign Scan on rdu  (cost=20.00..0.00 rows=4633 width=0)
Multicorn: Original Multicorn quals: []
Multicorn: CNF quals: []
Multicorn: Objects removed by filter: 0
Multicorn: Scan through 1 object(s) (109.61 KiB)
engine_3 4633
checkout on engine_3 from engine_2
Checked out demo/weather:c0752350bf70.
engine_3 Aggregate  (cost=92.34..92.35 rows=1 width=8)
->  Seq Scan on rdu  (cost=0.00..90.47 rows=747 width=0)
engine_3 4633
PostgREST Content-Range: 0-4632/4633
clean up
Repository history-1 will be deleted.
Repository incremental will be deleted.

import history-2
Initialized empty repository history-2
Committed history-2 as 151e9193c939.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-2', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Tagged incremental:0bd1be8f7645d16301b72b2ac3b302ac1ba530969501c617194b7d57c544c175 with history-2.
0bd1be8f76   [HEAD, history-2, latest]  2021-08-14 22:57:34  INSERT INTO rdu (        SELECT * FROM "history-2".rdu    )
3bffb151d9                              2021-08-14 22:57:34  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-2".rdu    WITH NO DATA
c0752350bf   [history-1]                2021-08-14 22:57:23  INSERT INTO rdu (        SELECT * FROM "history-1".rdu    )
1f7e87467a                              2021-08-14 22:57:22  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "history-1".rdu    WITH NO DATA
0000000000                              2021-08-14 22:57:33
push to engine_2
Pushing incremental to demo/weather on remote engine_2
clone on engine_3 from engine_2
demo/weather:0bd1be8f7645d16301b72b2ac3b302ac1ba530969501c617194b7d57c544c175 depends on:
history-2:151e9193c939b7e9167c22e3485ea2e2a337e0d2b0eed3d1e075b884672d5b35
demo/weather:c0752350bf707b1622a56dbaf2873e3197a8f889934d4ea279aaba360b24c30c
checkout layered on engine_3 from engine_2
Checked out demo/weather:0bd1be8f7645.
engine_3 Aggregate  (cost=11.59..11.60 rows=1 width=8)
->  Foreign Scan on rdu  (cost=20.00..0.00 rows=4634 width=0)
Multicorn: Original Multicorn quals: []
Multicorn: CNF quals: []
Multicorn: Objects removed by filter: 0
Multicorn: Scan through 2 object(s) (111.93 KiB)
engine_3 4634
checkout on engine_3 from engine_2
Checked out demo/weather:0bd1be8f7645.
engine_3 Aggregate  (cost=92.34..92.35 rows=1 width=8)
->  Seq Scan on rdu  (cost=0.00..90.47 rows=747 width=0)
engine_3 4634
PostgREST Content-Range: 0-4633/4634
clean up
Repository history-2 will be deleted.
Repository incremental will be deleted.
```
