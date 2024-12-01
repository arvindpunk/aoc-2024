--part a
SELECT
    arraySum(
        arrayMap(
            (x, y) -> abs(x - y),
            arrayZip(
                (
                    SELECT
                        arraySort(
                            groupArray(toInt64(extractAll(line, '[0-9]+') [1]))
                        )
                    FROM
                        "table"
                ),
                (
                    SELECT
                        arraySort(
                            groupArray(toInt64(extractAll(line, '[0-9]+') [2]))
                        )
                    FROM
                        "table"
                )
            )
        )
    );

-- part b
SELECT
    sum(similarity)
FROM
    (
        WITH frequency_map AS (
            SELECT
                arrayFold(
                    (acc, curr) -> mapAdd(acc, curr),
                    groupArray(
                        map(
                            toInt64(extractAll(line, '[0-9]+') [2]),
                            toInt64(1)
                        )
                    ),
                    CAST(([], []), 'Map(Int64, Int64)')
                )
            FROM
                "table"
        )
        SELECT
            toInt64(extractAll(line, '[0-9]+') [1]) AS left,
            left * (
                SELECT
                    *
                FROM
                    frequency_map
            ) [left] AS similarity
        FROM
            "table"
    )