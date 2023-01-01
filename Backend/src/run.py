from application.main import app

f = open("/status.txt","w")
f.write("Offline")
f.close()
app.run(host='0.0.0.0', port=1337, debug=False)