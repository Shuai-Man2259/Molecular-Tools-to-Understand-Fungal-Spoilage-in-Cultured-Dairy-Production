import zipfile
import os
import pandas as pd

# Define the directory containing FastQC zip files
fastqc_dir = '/home/sm2259/workdir/Mucor/raw/zip'  # Change to your path
output_summary_file = 'fastqc_summary.csv'

# List to hold quality check summaries
quality_summaries = []

# Iterate over each zip file in the directory
for zip_filename in os.listdir(fastqc_dir):
    if zip_filename.endswith(".zip"):
        # Define the path to the zip file
        zip_path = os.path.join(fastqc_dir, zip_filename)
        
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            # Extract the summary.txt file from the zip archive
            for file in zip_ref.namelist():
                if 'summary.txt' in file:
                    summary = zip_ref.read(file).decode('utf-8')
                    sample_name = zip_filename.replace('_fastqc.zip', '')
                    
                    # Parse the summary.txt content
                    for line in summary.strip().split('\n'):
                        status, test, _ = line.split('\t')
                        if test in ['Per base sequence quality', 'Adapter Content']:
                            quality_summaries.append({
                                'Sample': sample_name,
                                'Test': test,
                                'Status': status
                            })

# Convert the list of dictionaries to a DataFrame
quality_df = pd.DataFrame(quality_summaries)

# Save the summary DataFrame to a CSV file
quality_df.to_csv(output_summary_file, index=False)

print(f'Summary saved to {output_summary_file}')
