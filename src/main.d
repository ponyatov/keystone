import std.stdio : writefln;
import std.range : enumerate;

void arg(int argc, string argv) {
    writefln("argv[%d] = <%s>", argc, argv);
}

void main(string[] args) {
    foreach (argc, argv; args.enumerate(0))
        arg(argc, argv);
}
