module script;

import pegged.grammar;

import std.uni : toLower;
import std.range : empty;
import std.stdio : writeln;

class Obj {
    string value;
    uint rc;
    this() {
        rc = 0;
    }

    this(string V) {
        this();
        value = V;
    }

    string tag() {
        return typeof(this).stringof.toLower;
    }

    string val() {
        return value;
    }

    override string toString() {
        return "<" ~ tag() ~ ':' ~ val() ~ ">";
    }
}

class Prim : Obj {
}

class Container : Obj {
    this(string V) {
        super(V);
    }
}

class Stack : Container {
    this(string V) {
        super(V);
    }
}

Obj[] D; ///< data stack

class Map : Container {
    this(string V) {
        super(V);
    }
}

Obj[string] W; ///< @ref words vocabulary

class Active : Obj {
    this(string V) {
        super(V);
    }
}

/// VM command
class Cmd : Active {
    void function() fn;
    this(string V, void function() F) {
        super(V);
        fn = F;
    }
}

/// `( -- )` empty command: do nothing
void nop() {
}

static this() {
    W["nop"] = new Cmd("nop", &nop);
}

/// `. ( ... -- )` drop all from stack
void dot() {
    D.empty;
}

static this() {
    W["."] = new Cmd(".", &dot);
}

@trusted ParseTree word(ParseTree p) {
    if (p.successful) {
        auto key = p.matches[0];
        if (key in W)
            writeln(W[key]);
        else
            p.successful = false;
    }
    return p;
}

mixin(grammar(`
    FORTH:
        Syntax  <- (Comment|space|Word)*
        Comment <: '#' (![\r\n] .)*
        space   <: [ \t\r\n]+
        Word    <{word} ~([_a-zA-Z][_a-zA-Z0-9]*)
`));
