-- Create Tables
CREATE TABLE IF NOT EXISTS Label (
    lid INTEGER PRIMARY KEY,
    lname TEXT NOT NULL CHECK (length(lname) <= 80),
    labbr TEXT NOT NULL CHECK (length(labbr) <= 5)
);
CREATE TABLE IF NOT EXISTS Artists (
    aid INTEGER PRIMARY KEY,
    aname TEXT NOT NULL CHECK (length(aname) <= 80)
);
CREATE TABLE IF NOT EXISTS Releases (
    rid INTEGER PRIMARY KEY,
    rtitle TEXT NOT NULL CHECK (length(rtitle) <= 80),
    year INTEGER NOT NULL CHECK (year >= 1900),
    aid INTEGER NOT NULL,
    FOREIGN KEY (aid) REFERENCES Artists(aid)
);

CREATE TABLE IF NOT EXISTS Songs (
    sid INTEGER PRIMARY KEY,
    stitle TEXT NOT NULL CHECK (length(stitle) <= 80),
    duration INTEGER NOT NULL CHECK (duration > 0),
    remix_of INTEGER,
    artist INTEGER NOT NULL,
    FOREIGN KEY (remix_of) REFERENCES Songs(sid),
    FOREIGN KEY (artist) REFERENCES Artists(aid)
);

CREATE TABLE IF NOT EXISTS Rerelease (
    cat_number TEXT,
    rid INTEGER,
    upc TEXT CHECK (length(upc) <= 12),
    label INTEGER NOT NULL,
    year INTEGER NOT NULL CHECK (year >= 1900),
    medium TEXT NOT NULL CHECK (medium IN ('CD', 'Web', 'LP', '45', 'Tape')),

    PRIMARY KEY (cat_number, rid),
    FOREIGN KEY (label) REFERENCES Label(lid)
);


CREATE TABLE IF NOT EXISTS AlbumTrack (
    rid INTEGER,
    cat_number INTEGER,
    sid INTEGER,
    trackno INTEGER,
    PRIMARY KEY (cat_number, rid, sid),
    FOREIGN KEY (rid) REFERENCES Releases(rid),
    FOREIGN KEY (sid) REFERENCES Songs(sid)
);





-- Insert Into Tables
INSERT INTO Label (lid, lname, labbr) VALUES
(1, 'Ultra Records', 'UL'),
(2, 'mau5trap', 'MAU');

INSERT INTO Artists (aid, aname) VALUES
(1, 'deadmau5');

INSERT INTO Releases (rid, rtitle, year, aid) VALUES
(1, 'Random Album Title', 2008, 1);

INSERT INTO Rerelease (cat_number, rid, upc, label, year, medium) VALUES
('UL 1868-2', 1, '617465186820', 1, 2008, 'CD'),
('MAUSRAT', 1, NULL, 2, 2016, 'Web');

INSERT INTO Songs (sid, stitle, duration, remix_of, artist) VALUES
(1, 'Brazil (2nd Edit)', 323, NULL, 1),
(2, 'I Remember', 548, NULL, 1),
(3, 'Faxing Berlin (Piano Acoustica Version)', 105, 1, 1),
(4, 'Faxing Berlin', 150, NULL, 1);

INSERT INTO AlbumTrack (rid, cat_number, sid, trackno) VALUES
(1, 'UL 1868-2', 1, 5),
(1, 'UL 1868-2', 2, 7),
(1, 'UL 1868-2', 3, 8),
(1, 'UL 1868-2', 4, 9),
(1, 'MAUSRAT', 1, 5),
(1, 'MAUSRAT', 2, 7),
(1, 'MAUSRAT', 3, 8),
(1, 'MAUSRAT', 4, 9);

-- Select All to show what tables look like
SELECT * FROM Label;
SELECT * FROM Artists;
SELECT * FROM Releases;
SELECT * FROM Rerelease;
SELECT * FROM Songs;
SELECT * FROM AlbumTrack;

-- 2008 songs from Ultra Records
SELECT s.stitle
FROM Songs s
JOIN AlbumTrack at ON s.sid = at.sid
JOIN Rerelease rr ON at.cat_number = rr.cat_number
JOIN Label l ON rr.label = l.lid
WHERE rr.year > 2008
  AND l.lname = 'Ultra Records';

-- Each rerelease title, year, album amount
SELECT r.rtitle, rr.year, COUNT(at.sid) AS album_track_count
FROM Rerelease rr
JOIN AlbumTrack at ON rr.cat_number = at.cat_number
JOIN Releases r ON rr.rid = r.rid
GROUP BY rr.cat_number, rr.year;

--  Runtime of each rerelease with catno
SELECT r.rtitle, rr.cat_number, SUM(s.duration) AS total_duration
FROM Rerelease rr
JOIN AlbumTrack at ON rr.cat_number = at.cat_number
JOIN Songs s ON at.sid = s.sid
JOIN Releases r ON rr.rid = r.rid
GROUP BY rr.cat_number, r.rtitle;

-- Each remix song, title, duration, artistname, title, and original artist
SELECT remix.stitle AS remix,
       remix.duration,
       remix_artist.aname AS remixing_artist,
       original.stitle AS original,
       original_artist.aname AS original_artist
FROM Songs remix
JOIN Artists remix_artist ON remix.artist = remix_artist.aid
JOIN Songs original ON remix.remix_of = original.sid
JOIN Artists original_artist ON original.artist = original_artist.aid
WHERE remix.remix_of IS NOT NULL;

-- Drop tables in proper order
DROP TABLE IF EXISTS AlbumTrack;
DROP TABLE IF EXISTS Rerelease;
DROP TABLE IF EXISTS Releases;
DROP TABLE IF EXISTS Songs;
DROP TABLE IF EXISTS Label;
DROP TABLE IF EXISTS Artists;

