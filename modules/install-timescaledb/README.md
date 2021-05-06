# install-timescaledb

This folder contains a [Packer Template](https://www.packer.io/docs/templates), [install-timescaledb.hcl](install-timescaledb.hcl), for installing TimescaleDB and its dependencies. [Although the vendor offers Amazon Machine Images](https://docs.timescale.com/timescaledb/latest/how-to-guides/install-timescaledb/self-hosted/ami/installation-ubuntu-ami/#installing-from-an-amazon-ami-ubuntu) ([AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)) there is no support for PostgreSQL 13.  The goal of this template is to offer that functionality but is currently limited to installing the current minor release for the major version. 

```bash
packer build --var region="" --var role_arn="" install-timescaledb.hcl
```


## AMIs

Command that can be used to gather a list of TimescaleDB AMIs sorted by version.

```bash
aws ec2 describe-images --filters "Name=name,Values=TimescaleDB*" \
    | jq '.Images[] | {name: .Name, created: .CreationDate, ami: .ImageId}' \
    | jq --slurp 'sort_by(.name)'
```

Output.

```json
[
  {
    "name": "TimescaleDB  - Ubuntu 16.04 (EBS Backed)",
    "created": "2018-10-05T20:21:28.000Z",
    "ami": "ami-0e2cdf2d8061a2d3d"
  },
  {
    "name": "TimescaleDB 0.12.1 - Ubuntu 16.04 (EBS Backed)",
    "created": "2018-10-05T20:50:39.000Z",
    "ami": "ami-0ecf0cc105d5a8fc0"
  },
  {
    "name": "TimescaleDB 1.0.0 (PostgreSQL 10) - Ubuntu 16.04 (EBS Backed)",
    "created": "2018-10-30T19:53:33.000Z",
    "ami": "ami-014a438a85d918d54"
  },
  {
    "name": "TimescaleDB 1.0.1 (PostgreSQL 10) - Ubuntu 16.04 (EBS Backed)",
    "created": "2018-12-05T16:34:22.000Z",
    "ami": "ami-0e54d580f7b04fc9b"
  },
  {
    "name": "TimescaleDB 1.1.0 (PostgreSQL 10) - Ubuntu 16.04 (EBS Backed)",
    "created": "2018-12-13T21:51:03.000Z",
    "ami": "ami-0e27c2558c9bf4442"
  },
  {
    "name": "TimescaleDB 1.1.1 (PostgreSQL 11) - Ubuntu 16.04",
    "created": "2018-12-20T20:47:59.000Z",
    "ami": "ami-0cb4bfbf018a34808"
  },
  {
    "name": "TimescaleDB 1.1.1 (PostgreSQL 11) - Ubuntu 16.04 (EBS Backed)",
    "created": "2018-12-20T19:26:37.000Z",
    "ami": "ami-0846f6bedc765391d"
  },
  {
    "name": "TimescaleDB 1.1.1 (PostgreSQL 11) [Ubuntu 16.04]",
    "created": "2018-12-20T21:20:17.000Z",
    "ami": "ami-0ab121611cef19a43"
  },
  {
    "name": "TimescaleDB 1.2.0 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-01-29T14:36:07.000Z",
    "ami": "ami-03bb950779cc8550e"
  },
  {
    "name": "TimescaleDB 1.2.1 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-02-11T15:42:32.000Z",
    "ami": "ami-0c81977fdea008f43"
  },
  {
    "name": "TimescaleDB 1.2.2 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-03-14T19:22:23.000Z",
    "ami": "ami-04da20af1bd01eab1"
  },
  {
    "name": "TimescaleDB 1.3.0 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-05-06T19:20:35.000Z",
    "ami": "ami-0f363f7577e1144d8"
  },
  {
    "name": "TimescaleDB 1.3.1 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-06-11T12:04:35.000Z",
    "ami": "ami-01e0b9cfac5628572"
  },
  {
    "name": "TimescaleDB 1.3.2 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-06-24T20:26:58.000Z",
    "ami": "ami-0e39087981bad58ea"
  },
  {
    "name": "TimescaleDB 1.4.0 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-07-18T19:54:16.000Z",
    "ami": "ami-0e0bcd8e978061c9e"
  },
  {
    "name": "TimescaleDB 1.4.1 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-08-01T19:16:39.000Z",
    "ami": "ami-09331aae78b1885e1"
  },
  {
    "name": "TimescaleDB 1.4.2 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-09-11T19:31:58.000Z",
    "ami": "ami-0d863913b36a0336b"
  },
  {
    "name": "TimescaleDB 1.5.0 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-10-31T23:02:07.000Z",
    "ami": "ami-03e1690cb3bf40bf3"
  },
  {
    "name": "TimescaleDB 1.5.1 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2019-11-13T03:03:25.000Z",
    "ami": "ami-0266eceb469592285"
  },
  {
    "name": "TimescaleDB 1.6.0 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2020-01-15T21:27:45.000Z",
    "ami": "ami-04d670853b622d07c"
  },
  {
    "name": "TimescaleDB 1.6.1 (PostgreSQL 11) - Ubuntu 18.04 (EBS Backed)",
    "created": "2020-03-18T19:03:06.000Z",
    "ami": "ami-0032e31c131b98862"
  },
  {
    "name": "TimescaleDB 1.7.0 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2020-04-17T00:17:53.000Z",
    "ami": "ami-00538315eaf820368"
  },
  {
    "name": "TimescaleDB 1.7.1 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2020-05-18T21:45:41.000Z",
    "ami": "ami-0952246bc3c8d007c"
  },
  {
    "name": "TimescaleDB 1.7.2 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2020-07-09T15:46:03.000Z",
    "ami": "ami-068059b09399b88ab"
  },
  {
    "name": "TimescaleDB 1.7.3 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2020-08-28T00:35:43.000Z",
    "ami": "ami-0dd510acfe59a627a"
  },
  {
    "name": "TimescaleDB 1.7.4 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2020-09-10T16:32:35.000Z",
    "ami": "ami-0720718f2ba91ebe0"
  },
  {
    "name": "TimescaleDB 2.0.0 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2020-12-28T18:15:39.000Z",
    "ami": "ami-05f94dc4b55853f2b"
  },
  {
    "name": "TimescaleDB 2.0.1 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2021-01-29T16:00:26.000Z",
    "ami": "ami-00fd91eb722f59b02"
  },
  {
    "name": "TimescaleDB 2.0.2 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2021-02-22T23:24:50.000Z",
    "ami": "ami-08b20f9d62d6ed951"
  },
  {
    "name": "TimescaleDB 2.1.0 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2021-03-01T19:33:14.000Z",
    "ami": "ami-0a6c20673ce0ac8a6"
  },
  {
    "name": "TimescaleDB 2.1.1 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2021-04-02T14:27:08.000Z",
    "ami": "ami-00033e48eecb70042"
  },
  {
    "name": "TimescaleDB 2.2.0 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2021-04-14T23:24:39.000Z",
    "ami": "ami-0313b4bfed0594a99"
  },
  {
    "name": "TimescaleDB 2.2.1 (PostgreSQL 12) - Ubuntu 18.04 (EBS Backed)",
    "created": "2021-05-06T03:37:49.000Z",
    "ami": "ami-076d325bf420e0952"
  }
]
```

## Building From Source

A bash [script](https://github.com/steviecg2/terraform-aws-timescaledb/blob/875c4288b99e7521d23c2a17cf9be75bb65d7415/modules/install-timescaledb/install-timescaledb.sh) was created to install any version PostgreSQL, PostGIS, and TimescaleDB from source but was abandon due to complexities.  What remains in this repository is a [Vagrantfile](https://www.vagrantup.com/docs/vagrantfile), that as of 2021-05-06, will install PostgreSQL 13.2 from source and using `apt-get`. Below is a command that can be used to find directories setup by each installation method along with its output.  


```bash
sudo find / -maxdepth 5 -type d \( -name "*postgres*" -o -name "pgsql" \)
```

Directories when installed from a package 

```
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
```

Directories when installed from source

```
/var/lib/postgresql
/usr/local/pgsql
```