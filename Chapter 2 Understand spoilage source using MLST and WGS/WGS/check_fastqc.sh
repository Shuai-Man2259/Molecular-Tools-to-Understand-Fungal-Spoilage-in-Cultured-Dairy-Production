#!/bin/bash

# Directory containing FastQC results
fastqc_dir="/home/sm2259/workdir/Mucor/report"

# Metrics to check for warnings or failures
metrics=("Per base sequence quality" "Adapter Content" "Per base N content")

# Temporary file to store results
tmpfile=$(mktemp)

# Loop through all summary.txt files
for summary_file in $(find "$fastqc_dir" -name "summary.txt"); do
    sample=$(basename $(dirname "$summary_file"))
    needs_trimming=false
    for metric in "${metrics[@]}"; do
        if grep -q -E "FAIL|WARN" "$summary_file" | grep "$metric"; then
            needs_trimming=true
            break
        fi
    done
    if [ "$needs_trimming" = true ]; then
        echo "$sample needs trimming"
        echo "$sample" >> "$tmpfile"
    fi
done

# Display the summary of samples that need trimming
echo "Summary of samples that need trimming:"
cat "$tmpfile"

# Cleanup
rm "$tmpfile"
