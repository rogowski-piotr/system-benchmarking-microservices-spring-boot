DROP TABLE IF EXISTS place;


CREATE TABLE place (
    id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    coordinates TEXT NOT NULL
);


INSERT INTO place (city, coordinates) VALUES ('gdansk', '11, 11');
INSERT INTO place (city, coordinates) VALUES ('gdynia', '12, 12');
INSERT INTO place (city, coordinates) VALUES ('sopot', '13, 13');