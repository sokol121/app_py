%import MySQLdb
%import json
<!DOCTYPE html>
<html>
<head>

<script src="/static/jquery-1.11.3.min.js"></script>
<!-- highcharts -->
<script src="/static/js/highstock.js"></script>
<script src="/static/js/modules/exporting.js"></script>
<!--<script type="text/javascript" src="http://www.highcharts.com/samples/data/usdeur.js"></script>-->
<link rel="stylesheet" href="/static/css/iThing.css" type="text/css" />
 
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="/static/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="/static/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="/static/js/bootstrap.min.js"></script>

<style>
    canvas{
        width: 100%;
        max-width: 2000px;
    }
</style>

    
<body>
    <ol class="breadcrumb">
        <li><a href="/../..">Home</a></li>
        <li><a href="">{{mote}}</a></li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{{sensor}}<span class="caret"></span></a>
            <ul class="dropdown-menu">
                %for sensorIter in sensors:
                    <li><a href="{{sensorIter['sensor_id']}}">{{sensorIter['sensor_id']}}</a></li>
                %end
            </ul>
        </li>
        <button type="button" class="btn btn-warning center-block" id="onlineOffline">Online</button>
    </ol>
    
<!--    <h1>{{sensor}} {{mote}}</h1>-->
    
    <div id="container" style = " width: 100%; 2000px"></div>
</body>
 
<script>
var maxTimestamp
var jsonData;    
var detailDataGlobal;
var sensorParams = $.getJSON('../../getSensorParams/{{sensor}}');
var pointerToSeries;
var online = false;
var intervalFuntionsId;
$('#onlineOffline').on('click', function() {
    $('#onlineOffline').toggleClass("btn-success");
    $('#onlineOffline').toggleClass("btn-warning");
    online = !online;
    if(online){
        $('#onlineOffline').html("Online");
        getNewReadings();
    }
    else{    
        $('#onlineOffline').html("Offline")
        clearInterval(intervalFuntionsId);
    }
});
                             
    
$(function () {
    $.getJSON('../../getData/{{sensor}}/{{mote}}', function (data) {
        maxTimestamp = data[data.length - 1][0];
        // Create the chart
        $('#container').highcharts('StockChart', {
            chart: {
                    events : {
                            load : function () {
                            pointerToSeries = this.series[0];
                        }
                    },
                type: 'line'
            },
            rangeSelector : {
                buttons: [{
                    type: 'second',
                    count: 10,
                    text: '100s'
                },{
                    type: 'minute',
                    count: 10,
                    text: '10min'
                },{
                    type: 'all',
                    text: 'All'
                }],
                 buttonTheme: {
                    width: 50
                },
                    inputDateFormat: '%Y-%m-%d %H:%M:%S',
                    inputEditDateFormat: '%Y-%m-%d %H:%M:%S',
                    inputBoxWidth : 140,
                    inputDateParser: function (value) {
                        value = value.split(/[\/ .: .-]/);     
                        return Date.UTC(
                            parseInt(value[0], 10),
                            parseInt(value[1], 10) - 1 , // months are from 0 to 11 in this case i have to substract 1 
                            parseInt(value[2], 10),
                            parseInt(value[3], 10),
                            parseInt(value[4], 10),
                            parseInt(value[5], 10),
                            0);
                    }
            },
            yAxis: [{
                labels: {
                    align: 'right',
                    x: -3
                },
                title: {
                    text: sensorParams.responseJSON.name_of_measurment + ': [' + sensorParams.responseJSON.unit + ']',
                },
            }],
            
            title : {
                text : 'Mote:{{mote}} sensor:{{sensor}}'
            },
            series : [{
                name : '{{sensor}}',
                data : data,
                tooltip: {
                    valueDecimals: 2
                }
            }]
        });
    });

});

    function getNewReadings(){
        intervalFuntionsId = setInterval(function () {
            var newReadings = $.getJSON('../../getNewSensorReading/{{sensor}}/{{mote}}/' + maxTimestamp, function (data) {
                maxTimestamp = data[data.length - 1][0];
                    $.each(data, function( index, value ) {
                       pointerToSeries.addPoint([value[0], value[1]], true, false);
                        });
                    }
                );
        }, 1000);
    }   
</script>

</html>
