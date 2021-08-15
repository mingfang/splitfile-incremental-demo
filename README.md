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

import ./data/rdu-weather-history-1.csv
Initialized empty repository rdu-weather-history-1_csv
Committed rdu-weather-history-1_csv as 9febabed940f.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'rdu-weather-history-1_csv', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu', 'KEY': 'date'}
Tagged incremental:50e50a2c8949c81fbe81a0ed684507167db846afa7cb2e307933b209489c7bac with rdu-weather-history-1_csv.
50e50a2c89   [HEAD, rdu-weather-history-1_csv, latest]  2021-08-15 21:37:08  INSERT INTO rdu (        SELECT * FROM "rdu-weather-history-1_csv".rdu    )
228edebc09                                              2021-08-15 21:37:07  ALTER TABLE rdu DROP CONSTRAINT IF EXISTS rdu_pkey;    ALTER TABLE rdu AD...
59bacb0993                                              2021-08-15 21:37:07  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "rdu-weather-history-1_csv".rd...
0000000000                                              2021-08-15 21:37:07
push to engine_2
Pushing incremental to demo/weather on remote engine_2
clone on engine_3 from engine_2
demo/weather:50e50a2c8949c81fbe81a0ed684507167db846afa7cb2e307933b209489c7bac depends on:
demo/weather:0000000000000000000000000000000000000000000000000000000000000000
rdu-weather-history-1_csv:9febabed940f05e817e42031ec281d89ae451bc745fa7c28144b9ddf7a5e67cc
checkout layered on engine_3 from engine_2
Checked out demo/weather:50e50a2c8949.
engine_3 4633
PostgREST Content-Range: 0-4632/4633
clean up
Repository rdu-weather-history-1_csv will be deleted.
Repository incremental will be deleted.

import ./data/rdu-weather-history-2.csv
Initialized empty repository rdu-weather-history-2_csv
Committed rdu-weather-history-2_csv as f99448c07eb1.
build incremental splitfile
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'rdu-weather-history-2_csv', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu', 'KEY': 'date'}
Tagged incremental:2e376a2fcf208a24d9093b7212a8f8ce947774da7247e4401b822e72f6e21649 with rdu-weather-history-2_csv.
2e376a2fcf   [HEAD, rdu-weather-history-2_csv, latest]  2021-08-15 21:37:17  INSERT INTO rdu (        SELECT * FROM "rdu-weather-history-2_csv".rdu    )
861102686f                                              2021-08-15 21:37:17  ALTER TABLE rdu DROP CONSTRAINT IF EXISTS rdu_pkey;    ALTER TABLE rdu AD...
b916d9e391                                              2021-08-15 21:37:17  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "rdu-weather-history-2_csv".rd...
50e50a2c89   [rdu-weather-history-1_csv]                2021-08-15 21:37:08  INSERT INTO rdu (        SELECT * FROM "rdu-weather-history-1_csv".rdu    )
228edebc09                                              2021-08-15 21:37:07  ALTER TABLE rdu DROP CONSTRAINT IF EXISTS rdu_pkey;    ALTER TABLE rdu AD...
59bacb0993                                              2021-08-15 21:37:07  CREATE TABLE IF NOT EXISTS rdu    AS TABLE "rdu-weather-history-1_csv".rd...
0000000000                                              2021-08-15 21:37:16
push to engine_2
Pushing incremental to demo/weather on remote engine_2
clone on engine_3 from engine_2
demo/weather:2e376a2fcf208a24d9093b7212a8f8ce947774da7247e4401b822e72f6e21649 depends on:
rdu-weather-history-2_csv:f99448c07eb1ce8835c011a79bd4bc52cc28e253d0b2a533fe996a9b29febb4d
demo/weather:50e50a2c8949c81fbe81a0ed684507167db846afa7cb2e307933b209489c7bac
checkout layered on engine_3 from engine_2
Checked out demo/weather:2e376a2fcf20.
engine_3 4634
PostgREST Content-Range: 0-4633/4634
clean up
Repository rdu-weather-history-2_csv will be deleted.
Repository incremental will be deleted.
rdu-weather-history-1_csv
skipping rdu-weather-history-1_csv
rdu-weather-history-2_csv
skipping rdu-weather-history-2_csv
```
