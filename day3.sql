-- part a
WITH data AS (
    SELECT
        arrayJoin(
            extractAllGroupsVertical(line, 'mul\((\d{1,3}),(\d{1,3})\)')
        ) AS pairs
    FROM
        "table"
)
SELECT
    sum(toInt64(pairs [1]) * toInt64(pairs [2]))
FROM
    data;

-- part b
WITH data AS (
    SELECT
        extractAllGroupsVertical(
            arrayFold(
                (acc, curr) -> concat(acc, curr),
                groupArray(line),
                ''
            ),
            '(?:(do)\(\)|(don)\'t\(\)|mul\((\d{1,3}),(\d{1,3})\))\'?'
        ) AS pairs
    FROM
        "table"
)
SELECT
    arrayFold(
        (acc, curr) -> (
            acc.1 + acc.2 * (
                toInt64OrZero(curr [3]) * toInt64OrZero(curr [4])
            ),
            multiIf(curr [1] = 'do', 1, curr [2] = 'don', 0, acc.2)
        ),
        pairs,
        (0 :: Int64, 1 :: Int64)
    ).1
FROM
    data;