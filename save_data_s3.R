# This writes palmer penguins to S3, instead of using a local DB
arrow::write_parquet(
  palmerpenguins::penguins, 
  "s3://do4ds-lab-kyle/data/penguins.parquet"
)
