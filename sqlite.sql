CREATE TABLE "usuarios" (
    user TEXT PRIMARY KEY NOT NULL,
    password TEXT NOT NULL,
    dominio TEXT NOT NULL DEFAULT 'nomes.space'
);

CREATE TABLE "redirecionamento" (
    de TEXT PRIMARY KEY NOT NULL,
    para TEXT NOT NULL
);

INSERT INTO "usuarios" ('user', 'password') 
    VALUES ('rafael@nomes.space', '$6$ft4o5or8hDjVH8/g$APqd6f7paoDNeOHnkELbNBT./T8jZ1ki7slF5bLQFWJKRpurMAJmw/0OEbOxRWo2hzafpC4R.C5V3D5wAlT980');

INSERT INTO "redirecionamento" ("de", "para")
    VALUES ('root@nomes.space', 'rafael@nomes.space'),
        ('postmaster@nomes.space', 'rafael@nomes.space');