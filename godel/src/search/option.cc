#include "option.h"

Option::Option (int x) {
    type = x;
}

bool Option::is_operator () const {
    return type == OPERATOR;
}

bool Option::is_method () const {
    return type == METHOD;
}
