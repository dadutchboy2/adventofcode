(input =>
    input.split("\n").filter(x => Math.abs((x => x.reduce((y, z, i) =>
        i == 0 ? Math.sign(x[i + 1] - z) : y == Infinity ? y : Math.abs((z - x[i - 1]) * y - 2) <= 1 ? y : Infinity
    , 0))(x.split(" "))) == 1).length
)(`7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9`)