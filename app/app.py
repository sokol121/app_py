"""
Author: Piotr Okula
"""
import bottle
import bottle_mysql 
import json
from bottle import route, request, run, get, view, template, error, install
from bottle import static_file
import datetime
from time import mktime

class MyEncoder(json.JSONEncoder):

    def default(self, obj):
        if isinstance(obj, datetime.datetime):
            return obj.strftime("%H:%M:%S")
        return json.JSONEncoder.default(self, obj)
    
install(bottle_mysql.Plugin(dbuser='root', dbpass='nzozpoz.', dbname='temps'))
@error(404)
def error404(error):
    return 'Nothing here, sorry'

@route('/')
@route('/mote')
def mote_list(db):
    output = template( 'motes_list', motes = getMotes(db), db = db)
    return output

@route('/chart/<mote>/<sensor>')
def chart(db, sensor = "test sensor", mote = "no mote"):
    output = template('chart', sensor = sensor, mote = mote, sensors = getSensorList(mote, sensor, db), db = db)
    return output

@route('/getData/<sensor>/<mote>')
def getData(sensor, mote, db):
    parameters= (sensor,mote)
    db.execute("select value, timestamp from reading where sensor_id = %s and mote_id = %s order by timestamp", parameters)
    result = db.fetchall()
#    values = [[ int(mktime(value['timestamp'].timetuple()) * 1000 ), value['value']] for value in result]
    values = [[ value['timestamp'], value['value']] for value in result]
    stringJson = json.dumps(values)
    return stringJson

@route('/getNewSensorReading/<sensor>/<mote>/<timestamp>')
def getNewSensorReading(sensor, mote, timestamp, db):
    parameters= (sensor, mote, timestamp)
    db.execute("select value, timestamp from reading where sensor_id = %s and mote_id = %s and timestamp > %s order by timestamp", parameters)
    result = db.fetchall()
    if result:
        values = [[ value['timestamp'], value['value']] for value in result]
        stringJson = json.dumps(values)
        return stringJson
    return {'empty'}


def getSensorList(mote, sensor, db):
    params = (mote, sensor)
    statement = ("SELECT * , "
                "(select value from reading where sensor_id = sb_s.sensor_id and mote_id = m.id order by timestamp desc limit 1)  as value " 
                "FROM ((sensor s join sensorboard_sensor sb_s on s.id = sb_s.sensor_id) join sensorboard sb on sb.id = sb_s.sensorboard_id) "
                    "join mote m on m.sensorboard_id = sb.name where m.id = %s and s.id != %s")                   
    db.execute(statement, params)
    sensors = db.fetchall()
    return sensors                    
                     

@route('/getSensorParams/<sensor>')
def getSensorParams(sensor, db):
    parameters= (sensor,)
    db.execute("select * from sensor where id = %s", parameters)
    result = db.fetchall()
    if result:
        return  json.dumps(result[0])
    return {'empty'}

@route('/static/<filename:path>')
def static(filename):
 return static_file(filename, root='static/') 
 
def getMotes(db):
    db.execute("SELECT * FROM mote")
    result = db.fetchall()
    return result
    
    
run(host = '192.168.0.105', port = '80', debug='TRUE')
