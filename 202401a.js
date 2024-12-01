(input =>
    (input =>
        input[0].reduce((n, x, i) => n + Math.abs(x - input[1][i]), 0)
    )(
        input.split("\n").map(x => x.split("   ")).reduce((x, y) => (
            x[0].push(y[0]), x[1].push(y[1]), x
        ), [[], []]).map(x => x.sort())
    )
)(`3   4
4   3
2   5
1   3
3   9
3   3`)