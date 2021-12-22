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

CREATE FUNCTION zenkaku2hankakukana (a CHAR)
RETURNS VARCHAR(2) AS $$
DECLARE
    ret VARCHAR(2);
BEGIN

    CASE a
        -- ア行
        WHEN 'ア' THEN
            ret := 'ｱ';
        WHEN 'イ' THEN
            ret := 'ｲ';
        WHEN 'ウ' THEN
            ret := 'ｳ';
        WHEN 'エ' THEN
            ret := 'ｴ';
        WHEN 'オ' THEN
            ret := 'ｵ';
        -- カ行
        WHEN 'カ' THEN
            ret := 'ｶ';
        WHEN 'キ' THEN
            ret := 'ｷ';
        WHEN 'ク' THEN
            ret := 'ｸ';
        WHEN 'ケ' THEN
            ret := 'ｹ';
        WHEN 'コ' THEN
            ret := 'ｺ';
        -- サ行
        WHEN 'サ' THEN
            ret := 'ｻ';
        WHEN 'シ' THEN
            ret := 'ｼ';
        WHEN 'ス' THEN
            ret := 'ｽ';
        WHEN 'セ' THEN
            ret := 'ｾ';
        WHEN 'ソ' THEN
            ret := 'ｿ';
        -- タ行
        WHEN 'タ' THEN
            ret := 'ﾀ';
        WHEN 'チ' THEN
            ret := 'ﾁ';
        WHEN 'ツ' THEN
            ret := 'ﾂ';
        WHEN 'テ' THEN
            ret := 'ﾃ';
        WHEN 'ト' THEN
            ret := 'ﾄ';
        -- ナ行
        WHEN 'ナ' THEN
            ret := 'ﾅ';
        WHEN 'ニ' THEN
            ret := 'ﾆ';
        WHEN 'ヌ' THEN
            ret := 'ﾇ';
        WHEN 'ネ' THEN
            ret := 'ﾈ';
        WHEN 'ノ' THEN
            ret := 'ﾉ';
        -- ハ行
        WHEN 'ハ' THEN
            ret := 'ﾊ';
        WHEN 'ヒ' THEN
            ret := 'ﾋ';
        WHEN 'フ' THEN
            ret := 'ﾌ';
        WHEN 'ヘ' THEN
            ret := 'ﾍ';
        WHEN 'ホ' THEN
            ret := 'ﾎ';
        -- マ行
        WHEN 'マ' THEN
            ret := 'ﾏ';
        WHEN 'ミ' THEN
            ret := 'ﾐ';
        WHEN 'ム' THEN
            ret := 'ﾑ';
        WHEN 'メ' THEN
            ret := 'ﾒ';
        WHEN 'モ' THEN
            ret := 'ﾓ';
        -- ヤ行
        WHEN 'ヤ' THEN
            ret := 'ﾔ';
        WHEN 'ユ' THEN
            ret := 'ﾕ';
        WHEN 'ヨ' THEN
            ret := 'ﾖ';
        -- ワ行
        WHEN 'ワ' THEN
            ret := 'ﾜ';
        WHEN 'ヲ' THEN
            ret := 'ｦ';
        WHEN 'ン' THEN
            ret := 'ﾝ';
        -- ガ行
        WHEN 'ガ' THEN
            ret := 'ｶﾞ';
        WHEN 'ギ' THEN
            ret := 'ｷﾞ';
        WHEN 'グ' THEN
            ret := 'ｸﾞ';
        WHEN 'ゲ' THEN
            ret := 'ｹﾞ';
        WHEN 'ゴ' THEN
            ret := 'ｺﾞ';
        -- ザ行
        WHEN 'ザ' THEN
            ret := 'ｻﾞ';
        WHEN 'ジ' THEN
            ret := 'ｼﾞ';
        WHEN 'ズ' THEN
            ret := 'ｽﾞ';
        WHEN 'ゼ' THEN
            ret := 'ｾﾞ';
        WHEN 'ゾ' THEN
            ret := 'ｿﾞ';
        -- ダ行
        WHEN 'ダ' THEN
            ret := 'ﾀﾞ';
        WHEN 'ヂ' THEN
            ret := 'ﾁﾞ';
        WHEN 'ヅ' THEN
            ret := 'ﾂﾞ';
        WHEN 'デ' THEN
            ret := 'ﾃﾞ';
        WHEN 'ド' THEN
            ret := 'ﾄﾞ';
        -- バ行
        WHEN 'バ' THEN
            ret := 'ﾊﾞ';
        WHEN 'ビ' THEN
            ret := 'ﾋﾞ';
        WHEN 'ブ' THEN
            ret := 'ﾌﾞ';
        WHEN 'ベ' THEN
            ret := 'ﾍﾞ';
        WHEN 'ボ' THEN
            ret := 'ﾎﾞ';
        -- パ行
        WHEN 'パ' THEN
            ret := 'ﾊﾟ';
        WHEN 'ピ' THEN
            ret := 'ﾋﾟ';
        WHEN 'プ' THEN
            ret := 'ﾌﾟ';
        WHEN 'ペ' THEN
            ret := 'ﾍﾟ';
        WHEN 'ポ' THEN
            ret := 'ﾎﾟ';
        -- 小文字
        WHEN 'ァ' THEN
            ret := 'ｧ';
        WHEN 'ィ' THEN
            ret := 'ｨ';
        WHEN 'ゥ' THEN
            ret := 'ｩ';
        WHEN 'ェ' THEN
            ret := 'ｪ';
        WHEN 'ォ' THEN
            ret := 'ｫ';
        WHEN 'ッ' THEN
            ret := 'ｯ';
        WHEN 'ャ' THEN
            ret := 'ｬ';
        WHEN 'ュ' THEN
            ret := 'ｭ';
        WHEN 'ョ' THEN
            ret := 'ｮ';
        -- その他 伸ばし棒
        WHEN 'ー' THEN
            ret := 'ｰ';
        ELSE
            -- 定義されていないものはそのまま返す
            ret := a;
    END CASE;
    RETURN ret;
END;
$$ LANGUAGE plpgsql;

-- 全角文字列を半角文字列に変更する関数。
CREATE FUNCTION zenkaku2hankakukana_string (str TEXT)
RETURNS TEXT AS $$
DECLARE
    ret TEXT;
    i INTEGER := 1;
    -- 何文字取るか
    cap INTEGER := 1;
BEGIN

    WHILE i <= char_length(str)
    LOOP
        ret := concat(ret, zenkaku2hankakukana(SUBSTRING(str, i, cap)));
        -- 取った数だけ進める
        i := i + cap;
    END LOOP;

    RETURN ret;
END;
$$ LANGUAGE plpgsql;


-- 半角を全角に変更する
CREATE FUNCTION hankakukana2zenkaku (a VARCHAR(2))
RETURNS CHAR(1) AS $$
DECLARE
    ret CHAR(1);
BEGIN

    CASE a
        -- ア行
        WHEN 'ｱ' THEN
            ret := 'ア';
        WHEN 'ｲ' THEN
            ret := 'イ';
        WHEN 'ｳ' THEN
            ret := 'ウ';
        WHEN 'ｴ' THEN
            ret := 'エ';
        WHEN 'ｵ' THEN
            ret := 'オ';
        -- カ行
        WHEN 'ｶ' THEN
            ret := 'カ';
        WHEN 'ｷ' THEN
            ret := 'キ';
        WHEN 'ｸ' THEN
            ret := 'ク';
        WHEN 'ｹ' THEN
            ret := 'ケ';
        WHEN 'ｺ' THEN
            ret := 'コ';
        -- サ行
        WHEN 'ｻ' THEN
            ret := 'サ';
        WHEN 'ｼ' THEN
            ret := 'シ';
        WHEN 'ｽ' THEN
            ret := 'ス';
        WHEN 'ｾ' THEN
            ret := 'セ';
        WHEN 'ｿ' THEN
            ret := 'ソ';
        -- タ行
        WHEN 'ﾀ' THEN
            ret := 'タ';
        WHEN 'ﾁ' THEN
            ret := 'チ';
        WHEN 'ﾂ' THEN
            ret := 'ツ';
        WHEN 'ﾃ' THEN
            ret := 'ﾃ';
        WHEN 'ﾄ' THEN
            ret := 'ト';
        -- ナ行
        WHEN 'ﾅ' THEN
            ret := 'ナ';
        WHEN 'ﾆ' THEN
            ret := 'ニ';
        WHEN 'ﾇ' THEN
            ret := 'ヌ';
        WHEN 'ﾈ' THEN
            ret := 'ネ';
        WHEN 'ﾉ' THEN
            ret := 'ノ';
        -- ハ行
        WHEN 'ﾊ' THEN
            ret := 'ハ';
        WHEN 'ﾋ' THEN
            ret := 'ヒ';
        WHEN 'ﾌ' THEN
            ret := 'フ';
        WHEN 'ﾍ' THEN
            ret := 'ヘ';
        WHEN 'ﾎ' THEN
            ret := 'ホ';
        -- マ行
        WHEN 'ﾏ' THEN
            ret := 'マ';
        WHEN 'ﾐ' THEN
            ret := 'ミ';
        WHEN 'ﾑ' THEN
            ret := 'ム';
        WHEN 'ﾒ' THEN
            ret := 'メ';
        WHEN 'ﾓ' THEN
            ret := 'モ';
        -- ヤ行
        WHEN 'ﾔ' THEN
            ret := 'ヤ';
        WHEN 'ﾕ' THEN
            ret := 'ユ';
        WHEN 'ﾖ' THEN
            ret := 'ヨ';
        -- ワ行
        WHEN 'ﾜ' THEN
            ret := 'ワ';
        WHEN 'ｦ' THEN
            ret := 'ヲ';
        WHEN 'ﾝ' THEN
            ret := 'ン';
        -- ガ行
        WHEN 'ｶﾞ' THEN
            ret := 'ガ';
        WHEN 'ｷﾞ' THEN
            ret := 'ギ';
        WHEN 'ｸﾞ' THEN
            ret := 'グ';
        WHEN 'ｹﾞ' THEN
            ret := 'ゲ';
        WHEN 'ｺﾞ' THEN
            ret := 'ゴ';
        -- ザ行
        WHEN 'ｻﾞ' THEN
            ret := 'ザ';
        WHEN 'ｼﾞ' THEN
            ret := 'ジ';
        WHEN 'ｽﾞ' THEN
            ret := 'ズ';
        WHEN 'ｾﾞ' THEN
            ret := 'ゼ';
        WHEN 'ｿﾞ' THEN
            ret := 'ゾ';
        -- ダ行
        WHEN 'ﾀﾞ' THEN
            ret := 'ダ';
        WHEN 'ﾁﾞ' THEN
            ret := 'ヂ';
        WHEN 'ﾂﾞ' THEN
            ret := 'ヅ';
        WHEN 'ﾃﾞ' THEN
            ret := 'デ';
        WHEN 'ﾄﾞ' THEN
            ret := 'ド';
        -- バ行
        WHEN 'ﾊﾞ' THEN
            ret := 'バ';
        WHEN 'ﾋﾞ' THEN
            ret := 'ビ';
        WHEN 'ﾌﾞ' THEN
            ret := 'ブ';
        WHEN 'ﾍﾞ' THEN
            ret := 'ベ';
        WHEN 'ﾎﾞ' THEN
            ret := 'ボ';
        -- パ行
        WHEN 'ﾊﾟ' THEN
            ret := 'パ';
        WHEN 'ﾋﾟ' THEN
            ret := 'ピ';
        WHEN 'ﾌﾟ' THEN
            ret := 'プ';
        WHEN 'ﾍﾟ' THEN
            ret := 'ペ';
        WHEN 'ﾎﾟ' THEN
            ret := 'ポ';
        -- 小文字
        WHEN 'ｧ' THEN
            ret := 'ァ';
        WHEN 'ｨ' THEN
            ret := 'ィ';
        WHEN 'ｩ' THEN
            ret := 'ゥ';
        WHEN 'ｪ' THEN
            ret := 'ェ';
        WHEN 'ｫ' THEN
            ret := 'ォ';
        WHEN 'ｯ' THEN
            ret := 'ッ';
        WHEN 'ｬ' THEN
            ret := 'ャ';
        WHEN 'ｭ' THEN
            ret := 'ュ';
        WHEN 'ｮ' THEN
            ret := 'ョ';
        -- その他 伸ばし棒-(マイナス)とは違う
        WHEN 'ｰ' THEN
            ret := 'ー';
        ELSE
            -- 定義されていないものはそのまま返す
            ret := a;
    END CASE;
    RETURN ret;
END;
$$ LANGUAGE plpgsql;

-- 合字（二つで一つの文字か判定）
CREATE FUNCTION ligature (c VARCHAR(2))
RETURNS BOOLEAN AS $$
DECLARE
    ret BOOLEAN := FALSE;
BEGIN
    -- 2文字の時のみ
    IF char_length(c) = 2 THEN
        -- 濁音、　半濁音は他の音があって初めてなので
        -- 実際あるか同時は他の関数に委ねる。漫画などにある表現として「あ」の濁点とかがあるので。
        IF Substring(c, 2, 1) IN ('ﾞ', 'ﾟ') THEN
            ret := TRUE;
        END IF;
        -- 2文字以上の合字が出たら足して行く。
    -- 3文字以上の合字が出たらELSE IF で追加して行く。
    END IF;

    RETURN ret;
END;
$$ LANGUAGE plpgsql;

-- 半角文字列を全角文字列に変更する関数。
CREATE FUNCTION hankakukana2zenkaku_string (str TEXT)
RETURNS TEXT AS $$
DECLARE
    ret TEXT;
    i INTEGER := 1;
    -- 何文字取るか
    cap INTEGER := 1;
BEGIN

    WHILE i <= char_length(str)
    LOOP
        -- 合字かどうか。
        -- 指定の位置から最大二文字取る。
        IF ligature(SUBSTRING(str, i, 2)) THEN
            -- 2文字で一つの文字なので二文字取る。
            cap := 2;
        ELSE
            cap := 1; 
        END IF;
            ret := concat(ret, hankakukana2zenkaku(SUBSTRING(str, i, cap)));
            -- 取った数だけ進める
            i := i + cap;
    END LOOP;

    RETURN ret;
END;
$$ LANGUAGE plpgsql;

