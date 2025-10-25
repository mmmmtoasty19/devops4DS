# Load Data to Database
con <- DBI::dbConnect(duckdb::duckdb(), dbdir = "data/db/my-db.duckdb")
DBI::dbWriteTable(con, "penguin", palmerpenguins::penguins)
DBI::dbDisconnect(con)
