activiti_remember_me="LThtY2U5QTcwZWRYczlnRE9Hb1BMQTpsUGpwWjdicTlLZVJ1QVBZT0gzUkJR"
csrf_token="9e1351973d2a1531b610dd1b8cafd26868"
proc_def_id="model2:1:6"
proc_name="model2 - June 1st 2026"

#!/bin/bash
for i in {1..25000}
do
  curl 'http://localhost:9999/activiti-app/app/rest/process-instances' \
    -H 'Accept: application/json, text/plain, */*' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -b "ACTIVITI_REMEMBER_ME=$activiti_remember_me; CSRF-TOKEN=$csrf_token" \
    -H "X-CSRF-TOKEN: $csrf_token" \
    --data-raw "{\"processDefinitionId\":\"$proc_def_id\",\"name\":\"$proc_name\"}" \
    -s -o /dev/null
 
  echo "Request $i completed"
done
 
 