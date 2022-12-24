from google.cloud import bigquery
import os

csv_file_path = './raw_data'
project_dataset = 'analytics-engineer-case-372415.raw_data'

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = './part1_credentials.json'

client = bigquery.Client()

job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.CSV,
    skip_leading_rows=1,
    autodetect=True
)

print("Start ingestion of files from {} to {}".format(csv_file_path, project_dataset))

for csv_file in os.listdir(csv_file_path):

    file_name, file_extension = os.path.splitext(csv_file)
    if file_extension == ".csv":
        table_id = "{}.{}".format(project_dataset, file_name)

        with open(os.path.join(csv_file_path, csv_file), "rb") as file:
            job = client.load_table_from_file(file, table_id, job_config=job_config)

        job.result()
        table = client.get_table(table_id)
        print("Loaded {} rows and {} columns to {}".format(table.num_rows, len(table.schema), table_id))
    else:
        print("Skipping ingestion of file {} (not a csv file)".format(csv_file, csv_file_path))

print("Finish ingestion of csv files from {} to {}".format(csv_file_path, project_dataset))
