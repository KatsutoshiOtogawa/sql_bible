CREATE EXTENSION plv8;

-- 即時実行
DO $$
    plv8.elog(NOTICE, "hello there!");
$$ LANGUAGE plv8;

CREATE FUNCTION factorial ( n INTEGER)
RETURNS INTEGER AS $$
DECLARE
    ret INTEGER;
BEGIN

    ret := permutatioin(n, n);
    RETURN ret;
END;
$$ LANGUAGE plv8;
