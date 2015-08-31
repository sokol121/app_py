%import MySQLdb
%import json
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<!--<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.js"></script>
<!-- highcharts -->
<script src="http://code.highcharts.com/stock/highstock.js"></script>
<script src="http://code.highcharts.com/stock/modules/exporting.js"></script>
<script type="text/javascript" src="http://www.highcharts.com/samples/data/usdeur.js"></script>
    
<link rel="stylesheet" href="/static/css/iThing.css" type="text/css" />

<style>
    canvas{
        width: 100%;
        max-width: 2000px;
    }
</style>

    
<body>
<!--    <h1>{{sensor}} {{mote}}</h1>-->
    
    <div id="container" style = " width: 100%; 2000px"></div>
</body>
 
<script>
var jsonData;    
var detailDataGlobal;
var sensorParams = $.getJSON('../../getSensorParams/{{sensor}}');
    
$(function () {
    $.getJSON('../../getData/{{sensor}}/{{mote}}', function (data) {
        // Create the chart
        $('#container').highcharts('StockChart', {
            chart: {
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
                    inputDateFormat: '%Y-%m-%d %H:%M',
                    inputEditDateFormat: '%Y-%m-%d %H:%M',
                    inputBoxWidth : 110
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
</script>

</html>
