# MYcrobiota pipelines

## Installation


Galaxy version 16.10+ will not load workflow menu in many cases.

### Tools

Use ephemeris `workflow-to-tools` command to generate tools.yaml file from latest workflow.

- xy-plot tool needs some small local fixes (TODO)

### Reference data

TODO

## Testing

Test datasets in folder `test-data`. Make a single list of pairs collection in Galaxy with all the test files. Do not change the input file names, the naming scheme is important (`<sample name>_replicate[0-9]+_.*_R[12]_.*\.fastq`)

Workflow variables:

- Sample name: <any string>
- Negative control sample: `NC181127049751`
- copies in NC:
- copies in samples:

Workflow inputs:

- Oligos file: `test-data/V4_1361-1362_illumina.mothur.oligos`
- Paired Collection: created from rest of the files `test-data` folder
