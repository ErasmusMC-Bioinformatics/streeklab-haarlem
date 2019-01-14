# MYcrobiota pipelines

## Installation


Galaxy version 16.10+ will not load workflow menu in many cases.

### Tools

Use ephemeris `workflow-to-tools` command to generate tools.yaml file from latest workflow.

**xy_plot tool**

Needs some small local fixes

- Replace the tool xml installed via the toolshed with the `xy_plot.xml` file included in this folder.
- TODO: push change upstream repo and replace tool in workflow


### Reference data

- Copy the loc files from the `reference` folder in this repo to Galaxy `tool-data` directory.
- Datasets can be found on Zenodo [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.2539387.svg)](https://doi.org/10.5281/zenodo.2539387)

https://zenodo.org/record/2539387


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
