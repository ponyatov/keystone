import std.stdio;
import std.range : enumerate;

void main(string[] args) {
    foreach (argc, argv; args.enumerate(0))
        writefln("argv[%d] = <%s>", argc, argv);
}
