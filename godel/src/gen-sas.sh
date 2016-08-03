#!/bin/bash

# pddl_domain_file=$1
# pddl_problem_file=$2

#echo $pddl_domain_file
#echo $pddl_problem_file

domain="blocks"
echo $domain

#prob_size=15
#prob_num=1

echo "translating $domain problems ..."
#./translate/translate.py $pddl_domain_file $pddl_problem_file > translate.out
for prob_size in {10..100..10}
do
	for prob_num in {1..25}
	do	
		./translate/translate.py ../../GDP-test-data/strips/$domain/domains/$domain-domain-pddl.lisp ../../GDP-test-data/strips/$domain/problems/pddl-$domain-${prob_size}-${prob_num}.lisp > translate.out
		mv output.sas ../../GDP-test-data/hgn/$domain/problems/hgn-$domain-$prob_size-$prob_num.lisp.sas
	done
done

