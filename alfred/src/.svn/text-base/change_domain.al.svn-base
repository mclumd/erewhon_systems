/*Template for adding a domain to Alfred.*/
/*Step 1: Replace "domainID_" with the new domain ID.*/
/*Step 2: Replace "languageID_" with the new domain language ID.*/
/*Step 3: Make Categories -
          Make a list of every terminal element's category_name.
          Create a category ID number for each category_name.
          Copy the "Make category" text below once for each
              category ID and name pair, inserting the new ID 
              and new name_ into each copy.*/
/*Step 4: Lexical Entry -
          Works for both English and Domain language.
          A) For each new lexeme, make/find:
                        lexemeID_
                        domainID_ (English or domain)
                        string_value_ (the actual string value of the word)
                        meaningID_ 
                        meaning_type_ (predicate, constant, or relation)
          B) make copies of "Lexical Entry" text for each lexeme, inserting
             IDs, etc.*/
/*Step 5: Phrase Structure Rules:
          Currently two different sets of rule templates because of a 
          predicate name difference.
          A) for each new PS rule, make/find:
                        languageID_
                        ruleID_
                        X (symbol on left hand side of rule)
                        Y (symbols on right hand side of rule in a list)
*/


/*Begin copy for insertion into main.al*/

/*Build a domain.*/
isa(null, domain, domainID_).

/*Build a language.*/
isa(domainID_, language, languageID_).
has(domainID_, language, domainID_, languageID_).
isa(languageID_, roverese, languageID_).

/*Make categories*/
/*category_name_*/
isa(languageID_, category, categoryID_).
has(languageID_, category, languageID_, categoryID_).
isa(languageID_, category_name_, categoryID_).

/*Lexical Entry*/
/*string_value_*/
do_add_lexeme(lexemeID_, domainID_, string_value_, categoryID_, meaningID_, meaning_type_).


/*Domain phrase structure rules.*/
/*X -> Y*/
isa(languageID_, domain_syntax_rule, ruleID_).
has(languageID_, domain_syntax_rule, languageID_, ruleID_).
has(languageID_, left_hand_side, ruleID_, X).
has(languageID_, right_hand_side, ruleID_, [Y]).

/*English phrase structure rules.*/
/*X --> Y*/
isa(languageID_, cfg_rule, ruleID_).
has(languageID_, cfg_rule, languageID_, ruleID_).
has(languageID_, left_hand_side, ruleID_, X).
has(languageID_, right_hand_side, ruleID_, [Y]).

/*End copy for insertion into main.al*/
