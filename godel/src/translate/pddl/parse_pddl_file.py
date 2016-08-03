import sys
import parser

def print_literal_to_file (literal, f):
    for x in literal:
        f.write (x + " ")
    f.write("\n")

def print_goal_literal_to_file (literal, f):
    f.write ("goal")
    for x in literal:
        f.write (" " + x)
    f.write("\n")

def literal_to_str (literal):
    str = ""
    if literal[0] == "not":
        str += "not "
        true_literal = literal[1]
    else:
        true_literal = literal
    for x in true_literal:
        str += x + " "
    return str

# Basic functions for parsing PDDL (Lisp) files.
def parse_nested_list_sequence (input_file):
    result = []
    tokens = parser.tokenize(input_file)
    # print ("tokens seen are %s" % tokens)
    while True:
        try:
            next_token = next(tokens)
        except StopIteration: # generator is exhausted
            return result
        print ("token seen is %s" % next_token)
        if next_token != "(":
            raise parser.ParseError("Expected '(', got %s." % next_token)
        result.append(list(parser.parse_list_aux(tokens)))
        # print ("after parsing, result is %s" %result)

if __name__ == "__main__":
    # print sys.argv[1]
    inp = open (sys.argv[1], 'r') # pddl file
    inp_m = open (sys.argv[2], 'r') # method file
    out = open (sys.argv[3], 'a') # output file

    # parse pddl file
    # out.write("begin_plstate\n")
    result = parser.parse_nested_list(inp)
    print result

    # now traverse result
    plstate_count = 0
    pddl_str = ""
    for part in result:
        # print part
        if part[0] == ":init":

            for i in range(1, len(part)):
                pddl_str += literal_to_str (part[i]) + "\n"
                plstate_count += 1
                # for term in part[i]:
                #     out.write (term + " ")
                # out.write ("\n")
        elif part[0] == ":goal":
            if part[1][0] == "and":
                # print "conjunction!"
                for i in range(1, len(part[1])):
                    pddl_str += "goal "
                    pddl_str += literal_to_str (part[1][i]) + "\n"
                    plstate_count += 1
                    # out.write("goal")
                    # for term in part[1][i]:
                    #     out.write (" " + term)
                    # out.write ("\n")
            else:
                for i in range(1, len(part)):
                    pddl_str += "goal "
                    pddl_str += literal_to_str (part[i]) + "\n"
                    plstate_count += 1
                    # out.write("goal")
                    # for term in part[i]:
                    #     out.write (" " + term)
                    # out.write ("\n")
    pddl_str += "end_plstate\n"
    out.write ("begin_plstate\n")
    out.write (str(plstate_count) + "\n")
    out.write (pddl_str)
    # now parse method file
    
    result2 = parse_nested_list_sequence (inp_m)
    print result2
    
    # parsing result2
    for part in result2:
        if part[0] == "defdomain":
            gdrs = part[2]
            gdr_strings = []
            gdr_count = 0
            for gdr in gdrs:
                if gdr[0] == ":gdr": # its a method, not axiom
                    gdr_count += 1
                    
                    index = 1
                    gdr_str = "begin_lifted_method\n"

                    # handling name and args
                    name_and_args = gdr[index]
                    gdr_str += name_and_args[0] + "\n"
                    gdr_str += str(len(name_and_args) - 1) + "\n"
                    for i in range(1, len(name_and_args)):
                        gdr_str += name_and_args[i] + "\n"

                    index += 1
                    #goal
                    goal = gdr[index]
                    gdr_str += str(len(goal)) + "\n"
                    for x in range (0, len(goal)):
                        gdr_str += literal_to_str (goal[x]) + "\n"
                    
                    index += 1
                    # preconditions
                    pre = gdr[index]
                    gdr_str += str(len(pre)) + "\n"
                    for x in range (0, len(pre)):
                        gdr_str += literal_to_str (pre[x]) + "\n"

                    index += 1
                    #subgoals
                    subs = gdr[index]
                    gdr_str += str(len(subs)) + "\n"
                    for sub in subs:
                        gdr_str += str(len(sub)) + "\n"
                        for term in sub:
                            gdr_str += literal_to_str (term) + "\n"

                    gdr_str += "end_lifted_method\n"
                    print gdr_str
                    gdr_strings.append(gdr_str)
    
    out.write(str(len(gdr_strings)) + "\n")
    for s in gdr_strings:
        out.write(s)
