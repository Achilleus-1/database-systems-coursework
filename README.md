# Database Systems Coursework

MySQL query collections and a relational skydiving-training database with constraints, joins, aggregates, and triggers.

## Original coursework

- Database Systems

Originally completed at the University of Texas at San Antonio and imported to GitHub later. This repository retains the coursework implementation with documented maintenance fixes and demonstration assets.

**Languages and technologies:** SQL, MySQL.

## Implementation

- Library and sales query exercises using joins, grouping, subqueries, and calculated values.
- A team schema for instructors, students, certifications, sessions, mentorship, and attendance.
- Training/session queries and triggers for jump totals and attendance cleanup.

## Concepts

- Referential integrity, many-to-many associations, aggregation, triggers, and relational modeling.

## Repository layout

| Directory | Contents |
|---|---|
| `library-queries` | Library queries |
| `sales-queries` | Sales and invoice queries |
| `skydiving-training` | Team DDL, sample data, queries, and triggers |

## Running the source

The library and sales queries require their course databases, which are not redistributed. For the team project, run skydiving-training/schema.sql, then queries-and-triggers.sql in a disposable MySQL database. The latter includes INSERT/DELETE demonstration statements.

## Scope and limitations

- The team source is collaborative; anonymized contributor comments remain for attribution.
- The SQL exercises use MySQL-specific functions and DELIMITER syntax.

Only source code, build configuration, and required text inputs are included. Written submissions, assignment instructions, PDFs, videos, generated outputs, binary builds, and private configuration are omitted. Anonymized contributor labels and supplied-code comments retain the distinction between submitted work and scaffolding. No license for course-provided material is inferred.

## Development and reuse

See [DEVELOPMENT.md](DEVELOPMENT.md) for reproducible checks and known archival dependencies, [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidance, and [SECURITY.md](SECURITY.md) for private reports.

Reuse terms and provenance are documented in [NOTICE.md](NOTICE.md) and [LICENSE](LICENSE). The maintenance license does not grant rights to original course or team material.
