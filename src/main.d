import std.stdio : writeln, writefln;
import std.range : enumerate;
import std.file : readText;

import script;

void arg(int argc, string argv) {
    writefln("argv[%d] = <%s>", argc, argv);
}

void main(string[] args) {
    arg(0, args[0]);
    foreach (argc, argv; args[1 .. $].enumerate(1)) {
        arg(argc, argv);
        writeln(FORTH(readText(argv)));
    }
    writeln("W: ", script.W);
    writeln("\nD: ", script.D);
}
