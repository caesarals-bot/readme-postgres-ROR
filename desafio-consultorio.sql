CREATE DATABASE consultorio;
CREATE DATABASE
\c consultorio
You are now connected to database "consultorio" as user "postgres".
CREATE TABLE pacientes(id varchar(20), rut varchar not null unique, nombre varchar(50), direccion varchar(50), PRIMARY KEY (id));

CREATE TABLE consultas(id varchar(20), fecha date, hora time , box varchar(4), PRIMARY KEY (id));

CREATE TABLE asignacion_consultas(id varchar(20), PRIMARY KEY (id));

CREATE TABLE medicos(id varchar(20),rut varchar(50) not null unique, nombre varchar(50), direccion varchar(50), PRIMARY KEY (id));

CREATE TABLE especialidad(id varchar(20),descripcion varchar(250), PRIMARY KEY (id));

CREATE TABLE licencias(id varchar(20), diagnostico varchar(250) not null, fecha_iniio date not null, fecha_termino date not null , PRIMARY KEY (id));

ALTER TABLE licencias ADD COLUMN id_paciente varchar, ADD COLUMN id_medico varchar;

ALTER TABLE licencias ADD CONSTRAINT fk_medico_licencia FOREIGN KEY (id_medico) REFERENCES medicos(id);

ALTER TABLE licencias ADD CONSTRAINT fk_paciente_licencia FOREIGN KEY (id_paciente) REFERENCES pacientes(id);

ALTER TABLE consultas ADD COLUMN id_paciente varchar;

ALTER TABLE consultas ADD CONSTRAINT fk_paciente_consulta FOREIGN KEY (id_paciente) REFERENCES pacientes(id);

ALTER TABLE medicos ADD COLUMN id_especialidad varchar;

ALTER TABLE medicos ADD CONSTRAINT fk_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad(id);

ALTER TABLE asignacion_consultas ADD COLUMN id_consulta varchar, ADD COLUMN id_medico varchar;

ALTER TABLE asignacion_consultas ADD CONSTRAINT fk_asignacion_consulta FOREIGN KEY (id_consulta) REFERENCES consultas(id);

ALTER TABLE asignacion_consultas ADD CONSTRAINT fk_asignacion_medico FOREIGN KEY (id_medico) REFERENCES medicos(id);
