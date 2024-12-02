((input, check) =>
    input.split("\n").filter(x =>
        (x =>
            check(x) || x.some((y, i) =>
                check(x.toSpliced(i, 1))
            )
        )(x.split(" "))
    ).length
)(`7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9`, x =>
    Math.abs(x.reduce((y, z, i) =>
        i == 0 ?
            Math.sign(x[i + 1] - z) :
        y == Infinity ? y :
        Math.abs((z - x[i - 1]) * y - 2) <= 1 ? y :
        Infinity
    , 0)) == 1)