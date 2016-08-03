#!/bin/bash

for i in {10..100..10}
do
	for j in {1..25}
	do
		mv p${i}_${j}.pddl pddl-blocks-$i-$j.lisp
	done
done
