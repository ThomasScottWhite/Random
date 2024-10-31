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
(3, 'Faxing Berlin (Piano Acoustica Version)', 105, 4, 1),
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
