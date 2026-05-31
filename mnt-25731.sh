activiti_remember_me="akNMdUFZZVd4ZklENlRISmljTmRtZz09OjJpNGNKY0pnMDZLQmlWUzhaQ0tVekE9PQ"
csrf_token="9b3512e159853769a6e7a19021c178ece3"
user_name="User1 Lastname1"

declare -i x model_id appdef_id
for i in {1..1500}
do
   x=$((i+1))
   model_id=$((1000+(2*(i-1))+1))
   modelname="model$x"
   echo "Cloning model1 to $modelname. Expected model id: $model_id"

   curl 'http://localhost:8080/activiti-app/app/rest/models/1/clone' \
     -H 'Accept: application/json, text/plain, */*' \
     -H 'Accept-Language: en-IN,en;q=0.9' \
     -H 'Connection: keep-alive' \
     -H 'Content-Type: application/json;charset=UTF-8' \
     -b "ACTIVITI_REMEMBER_ME=$activiti_remember_me; CSRF-TOKEN=$csrf_token" \
     -H 'Origin: http://localhost:8080' \
     -H 'Referer: http://localhost:8080/activiti-app/editor/' \
     -H 'Sec-Fetch-Dest: empty' \
     -H 'Sec-Fetch-Mode: cors' \
     -H 'Sec-Fetch-Site: same-origin' \
     -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36' \
     -H "X-CSRF-TOKEN: $csrf_token" \
     -H 'sec-ch-ua: "Chromium";v="148", "Google Chrome";v="148", "Not/A)Brand";v="99"' \
     -H 'sec-ch-ua-mobile: ?0' \
     -H 'sec-ch-ua-platform: "Windows"' \
     --data-raw "{\"name\":\"$modelname\",\"description\":null,\"modelType\":0,\"stencilSet\":0,\"id\":1}"


   appdef="appdef$x"
   appdef_id=$((model_id+1))
   echo "Creating Application: $appdef. Expected app definition id: $appdef_id"

   curl 'http://localhost:8080/activiti-app/app/rest/models' \
     -H 'Accept: application/json, text/plain, */*' \
     -H 'Accept-Language: en-IN,en;q=0.9' \
     -H 'Connection: keep-alive' \
     -H 'Content-Type: application/json;charset=UTF-8' \
     -b "ACTIVITI_REMEMBER_ME=$activiti_remember_me; CSRF-TOKEN=$csrf_token" \
     -H 'Origin: http://localhost:8080' \
     -H 'Referer: http://localhost:8080/activiti-app/editor/' \
     -H 'Sec-Fetch-Dest: empty' \
     -H 'Sec-Fetch-Mode: cors' \
     -H 'Sec-Fetch-Site: same-origin' \
     -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36' \
     -H "X-CSRF-TOKEN: $csrf_token" \
     -H 'sec-ch-ua: "Chromium";v="148", "Google Chrome";v="148", "Not/A)Brand";v="99"' \
     -H 'sec-ch-ua-mobile: ?0' \
     -H 'sec-ch-ua-platform: "Windows"' \
     --data-raw "{\"name\":\"$appdef\",\"description\":\"\",\"modelType\":3}"

   #!model_id and appdef_id value is expected value by looking at the pattern. These ids should ideally be fetched from the response of the above API calls, but to keep it simple, we are just gussing the id based on the pattern observed in the response of previous API calls.
   echo "Updating Application: $appdef with $modelname..."
   
   curl "http://localhost:8080/activiti-app/app/rest/app-definitions/$appdef_id" \
     -X 'PUT' \
     -H 'Accept: application/json, text/plain, */*' \
     -H 'Accept-Language: en-IN,en;q=0.9' \
     -H 'Connection: keep-alive' \
     -H 'Content-Type: application/json;charset=UTF-8' \
     -b "ACTIVITI_REMEMBER_ME=$activiti_remember_me; CSRF-TOKEN=$csrf_token" \
     -H 'Origin: http://localhost:8080' \
     -H 'Referer: http://localhost:8080/activiti-app/editor/' \
     -H 'Sec-Fetch-Dest: empty' \
     -H 'Sec-Fetch-Mode: cors' \
     -H 'Sec-Fetch-Site: same-origin' \
     -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36' \
     -H "X-CSRF-TOKEN: $csrf_token" \
     -H 'sec-ch-ua: "Chromium";v="148", "Google Chrome";v="148", "Not/A)Brand";v="99"' \
     -H 'sec-ch-ua-mobile: ?0' \
     -H 'sec-ch-ua-platform: "Windows"' \
     --data-raw "{\"appDefinition\":{\"id\":$appdef_id,\"name\":\"$appdef\",\"description\":null,\"version\":1,\"created\":\"2026-05-29T12:33:54.626+0000\",\"definition\":{\"publishIdentityInfo\":[],\"theme\":\"theme-1\",\"icon\":\"glyphicon-asterisk\",\"models\":[{\"id\":$model_id,\"name\":\"$modelname\",\"version\":1,\"modelType\":0,\"description\":null,\"stencilSetId\":0,\"createdByFullName\":\"$user_name\",\"createdBy\":2,\"lastUpdatedByFullName\":\"$user_name\",\"lastUpdatedBy\":2,\"lastUpdated\":\"2026-05-29T12:29:38.049+0000\"}]}},\"publish\":true}"

done
