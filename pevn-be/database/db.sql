CREATE DATABASE pevn;

CREATE TABLE professor (
    id_p SERIAL PRIMARY KEY, 
    p_name TEXT NOT NULL, 
    p_email TEXT NOT NULL UNIQUE,
    p_password TEXT NOT NULL
);

CREATE TABLE student (
    id_s SERIAL PRIMARY KEY,
    s_name TEXT NOT NULL,
    s_email TEXT NOT NULL UNIQUE,
    s_password TEXT NOT NULL
);

CREATE TABLE course (
    id_c SERIAL PRIMARY KEY,
    p_id INTEGER REFERENCES professor(id_p),
    c_name TEXT NOT NULL,
    c_description TEXT NOT NULL
);

CREATE TABLE studentvscourse (
    s_id INTEGER NOT NULL REFERENCES student(id_s),
    c_id INTEGER NOT NULL REFERENCES course(id_c)
);

CREATE VIEW professorvscourse 
AS 
    SELECT * 
    FROM course JOIN (SELECT p_name, p_email, id_p 
        FROM professor) AS p ON p_id=id_p;

CREATE TABLE assignment (
    id_a SERIAL PRIMARY KEY,
    c_id INTEGER NOT NULL REFERENCES course(id_c),
    a_name TEXT NOT NULL,
    a_description TEXT, 
    a_file TEXT NOT NULL
);

CREATE TABLE delivery(
    id_d SERIAL PRIMARY KEY,
    a_id INTEGER REFERENCES assignment(id_a),
    s_id INTEGER REFERENCES student(id_s),
    d_file TEXT NOT NULL,
    d_filename TEXT
);