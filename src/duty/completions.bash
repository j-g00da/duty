# Taken and adapted from pyinvoke:
# Copyright (c) 2020 Jeff Forcier.
# All rights reserved.

_complete_duty() {
    local candidates

    # COMP_WORDS contains the entire command string up til now (including # program name).
    # We hand it to Invoke so it can figure out the current context:
    # spit back core options, task names, the current task's options, or some combo.
    candidates=$(duty --complete -- "${COMP_WORDS[@]}")

    # `compgen -W` takes list of valid options & a partial word & spits back possible matches.
    # Necessary for any partial word completions
    # (vs. completions performed when no partial words are present).
    #
    # $2 is the current word or token being tabbed on, either empty string or a
    # partial word, and thus wants to be compgen'd to arrive at some subset of
    # our candidate list which actually matches.
    #
    # COMPREPLY is the list of valid completions handed back to `complete`.
    COMPREPLY=( $(compgen -W "${candidates}" -- $2) )
}


# Tell shell builtin to use the above for completing our invocations.
# * -F: use given function name to generate completions.
# * -o default: when function generates no results, use filenames.
# * positional args: program names to complete for.
complete -F _complete_duty -o default duty
