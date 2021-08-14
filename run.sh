# setup
docker-compose --project-name splitgraph_example down -v --remove-orphans
docker-compose --project-name splitgraph_example build
docker-compose --project-name splitgraph_example up -d

DESTINATION=demo/weather

# init
sgr init
SG_ENGINE=engine_2 sgr init
SG_ENGINE=engine_2 sgr init $DESTINATION
SG_ENGINE=engine_3 sgr init

# run
for SOURCE in "history-1" "history-2"; do
  sgr init $SOURCE
  sgr csv import -f rdu-weather-$SOURCE.csv \
                     -k date \
                     -t date timestamp \
                     --separator ";" \
                     $SOURCE rdu
  sgr commit $SOURCE

  sgr clone -r engine_2 $DESTINATION
  sgr build incremental.splitfile -a SOURCE $SOURCE -a DESTINATION $DESTINATION -a TABLE rdu
  sgr push incremental --remote engine_2 $DESTINATION --upload-handler DB

  SG_ENGINE=engine_2 sgr provenance $DESTINATION
  SG_ENGINE=engine_2 sgr sql -i $DESTINATION "select count(*) from rdu"

  SG_ENGINE=engine_3 sgr clone -r engine_2 $DESTINATION
  SG_ENGINE=engine_3 sgr provenance $DESTINATION
  SG_ENGINE=engine_3 sgr sql -i $DESTINATION "select count(*) from rdu"

  sgr rm -y $SOURCE
  sgr rm -y incremental
done

# teardown
docker-compose --project-name splitgraph_example down -v --remove-orphans
