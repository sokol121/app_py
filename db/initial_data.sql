DELETE FROM sensor;
/*mts400 sensors*/
INSERT INTO sensor (id, name, name_of_measurment, unit, accuracy) VALUES ('SHT11-temp', 'Sensirion SHT11', 'Temperature','°C', '± 2°C');
INSERT INTO sensor (id, name, name_of_measurment, unit, accuracy) VALUES ('SHT11-hum', 'Sensirion SHT11', 'Humidity','RH', '± 3% RH');
INSERT INTO sensor (id, name, name_of_measurment, unit, accuracy) VALUES ('Intersema-press', 'Intersema MS5534', 'Pressure:','mbar', '± 3.5% mbar');
INSERT INTO sensor (id, name, name_of_measurment, unit, accuracy) VALUES ('Intersema-temp', 'Intersema MS5534', 'Temperature:','°C', '± 2°C');
INSERT INTO sensor (id, name, name_of_measurment, unit, accuracy) VALUES ('Taos ch1', 'Taos TSL2550', 'Light ch1:','nm', '± 2°C');
INSERT INTO sensor (id, name, name_of_measurment, unit, accuracy) VALUES ('Taos ch2', 'Taos TSL2550', 'Light ch2:','nm', '± 2°C');
INSERT INTO sensor (id, name, name_of_measurment, unit, accuracy) VALUES ('ADXL202JE-X', 'Analog Devices ADXL202JE', 'X-Axis Accelerometer','nm', '167 mV/G, ±17 %');
INSERT INTO sensor (id, name, name_of_measurment, unit, accuracy) VALUES ('ADXL202JE-Y', 'Analog Devices ADXL202JE', 'Y-Axis Accelerometer','nm', '167 mV/G, ±17 %');

DELETE FROM sensorboard;
INSERT INTO sensorboard (id, name) VALUES (1,'mts400');

DELETE FROM  sensorboard_sensor;
INSERT INTO sensorboard_sensor (sensor_id, sensorboard_id) VALUES ('SHT11-temp', 1);
INSERT INTO sensorboard_sensor (sensor_id, sensorboard_id) VALUES ('SHT11-hum',1);
INSERT INTO sensorboard_sensor (sensor_id, sensorboard_id) VALUES ('Intersema-press',1);
INSERT INTO sensorboard_sensor (sensor_id, sensorboard_id) VALUES ('Intersema-temp',1);
INSERT INTO sensorboard_sensor (sensor_id, sensorboard_id) VALUES ('Taos ch1', 1);
INSERT INTO sensorboard_sensor (sensor_id, sensorboard_id) VALUES ('Taos ch2', 1);
INSERT INTO sensorboard_sensor (sensor_id, sensorboard_id) VALUES ('ADXL202JE-X', 1);
INSERT INTO sensorboard_sensor (sensor_id, sensorboard_id) VALUES ('ADXL202JE-Y', 1);

commit;
