create TABLE events(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      uuid TEXT,
      description TEXT,
      start TEXT,
      end TEXT
);

create TABLE eventInstances(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uuid TEXT,
      FOREIGN KEY (parentId) REFERENCES events (id)
                ON DELETE NO ACTION ON UPDATE NO ACTION
      start TEXT,
      end TEXT
);


