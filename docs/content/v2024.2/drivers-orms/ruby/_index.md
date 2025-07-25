---
title: Ruby
headerTitle: Ruby
linkTitle: Ruby
description: Ruby Drivers and ORMs support for YugabyteDB.
menu:
  v2024.2:
    identifier: ruby-drivers
    parent: drivers-orms
    weight: 580
type: indexpage
showRightNav: true
---

## Supported projects

The following projects are recommended for implementing Ruby applications using the YugabyteDB YSQL/YCQL API.

| Driver                          | Documentation and Guides |
|:--------------------------------| :----------------------- |
| YugabyteDB ruby-pg Driver       | [Documentation](yb-ruby-pg/) |
| Ruby-pg Driver                  | [Documentation](ruby-pg/) |
| YugabyteDB Ruby Driver for YCQL | [Documentation](ycql/) </br> [Sample apps](https://github.com/yugabyte/cassandra-ruby-driver) |

| Projects | Documentation and Guides |
| :------- | :----------------------- |
| Active Record ORM | [Documentation](activerecord/) </br> [Sample apps](https://github.com/YugabyteDB-Samples/orm-examples/tree/master/ruby/ror)|

Learn how to establish a connection to a YugabyteDB database and begin basic CRUD operations by referring to [Connect an app](yb-ruby-pg/) or [Use an ORM](activerecord/).

## Prerequisites

To develop Ruby applications for YugabyteDB, you need the following:

- **Ruby**
  - Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) 2.7.0 or later. Verify the ruby version using `ruby -v`.

- **YugabyteDB cluster**
  - Create a free cluster on YugabyteDB Aeon. Refer to [Use a cloud cluster](/preview/tutorials/quick-start-yugabytedb-managed/). Note that YugabyteDB Aeon requires SSL.
  - Alternatively, set up a standalone YugabyteDB cluster by following the steps in [Install YugabyteDB](/preview/tutorials/quick-start/macos/).

## Next step

[Connect an app](yb-ruby-pg)
