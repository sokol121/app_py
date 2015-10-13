%import MySQLdb
<!DOCTYPE html>
<html>
<head>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="/static/jquery-1.11.3.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="/static/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="/static/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="/static/js/bootstrap.min.js"></script>

</head>

<body>
	<div  id="pageone">
        <div >
            <h1>Mote List</h1>
        </div>
            
        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingOne">
%for mote in motes:
                    <a role="button" class="btn btn-primary btn-lg btn-block" data-toggle="collapse" data-parent="#accordion" href="#collapse{{mote['id']}}" aria-expanded="true" aria-controls="collapseOne" >
                            Mote id: {{mote['id']}}
                    </a>
    
    %    params = (mote['id'],)
    %    statement = ("SELECT * , "
    %                "(select value from reading where sensor_id = sb_s.sensor_id and mote_id = m.id order by timestamp desc limit 1)  as value " 
    %                "FROM ((sensor s join sensorboard_sensor sb_s on s.id = sb_s.sensor_id) join sensorboard sb on sb.id = sb_s.sensorboard_id) "
    %                    "join mote m on m.sensorboard_id = sb.name  where m.id = %s")                   
    %    db.execute(statement, params)
    %    sensors = db.fetchall()
    
                    <div id="collapse{{mote['id']}}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">  
    %for sensor in sensors:
                            <a href="/chart/{{mote['id']}}/{{sensor['id']}}" class="btn btn-primary btn-lg btn-block" >{{sensor['name']}} - {{sensor['name_of_measurment']}} value: {{sensor['value']}} [{{sensor['unit']}}] </a>
    %end
                        </div>
                    </div>
%end
                </div>
            </div>
    </div>
</body>
</html>
