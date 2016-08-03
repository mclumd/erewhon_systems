#!/bin/bash

pddl_domain_file=$1
pddl_problem_file=$2
methods_file=$3
alisp_path="/usr/local/allegrocommonlisp-8.2/alisp"

echo $pddl_domain_file
echo $pddl_problem_file
echo $methods_file

echo "opening lisp server ..."
cd search
$alisp_path -#! get-bindings-using-sockets.lisp ../$methods_file &
cd ..
sleep 1 # hack to introduce some latency for server to set up

echo "translating ..."
./translate/translate.py $pddl_domain_file $pddl_problem_file > translate.out

echo "preprocessing ..."
./preprocess/preprocess < output.sas > preprocess.out

python translate/pddl/parse_pddl_file.py $pddl_problem_file $methods_file output
echo $methods_file | tee -a output

echo "searching ..."
cd search
./downward ipc seq-sat-lama-2011 < ../output > search.out
