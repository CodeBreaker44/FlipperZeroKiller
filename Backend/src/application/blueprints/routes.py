from flask import Blueprint, render_template, request
from application.util import response
import atexit
from apscheduler.schedulers.background import BackgroundScheduler

scheduler = BackgroundScheduler()
scheduler.start()
atexit.register(lambda: scheduler.shutdown())

def update_door():
    f = open("/status.txt","w")
    f.write("Offline")
    f.close()
    scheduler.remove_job("69420")



web = Blueprint('web', __name__)
api = Blueprint('api', __name__)



@web.route('/',methods = ['GET'])
def index():
    return render_template('index.html')


@web.route('/unlock',methods = ['POST'])
def unlock():
    return response('Unlocked')


@web.route('/lock',methods = ['POST'])
def lock():
    return response('Locked')


@web.route('/api/connect', methods = ['POST'])
def connect():
    f = open("/status.txt","w")
    f.write("Online")
    f.close()

    if scheduler.get_job("69420"):
        scheduler.remove_job("69420")
        scheduler.add_job(id="69420", func=update_door, trigger="interval", seconds=10)
    else:  
        scheduler.add_job(id="69420", func=update_door, trigger="interval", seconds=10)
    

    return response("Status Updated")


@web.route('/api/status', methods = ['GET'])
def status():
    f = open("/status.txt","r")
    door_status = f.read()
    f.close()
    return response(door_status)