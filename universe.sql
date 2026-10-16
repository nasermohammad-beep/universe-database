DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;
\c universe

CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL UNIQUE,
  galaxy_type TEXT NOT NULL,
  age_in_millions_of_years INT,
  distance_from_earth_mly NUMERIC(10,2),
  has_black_hole BOOLEAN
);

CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL UNIQUE,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  star_type TEXT NOT NULL,
  age_in_millions_of_years INT,
  temperature_kelvin INT,
  mass_solar NUMERIC(10,3),
  is_visible_naked_eye BOOLEAN
);

CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL UNIQUE,
  star_id INT NOT NULL REFERENCES star(star_id),
  planet_type TEXT NOT NULL,
  diameter_km INT,
  orbital_period_days NUMERIC(12,2),
  has_life BOOLEAN,
  is_spherical BOOLEAN
);

CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL UNIQUE,
  planet_id INT NOT NULL REFERENCES planet(planet_id),
  diameter_km INT,
  discovered_year INT,
  orbital_period_days NUMERIC(10,3),
  is_spherical BOOLEAN,
  description TEXT
);

CREATE TABLE comet (
  comet_id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL UNIQUE,
  orbital_period_years NUMERIC(10,2) NOT NULL,
  discovered_year INT,
  nucleus_diameter_km INT,
  is_periodic BOOLEAN,
  description TEXT
);

INSERT INTO galaxy (name, galaxy_type, age_in_millions_of_years, distance_from_earth_mly, has_black_hole) VALUES
('Milky Way', 'Barred Spiral', 13600, 0.00, TRUE),
('Andromeda', 'Spiral', 10000, 2.54, TRUE),
('Triangulum', 'Spiral', 10000, 2.73, FALSE),
('Whirlpool', 'Spiral', 400, 23.00, TRUE),
('Sombrero', 'Lenticular', 9000, 29.30, TRUE),
('Cartwheel', 'Ring', 200, 500.00, FALSE);

INSERT INTO star (name, galaxy_id, star_type, age_in_millions_of_years, temperature_kelvin, mass_solar, is_visible_naked_eye) VALUES
('Sun', 1, 'G-type main sequence', 4600, 5772, 1.000, TRUE),
('Proxima Centauri', 1, 'Red dwarf', 4850, 3042, 0.122, FALSE),
('Alpha Centauri A', 1, 'G-type main sequence', 5300, 5790, 1.100, TRUE),
('Sirius', 1, 'A-type main sequence', 242, 9940, 2.063, TRUE),
('Betelgeuse', 1, 'Red supergiant', 10, 3600, 16.500, TRUE),
('Vega', 1, 'A-type main sequence', 455, 9602, 2.135, TRUE),
('Kepler-186', 1, 'Red dwarf', 4000, 3788, 0.478, FALSE),
('TRAPPIST-1', 1, 'Ultracool dwarf', 7600, 2566, 0.089, FALSE);

INSERT INTO planet (name, star_id, planet_type, diameter_km, orbital_period_days, has_life, is_spherical) VALUES
('Mercury', 1, 'Terrestrial', 4879, 88.00, FALSE, TRUE),
('Venus', 1, 'Terrestrial', 12104, 224.70, FALSE, TRUE),
('Earth', 1, 'Terrestrial', 12742, 365.25, TRUE, TRUE),
('Mars', 1, 'Terrestrial', 6779, 687.00, FALSE, TRUE),
('Jupiter', 1, 'Gas giant', 139820, 4331.00, FALSE, TRUE),
('Saturn', 1, 'Gas giant', 116460, 10747.00, FALSE, TRUE),
('Uranus', 1, 'Ice giant', 50724, 30589.00, FALSE, TRUE),
('Neptune', 1, 'Ice giant', 49244, 59800.00, FALSE, TRUE),
('Proxima b', 2, 'Terrestrial', 14000, 11.19, FALSE, TRUE),
('Kepler-186f', 7, 'Terrestrial', 16000, 129.90, FALSE, TRUE),
('TRAPPIST-1e', 8, 'Terrestrial', 11700, 6.10, FALSE, TRUE),
('TRAPPIST-1f', 8, 'Terrestrial', 13400, 9.21, FALSE, TRUE);

INSERT INTO moon (name, planet_id, diameter_km, discovered_year, orbital_period_days, is_spherical, description) VALUES
('Moon', 3, 3474, NULL, 27.322, TRUE, 'Earth''s only natural satellite'),
('Phobos', 4, 22, 1877, 0.319, FALSE, 'Larger and inner moon of Mars'),
('Deimos', 4, 12, 1877, 1.263, FALSE, 'Smaller and outer moon of Mars'),
('Io', 5, 3643, 1610, 1.769, TRUE, 'Most volcanically active body in the solar system'),
('Europa', 5, 3122, 1610, 3.551, TRUE, 'Icy moon with a subsurface ocean'),
('Ganymede', 5, 5268, 1610, 7.155, TRUE, 'Largest moon in the solar system'),
('Callisto', 5, 4821, 1610, 16.689, TRUE, 'Heavily cratered moon of Jupiter'),
('Titan', 6, 5150, 1655, 15.945, TRUE, 'Has a dense atmosphere and methane lakes'),
('Enceladus', 6, 504, 1789, 1.370, TRUE, 'Icy moon with water geysers'),
('Mimas', 6, 396, 1789, 0.942, TRUE, 'Moon with the large Herschel crater'),
('Rhea', 6, 1527, 1672, 4.518, TRUE, 'Second largest moon of Saturn'),
('Iapetus', 6, 1469, 1671, 79.322, TRUE, 'Two-toned moon of Saturn'),
('Dione', 6, 1123, 1684, 2.737, TRUE, 'Icy moon of Saturn'),
('Titania', 7, 1578, 1787, 8.706, TRUE, 'Largest moon of Uranus'),
('Oberon', 7, 1523, 1787, 13.463, TRUE, 'Outermost major moon of Uranus'),
('Miranda', 7, 472, 1948, 1.413, TRUE, 'Moon with extreme varied terrain'),
('Umbriel', 7, 1169, 1851, 4.144, TRUE, 'Dark moon of Uranus'),
('Ariel', 7, 1158, 1851, 2.520, TRUE, 'Bright moon of Uranus'),
('Triton', 8, 2707, 1846, 5.877, TRUE, 'Largest moon of Neptune with retrograde orbit'),
('Nereid', 8, 340, 1949, 360.136, FALSE, 'Moon of Neptune with eccentric orbit');

INSERT INTO comet (name, orbital_period_years, discovered_year, nucleus_diameter_km, is_periodic, description) VALUES
('Halley''s Comet', 75.32, 1758, 11, TRUE, 'Most famous periodic comet'),
('Hale-Bopp', 2533.00, 1995, 60, TRUE, 'Great comet of 1997'),
('Encke', 3.30, 1786, 5, TRUE, 'Shortest known period of a bright comet');
