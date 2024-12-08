-- part a
WITH solution AS (
    SELECT
        groupArray(splitByString('', line)) AS grid,
        count() :: Int64 AS "rows",
        length(grid [1]) :: Int64 AS "cols",
        arrayMap(
            (curr_row, x) -> arrayMap(
                (el, y) -> IF(
                    grid [ x ] [ y ] = 'X',
                    (
                        (
                            y + 3 <= "cols"
                            AND grid [ x + 0 ] [ y + 1 ] = 'M'
                            AND grid [ x + 0 ] [ y + 2 ] = 'A'
                            AND grid [ x + 0 ] [ y + 3 ] = 'S'
                        ) + (
                            x + 3 <= "rows"
                            AND y + 3 <= "cols"
                            AND grid [ x + 1 ] [ y + 1 ] = 'M'
                            AND grid [ x + 2 ] [ y + 2 ] = 'A'
                            AND grid [ x + 3 ] [ y + 3 ] = 'S'
                        ) + (
                            x + 3 <= "rows"
                            AND grid [ x + 1 ] [ y + 0 ] = 'M'
                            AND grid [ x + 2 ] [ y + 0 ] = 'A'
                            AND grid [ x + 3 ] [ y + 0 ] = 'S'
                        ) + (
                            x + 3 <= "rows"
                            AND y - 3 >= 1
                            AND grid [ x + 1 ] [ y - 1 ] = 'M'
                            AND grid [ x + 2 ] [ y - 2 ] = 'A'
                            AND grid [ x + 3 ] [ y - 3 ] = 'S'
                        ) + (
                            y - 3 >= 1
                            AND grid [ x - 0 ] [ y - 1 ] = 'M'
                            AND grid [ x - 0 ] [ y - 2 ] = 'A'
                            AND grid [ x - 0 ] [ y - 3 ] = 'S'
                        ) + (
                            x - 3 >= 1
                            AND y - 3 >= 1
                            AND grid [ x - 1 ] [ y - 1 ] = 'M'
                            AND grid [ x - 2 ] [ y - 2 ] = 'A'
                            AND grid [ x - 3 ] [ y - 3 ] = 'S'
                        ) + (
                            x - 3 >= 1
                            AND grid [ x - 1 ] [ y - 0 ] = 'M'
                            AND grid [ x - 2 ] [ y - 0 ] = 'A'
                            AND grid [ x - 3 ] [ y - 0 ] = 'S'
                        ) + (
                            x - 3 >= 1
                            AND y + 3 <= "cols"
                            AND grid [ x - 1 ] [ y + 1 ] = 'M'
                            AND grid [ x - 2 ] [ y + 2 ] = 'A'
                            AND grid [ x - 3 ] [ y + 3 ] = 'S'
                        )
                    ) :: Int64,
                    0 :: Int64
                ),
                curr_row,
                "range"(1 :: Int64, "cols" + 1)
            ),
            grid,
            "range"(1 :: Int64, "rows" + 1)
        ) AS ct_grid,
        arrayReduce(
            'sum',
            arrayMap(xs -> arrayReduce('sum', xs), ct_grid)
        ) AS result,
        1
    FROM
        "table"
)
SELECT
    result
FROM
    solution;

-- part b
WITH solution AS (
    SELECT
        groupArray(splitByString('', line)) AS grid,
        count() :: Int64 AS "rows",
        length(grid [1]) :: Int64 AS "cols",
        arrayMap(
            (curr_row, x) -> arrayMap(
                (el, y) -> IF(
                    grid [ x ] [ y ] = 'A'
                    AND x > 1
                    AND x < "rows"
                    AND y > 1
                    AND y < "cols",
                    (
                        (
                            grid [ x - 1 ] [ y - 1 ] = 'M'
                            AND grid [ x + 1 ] [ y + 1 ] = 'S'
                            AND (
                                (
                                    grid [ x - 1 ] [ y + 1 ] = 'M'
                                    AND grid [ x + 1 ] [ y - 1 ] = 'S'
                                )
                                OR (
                                    grid [ x - 1 ] [ y + 1 ] = 'S'
                                    AND grid [ x + 1 ] [ y - 1 ] = 'M'
                                )
                            )
                        )
                        OR (
                            grid [ x - 1 ] [ y - 1 ] = 'S'
                            AND grid [ x + 1 ] [ y + 1 ] = 'M'
                            AND (
                                (
                                    grid [ x - 1 ] [ y + 1 ] = 'M'
                                    AND grid [ x + 1 ] [ y - 1 ] = 'S'
                                )
                                OR (
                                    grid [ x - 1 ] [ y + 1 ] = 'S'
                                    AND grid [ x + 1 ] [ y - 1 ] = 'M'
                                )
                            )
                        )
                    ) :: Int64,
                    0 :: Int64
                ),
                curr_row,
                "range"(1 :: Int64, "cols" + 1)
            ),
            grid,
            "range"(1 :: Int64, "rows" + 1)
        ) AS ct_grid,
        arrayReduce(
            'sum',
            arrayMap(xs -> arrayReduce('sum', xs), ct_grid)
        ) AS result,
        1
    FROM
        "table"
)
SELECT
    result
FROM
    solution;