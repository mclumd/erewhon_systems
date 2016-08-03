#include "globals.h"
#include "operator.h"
#include "option_parser.h"
#include "ext/tree_util.hh"
#include "timer.h"
#include "utilities.h"
#include "search_engine.h"
#include "gdp_search.h"
#include "lisp_interface.h"
#include <pstream.h>

#include <iostream>
#include <fstream>
#include <sstream>
#include <time.h>
using namespace std;



int main(int argc, const char **argv) {

    register_event_handlers();

    if (argc < 2) {
        cout << OptionParser::usage(argv[0]) << endl;
        exit(1);
    }

    if (string(argv[1]).compare("--help") != 0)
        read_everything(cin);

    SearchEngine *engine = 0;

    time (&start_timer);

    //Timer search_timer;
    //cout << "start time: " << search_timer () << endl;
    //the input will be parsed twice:
    //once in dry-run mode, to check for simple input errors,
    //then in normal mode
    try {
        OptionParser::parse_cmd_line(argc, argv, true);
        engine = OptionParser::parse_cmd_line(argc, argv, false);
    } catch (ParseError &pe) {
        cout << pe << endl;
        exit(1);
    }

    
    cout << "about to initialize GDP search engine" << endl;
    GDPSearch *gdp_search_engine = new GDPSearch();
    gdp_search_engine->initialize();

    //gdp_search_engine->lisp_server_interface->send_msg_to_server ("hi!\n");
    //gdp_search_engine->lisp_server_interface->unlink_socket ();
    //exit (0);
    
    // cout << "testing output() in plstate now" << endl;
    // ofstream lisp_problem("prob");
    // g_plstate->dump (); 
    // g_plstate->output (lisp_problem);
    // write_lisp_problem (g_goal, lisp_problem);
    // lisp_problem.close(); 

    // run a process and create a streambuf that reads its stdout and stderr
    /*
    stringstream command;
    command << "alisp -#! trunk/get-bindings.lisp " << 
        "../../benchmarks/logistics00/methods.pddl " << 
        "prob " <<
        "bindings.out";
    cout << command.str(); 
    */

    /*
    cout << "trying to execute the lisp command" << endl;
    redi::ipstream proc("pwd", redi::pstreams::pstderr);
    string line;
    // read child's stdout
    while (getline(proc.out(), line))
        cout << "stdout: " << line << 'n';
    // read child's stderr
    while (getline(proc.err(), line))
        cout << "stderr: " << line << 'n';
    */

    
    if (gdp_search_engine->solve()) {
        const Plan &p = gdp_search_engine->get_plan ();
        //search_timer.stop ();
        //cout << "end time: " << search_timer () << endl;
        //cout << "search time: " << search_timer << endl;

        //time_t end_timer;
        time (&end_timer);

        //cout << "Wall clock time taken by program: " << difftime (end_timer, start_timer) << "s" << endl;

        /*
        State init_state_test (*g_initial_state);
        int plan_length = 0;
        cout << "\nSolution plan is:" << endl;
        for (int i = 0; i < p.size(); i++) {
            if (p[i]->is_operator()) {
                plan_length++;
                cout << "-- " << ((Operator *)p[i])->get_name () << endl;
                init_state_test.progress_state (*((Operator *)p[i]));
            }
            // else  
            //    cout << "-- " << ((Method *)p[i])->get_name () << endl;
        }

        if (test_goal (init_state_test)) {
            cout << "SUCCESS : final state satisfies goal!" << endl;
            cout << "Plan length: " << plan_length << endl;
        }
        else
            cout << "FAILURE : final state does not satisfy goal!" << endl;
        
        cout << "Lisp time:" << g_lisp_timer << "s" << endl;
        cout << "GDP time: " << g_gdp_timer << endl;
        cout << "Total time: " << g_lisp_timer + g_gdp_timer() << "s" << endl;
        */
        save_gdp_plan (p);
    }



    //cout << "returns from solve\n" << endl;
    

    gdp_search_engine->lisp_server_interface->unlink_socket ();
    exit(0);

    Timer search_timer2;
    engine->search();
    search_timer2.stop();
    g_timer.stop();

    engine->save_plan_if_necessary();
    engine->statistics();
    engine->heuristic_statistics();
    cout << "Search time: " << search_timer2 << endl;
    cout << "Total time: " << g_timer << endl;

    cout << "found solution? " << engine->found_solution() << endl;

    return engine->found_solution() ? 0 : 1;
}
