(input =>
    (input =>
        input[0].reduce((x, y, i) => 
            x + y[0] * y[1] * (x => x[0] ? x[0][1] : 0)(input[1].filter(x => x[0] == y[0]))
        , 0)
    )(
        input.split("\n").map(x => x.split("   ").map(x => x * 1)).reduce((x, y) => (
            x[0].push(y[0]), x[1].push(y[1]), x
        ), [[], []]).map(x => (z =>
            z.reduce((x, y, i) => (
                y == z[i - 1] ?
                    (x[x.length - 1][1]++, x) :
                    (x.push([y, 1]), x)
            ), [])
        )(x.sort()))
    )
)(`3   4
4   3
2   5
1   3
3   9
3   3`)