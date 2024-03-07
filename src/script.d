module script;

import pegged.grammar;

mixin(grammar(`
    FORTH:
        Syntax  < (Comment)*
        Comment < "#" .+
`));
