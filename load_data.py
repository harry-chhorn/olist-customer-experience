# load_data.py
# Builds the data/olist.duckdb database from the raw CSV

from pathlib import Path
import duckdb

RAW_DIR = Path("data/raw")
DB_PATH = "data/olist.duckdb"

files = sorted(RAW_DIR.glob("*.csv"))

if not files:
    raise SystemExit(f"No CSV files found in {RAW_DIR}, Download it in Kaggle")

con = duckdb.connect(DB_PATH)

for path in sorted(RAW_DIR.glob("*.csv")):
    name = path.stem.replace("olist_","").replace("_dataset", "")
    con.execute(f"CREATE OR REPLACE TABLE {name} AS SELECT * FROM read_csv('{path}')")
    row = con.execute(f"SELECT COUNT(*) FROM {name}").fetchone()[0]
    print(f"{name}: {row:,} rows")

con.close()
