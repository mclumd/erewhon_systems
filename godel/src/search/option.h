#ifndef OPTION_H
#define OPTION_H

enum {OPERATOR, METHOD};

class Option {
    int type;

    public:
    Option (int type);
    bool is_operator () const;
    bool is_method () const;
};

#endif
