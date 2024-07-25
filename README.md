# Hoisting-Anticipated-Expressions

## Code for hoisting anticipated expression data at function-level.

- How to build and run :-
    - Clone LLVM project from github and switch to branch with commit-id :- f08d86fc7f4479d5f44d75c720201334682075b8
    - As it's not an out-of-tree pass, build the entire LLVM, which will automatically register the pass (As part of Transformations).

- Challenges Faced :-
    - My current approach requires an DFS traversal from the current basic block, after finding out if there are any expression that can be hoisted othwerwise it may choose a wrong expression to hoist. This is the limitation of this approach, which is due to how I am creating and comparing 2 different expression which are same that needs to behoisted. If this Expression class (used for creating and comparing 2 different expressions) can be refined, the DFS traversal can be omitted.