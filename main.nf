#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process run_fastqc {
    input:
    file input_file from channel_fastqc_files

    output:
    file "fastqc_run/*" into fastqc_output

    """
    ./run_fastqc.sh ${input_file}
    """
}

process merge_reports {
    input:
    file fastqc_results from fastqc_output

    output:
    file "multiqc_run/*" into merge_output

    """
    ./merge_raports.sh ${fastqc_results}
    """
}

process run_trimmomatic {
    input:
    file input_file from channel_fastqc_files

    output:
    file "trimm_data/*" into trimmomatic_output

    """
    ./run_trimmomatic.sh ${input_file}
    """
}

process run_alignment {
    input:
    file "trimm_data/paired_*" from trimmomatic_output

    output:
    file "bam_data/*" into alignment_output

    """
    ./run_alignment.sh ${trimmed_data}
    """
}

process run_samtools {
    input:
    file alignment_results from alignment_output

    """
    ./run_samtools.sh ${alignment_results}
    """
}

workflow {
    channel_fastqc_files = Channel.fromPath('data/*.f*')

    fastqc_output = run_fastqc(channel_fastqc_files)
    merge_output = merge_reports(fastqc_output)

    if (askContinue("Do you want to continue after merging reports?")) {
        trimmomatic_output = run_trimmomatic()
        if (askContinue("Do you want to start from the beginning after running trimmomatic?")) {
            fastqc_output = run_fastqc(channel_fastqc_files)
            merge_output = merge_reports(fastqc_output)
            trimmomatic_output = run_trimmomatic()
            alignment_output = run_alignment(trimmomatic_output)
            run_samtools(alignment_output)
        } else {
            alignment_output = run_alignment(trimmomatic_output)
            run_samtools(alignment_output)
        }
    }
}

def askContinue(String message) {
    println(message + " (yes/no)")
    def response = System.console().readLine()
    return response.toLowerCase() == 'yes'
}

