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
Initialized empty repository history-1
Committed history-1 as a17fa065bbf6.
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-1', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Pushing incremental to demo/weather on remote engine_2
demo/weather:ed977eb00e57ba34f07a50ab042b4bca21d0e2afa6494946bfc2858a8f86fd05 depends on:
demo/weather:0000000000000000000000000000000000000000000000000000000000000000
history-1:a17fa065bbf67485b09b4555aa004f07be525a602a8a6a3c83015e1a8f8030f3
4633
demo/weather:ed977eb00e57ba34f07a50ab042b4bca21d0e2afa6494946bfc2858a8f86fd05 depends on:
demo/weather:0000000000000000000000000000000000000000000000000000000000000000
history-1:a17fa065bbf67485b09b4555aa004f07be525a602a8a6a3c83015e1a8f8030f3
4633
Repository history-1 will be deleted.
Repository incremental will be deleted.
Initialized empty repository history-2
Committed history-2 as 6160429f7440.
Executing Splitfile incremental.splitfile with arguments {'SOURCE': 'history-2', 'DESTINATION': 'demo/weather', 'TABLE': 'rdu'}
Pushing incremental to demo/weather on remote engine_2
demo/weather:3174472049a98ef6eabecff498cce060317dbd103c7911b002ad4f0b29c086f7 depends on:
demo/weather:ed977eb00e57ba34f07a50ab042b4bca21d0e2afa6494946bfc2858a8f86fd05
history-2:6160429f7440dd943fa70df446ba92c9dbe90ed70f680740d830b97579e24a0f
4634
demo/weather:3174472049a98ef6eabecff498cce060317dbd103c7911b002ad4f0b29c086f7 depends on:
demo/weather:ed977eb00e57ba34f07a50ab042b4bca21d0e2afa6494946bfc2858a8f86fd05
history-2:6160429f7440dd943fa70df446ba92c9dbe90ed70f680740d830b97579e24a0f
4634
Repository history-2 will be deleted.
Repository incremental will be deleted.
```