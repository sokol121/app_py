CREATE DATABASE temps;
use temps;
drop table mote;
drop table sensorboard;
drop table sensorboard_sensor;
drop table sensor;
drop table reading;
create table mote	
	(
		id	INTEGER 	PRIMARY KEY,
		name 	varchar(100),
		sensorboard_id varchar(100)
	);
create table sensorboard	
	(
		id	INTEGER 	PRIMARY KEY,
		name 	varchar(100)
	);
create table sensorboard_sensor
	(
		sensorboard_id 		INTEGER,
		sensor_id		varchar(100),
		PRIMARY KEY		(sensorboard_id, sensor_id)  
	);
create table sensor
	(
		id 				varchar(100)	PRIMARY KEY,
		name 				varchar(100),
		name_of_measurment 		varchar(100),
		unit 				varchar(100),
		accuracy			varchar(15)
	);
create table reading
	(
		mote_id 	INTEGER,
		sensor_id	varchar(100),
		value		INTEGER,
		timestamp 	timestamp DEFAULT CURRENT_TIMESTAMP(),
		PRIMARY KEY	(timestamp, mote_id, sensor_id)  
	);
