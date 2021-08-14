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
  echo ""
  echo "import $SOURCE"
  sgr init $SOURCE
  sgr csv import -f rdu-weather-$SOURCE.csv \
                     -k date \
                     -t date timestamp \
                     --separator ";" \
                     $SOURCE rdu
  sgr commit $SOURCE

  echo "build incremental splitfile"
  sgr clone -r engine_2 $DESTINATION
  sgr build incremental.splitfile -a SOURCE $SOURCE -a DESTINATION $DESTINATION -a TABLE rdu
  sgr tag incremental $SOURCE
  sgr log incremental

  echo "push to engine_2"
  sgr push incremental --remote engine_2 $DESTINATION --upload-handler DB
  SG_ENGINE=engine_2 sgr provenance $DESTINATION
  SG_ENGINE=engine_2 sgr sql -i $DESTINATION "select count(*) from rdu"

  echo "clone from engine_2 to engine_3"
  SG_ENGINE=engine_3 sgr clone -r engine_2 $DESTINATION
  SG_ENGINE=engine_3 sgr checkout -l $DESTINATION:latest
  SG_ENGINE=engine_3 sgr provenance $DESTINATION
  SG_ENGINE=engine_3 sgr sql -s $DESTINATION "select count(*) from rdu"

  echo "clean up"
  sgr rm -y $SOURCE
  sgr rm -y incremental
done

# teardown
docker-compose --project-name splitgraph_example down -v --remove-orphans
