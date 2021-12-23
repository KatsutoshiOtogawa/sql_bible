
-- ループを使う場合
-- 順列の計算
-- DECIMAL サポートでやる。
DELIMITER $$
CREATE FUNCTION permutation ( n INTEGER, k INTEGER)
RETURNS BIGINT UNSIGNED DETERMINISTIC
BEGIN
    /**
     * description:
     * example: select permutation(10, 8) -> 720;
    */
    DECLARE ret BIGINT UNSIGNED DEFAULT 1;
    DECLARE i INTEGER DEFAULT (n-k+1);
    WHILE i <= n DO
        -- 0, 1のときは1
        IF i IN (0, 1) THEN
            SET ret = 1;
        ELSE
            SET ret = i * ret;
        END IF;
        SET i = i + 1;
	END WHILE;
    RETURN ret;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION factorial ( n INTEGER )
RETURNS BIGINT UNSIGNED DETERMINISTIC
BEGIN
    /**
     * description:
     * example: select factorial(10) -> 720;
    */
    DECLARE ret BIGINT UNSIGNED DEFAULT 1;
    SET ret = permutation(n, n);
    RETURN ret;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION combination ( n INTEGER, k INTEGER )
RETURNS BIGINT UNSIGNED DETERMINISTIC
BEGIN
    /**
     * description:
     * example: select combination(10, ) -> 720;
    */
    DECLARE ret BIGINT UNSIGNED DEFAULT 1;
    DECLARE l INT DEFAULT k;
    -- nCk = n * (n -1) * ... (n-k+1) / k!
    -- = n! / (n-k)! * k!
    -- nPk / k!
    -- nCkのkが大きかったら計算を簡単にするためにnC(n-k)とする。
    -- nCk = (n-1)C(k-1)+(n-1)C(k)
    IF k >= n-k THEN
        SET l = n-k;
    END IF;
    SET ret = permutation(n, l) / factorial(l);
    RETURN ret;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION binomial ( n INTEGER, k INTEGER, p FLOAT )
RETURNS FLOAT DETERMINISTIC
BEGIN
    /**
     * description: 2項分布のk回.
     * example: select binomial(10, 5, 0.2 ) -> 0.0264241;
    */
    DECLARE ret FLOAT UNSIGNED DEFAULT 1;
    -- P(X=k) = nCk p^k (1-p)^k
    SET ret = combination(n, k) * POWER(p, k) * POWER(1-p, n-k);
    RETURN ret;
END;
$$
DELIMITER ;

-- x_from, x_to で知りたい範囲だけ求める。
-- x_from 0以上, x_to n以下
DELIMITER $$
CREATE PROCEDURE binomial_distribution (n INTEGER, p FLOAT, x_from INTEGER, x_to INTEGER)
BEGIN
    /**
     * description: 2項分布
     * example: CALL binomial_distribution(10, 0.2, 5, 7 ) -> 一時テーブル作成;
     *          SELECT * FROM binomial_distribution_ret -> ２項分布を表示
    */
    -- 結果挿入用テーブル
    -- 二項分布が入る。
    CREATE TEMPORARY TABLE IF NOT EXISTS binomial_distribution_ret (
        k INTEGER
        ,P FLOAT
    );
    -- 初期化
    TRUNCATE TABLE binomial_distribution_ret;
    -- 一時テーブルに結果挿入
    INSERT INTO binomial_distribution_ret (k, P)
    SELECT 
        id - 1
        ,binomial(n, id-1, p)
    FROM (
        SELECT id
        FROM set_for_calc
        -- 0~nまであるので最大n+1通りある
        WHERE id BETWEEN x_from + 1 AND x_to + 1
    ) AS tmp;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION poisson (n INTEGER, k INTEGER,p FLOAT )
RETURNS FLOAT DETERMINISTIC
BEGIN
    /**
     * description: ポアソン分布のk回だけ成功する確率.
     * lambda = np ポアソン分布の期待値
     * example: select poisson(200, 1, 0.002 ) -> 0.268128;
    */
    DECLARE lambda FLOAT DEFAULT (n*p);
    DECLARE ret FLOAT DEFAULT 1;
    -- -- P(X=k) = λ^k e ^ (-k) /k!
    SET ret = POWER(lambda, k) * EXP(-lambda)  / factorial(k);
    RETURN ret;
END;
$$
DELIMITER ;

-- postgresqlには 正規分布は結構ある。
-- normal_rand
-- x_from, to で知りたい範囲だけ求める。
-- x_from 0以上, x_to n以下
DELIMITER $$
CREATE PROCEDURE poisson_distribution (n INTEGER, p FLOAT, x_from INTEGER, x_to INTEGER)
BEGIN
    /**
     * description: ポアソン分布
     * example: CALL poisson_distribution(200, 0.002, 0, 4) -> 一時テーブル作成;
     *          SELECT * FROM poisson_distribution_ret -> ポアソン分布を表示
    */
    -- 結果挿入用テーブル
    -- ポアソン分布が入る。
    CREATE TEMPORARY TABLE IF NOT EXISTS poisson_distribution_ret (
        k INTEGER
        ,P FLOAT
    );
    -- 初期化
    TRUNCATE TABLE poisson_distribution_ret;
    -- 一時テーブルに結果挿入
    INSERT INTO poisson_distribution_ret (k, P)
    SELECT 
        id - 1
        ,poisson(n, id-1, p)
    FROM (
        SELECT id
        FROM set_for_calc
        -- 0~nまであるので最大n+1通りある
        WHERE id BETWEEN x_from + 1 AND x_to + 1
    ) AS tmp;
END;
$$
DELIMITER ;

-- 中心極限定理により、
-- 二項分布を標準正規分布に近似させる。
-- 300 人に聞いて 35%とか。