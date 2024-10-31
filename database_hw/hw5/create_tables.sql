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

