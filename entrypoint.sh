set -ex
set -o pipefail

navigate_to_build_dir() {
    if [ ! -z $INPUT_SUBDIR ]; then
        cd $INPUT_SUBDIR
    fi
}

does_setup_py_exists() {
    if [ ! -f setup.py ]; then
        echo "setup.py must exist in the directory that is being packaged and published."
        exit 1
    fi
}

does_meta_yaml_exists() {
    if [ ! -f meta.yaml ]; then
        echo "meta.yaml must exist in the directory that is being packaged and published."
        exit 1
    fi
}

upload_conda_package(){
    conda config --set anaconda_upload yes
    anaconda login --username $INPUT_ANACONDAUSERNAME --password $INPUT_ANACONDAPASSWORD
    conda build .
    anaconda logout
}

go_to_build_dir
does_setup_py_exists
does_meta_yaml_exists
upload_conda_package