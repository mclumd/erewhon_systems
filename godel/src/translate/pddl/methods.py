from __future__ import print_function

import copy

from . import conditions
from . import effects
from . import pddl_types

class Method(object):
    def __init__(self, name, parameters, goal,
                 precondition, subgoals):
        # assert 0 <= num_external_parameters <= len(parameters)
        self.name = name
        self.parameters = parameters
        # num_external_parameters denotes how many of the parameters
        # are "external", i.e., should be part of the grounded action
        # name. Usually all parameters are external, but "invisible"
        # parameters can be created when compiling away existential
        # quantifiers in conditions.
        # modified the Action class; the below is a class element from there
        # self.num_external_parameters = num_external_parameters
        self.goal = goal
        self.precondition = precondition
        self.subgoals = subgoals
        # self.cost = cost
        # self.uniquify_variables() # TODO: uniquify variables in cost?
    def __repr__(self):
        return "<Method %r at %#x>" % (self.name, id(self))
    def parse(mlist):
        iterator = iter(mlist)
        method_tag = next(iterator)
        assert method_tag == ":method"
        name = next(iterator)
        parameters_tag_opt = next(iterator)
        assert parameters_tag_opt == ":parameters", \
                "expected :parameters option in method"
        parameters = pddl_types.parse_typed_list(next(iterator),
                                                     only_variables=True)
        goal_tag_opt = next(iterator)
        
        assert goal_tag_opt == ":goal", \
                "expected :goal parameter option in method"
        goal = conditions.parse_condition(next(iterator))
        precondition_tag_opt = next(iterator)

        if precondition_tag_opt == ":precondition":
            precondition = conditions.parse_condition(next(iterator))
            precondition = precondition.simplified()
            subgoals_tag = next(iterator)
        else:
            precondition = conditions.Conjunction([])
            subgoals_tag = precondition_tag_opt
        if subgoals_tag == ":subgoals":
            unparsed_subgoals = next(iterator)
            # subgoals now is a list of goal formulae; need to parse each one
            subgoals = []
            for sg in unparsed_subgoals:
                subgoals.append(conditions.parse_condition(sg))
        # the next two lines are from actions.py. Since what we have are
        # subgoals and not effects, they're not relevant
        # try:
        #    cost = effects.parse_effects(effect_list, eff)
        # except ValueError as e:
        #    raise SystemExit("Error in Action %s\nReason: %s." % (name, e))
        for rest in iterator:
            assert False, rest
        return Method(name, parameters, goal,
                      precondition, subgoals)
    parse = staticmethod(parse)
    
    #def dump(self):
    #    print("Name: %s" %self.name)
    #    
    #    print("GOAL: %s" % self.goal.to_str())
    #    
    #    print("PRE:") 
    #    print("%s" % self.precondition.to_str())
    #    
    #    print("SUBGOAL:")
    #    for sg in self.subgoals:
    #        print("--%s" % sg.to_str())
    #        #print("%s" % sg.pretty_print_condition()) 
    
    def dump(self):
        print("%s(%s)" % (self.name, ", ".join(map(str, self.parameters))))
        print("GOAL:")
        self.goal.dump()
        print("Precondition:")
        self.precondition.dump()
        print("Subgoals:")
        for sg in self.subgoals:
            sg.dump()
    
    def uniquify_variables(self):
        self.type_map = dict([(par.name, par.type) for par in self.parameters])
        self.precondition = self.precondition.uniquify_variables(self.type_map)
        for effect in self.effects:
            effect.uniquify_variables(self.type_map)
    def unary_actions(self):
        result = []
        for i, effect in enumerate(self.effects):
            unary_action = copy.copy(self)
            unary_action.name += "@%d" % i
            if isinstance(effect, effects.UniversalEffect):
                # Careful: Create a new parameter list, the old one might be shared.
                unary_action.parameters = unary_action.parameters + effect.parameters
                effect = effect.effect
            if isinstance(effect, effects.ConditionalEffect):
                unary_action.precondition = conditions.Conjunction([unary_action.precondition,
                                                                    effect.condition]).simplified()
                effect = effect.effect
            unary_action.effects = [effect]
            result.append(unary_action)
        return result
    def relaxed(self):
        new_effects = []
        for eff in self.effects:
            relaxed_eff = eff.relaxed()
            if relaxed_eff:
                new_effects.append(relaxed_eff)
        return Action(self.name, self.parameters, self.num_external_parameters,
                      self.precondition.relaxed().simplified(),
                      new_effects)
    def untyped(self):
        # We do not actually remove the types from the parameter lists,
        # just additionally incorporate them into the conditions.
        # Maybe not very nice.
        result = copy.copy(self)
        parameter_atoms = [par.to_untyped_strips() for par in self.parameters]
        new_precondition = self.precondition.untyped()
        result.precondition = conditions.Conjunction(parameter_atoms + [new_precondition])
        result.effects = [eff.untyped() for eff in self.effects]
        return result
    def untyped_strips_preconditions(self):
        # Used in instantiator for converting unary actions into prolog rules.
        return [par.to_untyped_strips() for par in self.parameters] + \
               self.precondition.to_untyped_strips()

    def instantiate(self, var_mapping, init_facts, fluent_facts, objects_by_type):
        """Return a PropositionalMethod which corresponds to the instantiation of
        this method with the arguments in var_mapping. Only fluent parts of the
        conditions (those in fluent_facts) are included. init_facts are evaluated
        while instantiating.
        Precondition must be normalized for this to work.
        Returns None if var_mapping does not correspond to a valid instantiation
        (because it has impossible preconditions or an empty effect list.)"""
        arg_list = [var_mapping[par.name]
                    for par in self.parameters]
        name = "(%s %s)" % (self.name, " ".join(arg_list))

        goal = []
        try:
            self.goal.instantiate(var_mapping, init_facts,
                                          fluent_facts, goal)
        except conditions.Impossible:
            return None

        precondition = []
        try:
            self.precondition.instantiate(var_mapping, init_facts,
                                          fluent_facts, precondition)
        except conditions.Impossible:
            return None
        subgoals = []
        for subgoal in self.subgoals:
            grounded_subgoal = []
            subgoal.instantiate(var_mapping, init_facts, fluent_facts,
                            grounded_subgoal)
            subgoals.append(grounded_subgoal)
        # if effects:
        #     if self.cost is None:
        #         cost = 0
        #     else:
        #         cost = int(self.cost.instantiate(var_mapping, init_facts).expression.value)
        return PropositionalMethod(name, goal, precondition, subgoals)

class PropositionalMethod:
    def __init__(self, name, goal, precondition, subgoals):
        self.name = name
        self.goal = goal
        self.precondition = precondition
        self.subgoals = subgoals
    def dump(self):
        print("%s" % self.name)
        print("Goal:")
        for g in self.goal:
            print("-- %s" % g)
        print("Precondition:")
        for fact in self.precondition:
            print("PRE: %s" % fact)
        print("Subgoals:")
        for sg in self.subgoals:
            print ("--")
            for g in sg:
                print ("---- %s" % g)
