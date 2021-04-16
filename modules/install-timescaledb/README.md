```
postgres-13 installed with apt-get
vagrant@ubuntu-bionic:~$ sudo find / -maxdepth 5 -type d \( -name "*postgres*" -o -name "pgsql" \)
/var/log/postgresql
/var/cache/postgresql
/var/lib/postgresql
/etc/postgresql-common
/etc/postgresql
/run/postgresql
/run/systemd/generator/postgresql.service.wants
/usr/share/postgresql-common
/usr/share/postgresql
/usr/share/doc/postgresql-common
/usr/share/doc/postgresql-client-13
/usr/share/doc/postgresql-client-common
/usr/share/doc/postgresql-13
/usr/lib/postgresql


postgres-13.2 installed from source
vagrant@ubuntu-bionic:~$ sudo find / -maxdepth 5 -type d \( -name "*postgres*" -o -name "pgsql" \)
/var/lib/postgresql
/usr/local/pgsql
```