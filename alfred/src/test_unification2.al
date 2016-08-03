fif(lexeme(built),
conclusion(call(ac_dag_asserter(_),[]))).

lexeme(built).




/*
fif(and(has(dlex5, dag, dlex5, DAG1),
	has(dlex6, dag, dlex6, DAG2)),
conclusion(need_unify(DAG1, DAG2))).
*/

/*
fif(has(Lex, dag, Lex, DAG1, DAG2),
    conclusion(need_unify(DAG1, DAG2))).
*/

fif(has(Lex, dag, Lex, DAG1, DAG2),
    conclusion(need_subsumes(DAG1, DAG2))).

fif(need_unify(DAG1, DAG2),
conclusion(call(ac_unification_dags(DAG1, DAG2),[DAG1, DAG2]))).

fif(need_subsumes(DAG1, DAG2),
conclusion(call(ac_subsumes(DAG1, DAG2),[DAG1, DAG2]))).

