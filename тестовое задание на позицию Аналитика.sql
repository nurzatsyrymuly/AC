CREATE DATABASE oskemen;

CREATE TABLE zakazy (
    zakazy_id INT PRIMARY KEY,
    raion VARCHAR(255),
    data_zakaz DATE,
    summa DECIMAL(10, 2),
    nasenka DECIMAL(5, 2)
);

CREATE TABLE voditeli (
    voditeli_id INT PRIMARY KEY,
    raion VARCHAR(255),
    statusy VARCHAR(50)
);

UPDATE zakazy
SET nasenka
 = CASE
    WHEN (SELECT COUNT(*) FROM voditeli WHERE raion = zakazy.raion) < (SELECT COUNT(*) FROM zakazy WHERE raion = zakazy.raion) THEN
        zakazy.nasenka * 1.2 
    WHEN (SELECT COUNT(*) FROM voditeli WHERE raion = zakazy.raion) > (SELECT COUNT(*) FROM zakazy WHERE raion = zakazy.raion) THEN
        zakazy.nasenka * 0.8
    ELSE
        zakazy.nasenka 
END
WHERE zakazy.data_zakaz = current_date();


