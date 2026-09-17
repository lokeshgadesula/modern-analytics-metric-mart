import json,urllib.request
def send_slack(webhook_url,message):
 req=urllib.request.Request(webhook_url,data=json.dumps({"text":message}).encode(),headers={"Content-Type":"application/json"})
 with urllib.request.urlopen(req,timeout=10) as r:return r.status
