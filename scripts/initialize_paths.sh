#!/bin/bash

export SPARK_HOME=/home/yannik/spark-3.0.1-bin-hadoop2.7
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/python
export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/yannik/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/yannik/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/yannik/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/yannik/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/home/yannik/.local/bin:$PATH"

INTEL=/home/yannik/intel/
source ${INTEL}/compilers_and_libraries/linux/bin/compilervars.sh intel64


# Based on http://algs4.cs.princeton.edu/linux/

# declare -r ALGS4_DIRECTORY=~/.local/algs4

# get_drjava() {
#     wget http://algs4.cs.princeton.edu/linux/drjava.jar
#     wget http://algs4.cs.princeton.edu/linux/drjava
#     chmod 700 drjava
#     mv drjava bin
# }

# get_libs() {
#     wget http://algs4.cs.princeton.edu/code/algs4.jar
#     wget http://algs4.cs.princeton.edu/linux/javac-algs4
#     wget http://algs4.cs.princeton.edu/linux/java-algs4
#     chmod 700 javac-algs4 java-algs4
#     mv javac-algs4 bin
#     mv java-algs4 bin
# }

# get_checkers() {
#     wget http://algs4.cs.princeton.edu/linux/checkstyle.zip
#     wget http://algs4.cs.princeton.edu/linux/findbugs.zip
#     wget http://algs4.cs.princeton.edu/linux/pmd.zip
#     unzip checkstyle.zip
#     unzip findbugs.zip
#     unzip pmd.zip
#     #wget http://algs4.cs.princeton.edu/linux/checkstyle.xml
#     #for some reason the above link doesn't exist so use
#     #the windows one instead
#     wget http://algs4.cs.princeton.edu/windows/checkstyle.xml
#     wget http://algs4.cs.princeton.edu/linux/findbugs.xml
#     wget http://algs4.cs.princeton.edu/linux/pmd.xml
#     wget http://algs4.cs.princeton.edu/linux/checkstyle-algs4
#     wget http://algs4.cs.princeton.edu/linux/findbugs-algs4
#     wget http://algs4.cs.princeton.edu/linux/pmd-algs4
#     chmod 700 checkstyle-algs4 findbugs-algs4 pmd-algs4
#     mv checkstyle-algs4 bin
#     mv findbugs-algs4 bin
#     mv pmd-algs4 bin
#     mv checkstyle.xml checkstyle-8.5
#     mv findbugs.xml findbugs-3.0.1
#     mv pmd.xml pmd-bin-5.8.1
# }

# print_path_info() {
#     echo 'Add following line to ~/.bash_profile, ~/.profile, or ~/.bashrc:'
#     echo "export PATH=\$PATH:$ALGS4_DIRECTORY/bin"
#     echo "export CLASSPATH=\$CLASSPATH:$ALGS4_DIRECTORY/algs4.jar"
# }

# mkdir "$ALGS4_DIRECTORY"
# cd "$ALGS4_DIRECTORY"
# mkdir bin

# #get_drjava
# get_libs
# get_checkers
# print_path_info

# sed -i "s|INSTALL=.*|INSTALL=$ALGS4_DIRECTORY|" "$ALGS4_DIRECTORY/bin/javac-algs4"
# sed -i "s|INSTALL=.*|INSTALL=$ALGS4_DIRECTORY|" "$ALGS4_DIRECTORY/bin/java-algs4"
# sed -i "s|INSTALL=.*|INSTALL=$ALGS4_DIRECTORY|" "$ALGS4_DIRECTORY/bin/checkstyle-algs4"
# sed -i "s|INSTALL=.*|INSTALL=$ALGS4_DIRECTORY|" "$ALGS4_DIRECTORY/bin/findbugs-algs4"
# sed -i "s|INSTALL=.*|INSTALL=$ALGS4_DIRECTORY|" "$ALGS4_DIRECTORY/bin/pmd-algs4"
# #sed -i "s|jar=.*|jar=$ALGS4_DIRECTORY/drjava.jar|" "$ALGS4_DIRECTORY/bin/drjava"

export QT_STYLE_OVERRIDE=kvantum
export PATH=$PATH:$HOME/.local/algs4/bin
export CLASSPATH=$CLASSPATH:$HOME/.local/algs4/algs4.jar

# for pycharm
export PATH=$PATH:$HOME/pycharm-2020.2.2/bin

#aws
export AWS_CONFIG_FILE=$HOME/.aws/config
