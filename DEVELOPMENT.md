# Development

Run `python tools/check_repository.py` with Python 3.12 for source/privacy checks.
The skydiving-training schema and query/trigger file target MySQL. CI creates a
disposable MySQL 8.4 database and loads them there. Never run demo schema or
trigger examples against a live database: the examples insert and delete rows.

library-queries and sales-queries depend on external course schemas/data absent
from this archive. Obtain authorized copies and load them into a disposable local
database before running those queries. These fragments cannot be validated as
complete database applications without their original schemas. No live connection
string, database password, or original personal record is required or committed.
