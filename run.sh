#!/bin/bash
set -e

SOURCE_DIR="./data"
TABLE=rdu
KEY=date
SEPARATOR=";"
DESTINATION=demo/weather

setup() {
  docker-compose --project-name splitgraph_example down -v --remove-orphans
  docker-compose --project-name splitgraph_example build
  docker-compose --project-name splitgraph_example up -d
}

init() {
  sgr init
  SG_ENGINE=engine_2 sgr init
  SG_ENGINE=engine_2 sgr init $DESTINATION
  SG_ENGINE=engine_3 sgr init
  docker-compose --project-name splitgraph_example exec -T objectstorage mkdir /tmp/splitgraph
}

run() {
  for SOURCE_PATH in `ls $SOURCE_DIR/*.csv | sort`; do
    SOURCE_IMAGE=$(basename $SOURCE_PATH | tr '.' '_')
    if sgr tag -r engine_2 $DESTINATION:$SOURCE_IMAGE; then
      echo "skipping $SOURCE_IMAGE"
      continue
    fi

    echo ""
    echo "import $SOURCE_PATH"
    sgr init $SOURCE_IMAGE
    sgr csv import -f $SOURCE_PATH \
                   -k $KEY \
                   --separator $SEPARATOR \
                   $SOURCE_IMAGE $TABLE
    sgr commit $SOURCE_IMAGE

    echo "build incremental splitfile"
    sgr clone -r engine_2 $DESTINATION
    sgr build incremental.splitfile -a SOURCE $SOURCE_IMAGE -a DESTINATION $DESTINATION -a TABLE $TABLE -a KEY $KEY
    sgr tag incremental $SOURCE_IMAGE
    sgr log incremental

    echo "push to engine_2"
    sgr push incremental --remote engine_2 $DESTINATION

    echo "clone on engine_3 from engine_2"
    SG_ENGINE=engine_3 sgr clone -r engine_2 $DESTINATION
    SG_ENGINE=engine_3 sgr provenance $DESTINATION

    echo "checkout layered on engine_3 from engine_2"
    SG_ENGINE=engine_3 sgr checkout -l $DESTINATION:latest
#    echo "engine_3 `SG_ENGINE=engine_3 sgr sql -s $DESTINATION "explain select count(*) from $TABLE"`"
    echo "engine_3 `SG_ENGINE=engine_3 sgr sql -s $DESTINATION "select count(*) from $TABLE"`"

#    echo "checkout on engine_3 from engine_2"
#    SG_ENGINE=engine_3 sgr checkout $DESTINATION:latest
#    echo "engine_3 `SG_ENGINE=engine_3 sgr sql -s $DESTINATION "explain select count(*) from $TABLE"`"
#    echo "engine_3 `SG_ENGINE=engine_3 sgr sql -s $DESTINATION "select count(*) from $TABLE"`"

    echo "PostgREST `curl -s -I -H "Prefer: count=exact" http://localhost:8080/$TABLE | grep Range`"

    echo "clean up"
    sgr rm -y $SOURCE_IMAGE
    sgr rm -y incremental
  done
}

teardown() {
  docker-compose --project-name splitgraph_example down -v --remove-orphans
}

main() {
  setup
  init
  run
  run
  teardown
}

main