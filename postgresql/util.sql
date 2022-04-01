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

-- 全角ひらがなを全角カタカナに変更する
CREATE FUNCTION zenkakuhiragana2zenkakukatakana (c CHAR(1))
RETURNS CHAR(1) AS $$
DECLARE
    ret CHAR(1);
BEGIN

    CASE c
        -- あ行
        WHEN 'あ' THEN
            ret := 'ア';
        WHEN 'い' THEN
            ret := 'イ';
        WHEN 'う' THEN
            ret := 'ウ';
        WHEN 'え' THEN
            ret := 'エ';
        WHEN 'お' THEN
            ret := 'オ';
        -- か行
        WHEN 'か' THEN
            ret := 'カ';
        WHEN 'き' THEN
            ret := 'キ';
        WHEN 'く' THEN
            ret := 'ク';
        WHEN 'け' THEN
            ret := 'ケ';
        WHEN 'こ' THEN
            ret := 'コ';
        -- さ行
        WHEN 'さ' THEN
            ret := 'サ';
        WHEN 'し' THEN
            ret := 'シ';
        WHEN 'す' THEN
            ret := 'ス';
        WHEN 'せ' THEN
            ret := 'セ';
        WHEN 'そ' THEN
            ret := 'ソ';
        -- た行
        WHEN 'た' THEN
            ret := 'タ';
        WHEN 'ち' THEN
            ret := 'チ';
        WHEN 'つ' THEN
            ret := 'ツ';
        WHEN 'て' THEN
            ret := 'ﾃ';
        WHEN 'と' THEN
            ret := 'ト';
        -- な行
        WHEN 'な' THEN
            ret := 'ナ';
        WHEN 'に' THEN
            ret := 'ニ';
        WHEN 'ぬ' THEN
            ret := 'ヌ';
        WHEN 'ね' THEN
            ret := 'ネ';
        WHEN 'の' THEN
            ret := 'ノ';
        -- は行
        WHEN 'は' THEN
            ret := 'ハ';
        WHEN 'ひ' THEN
            ret := 'ヒ';
        WHEN 'ふ' THEN
            ret := 'フ';
        WHEN 'へ' THEN
            ret := 'ヘ';
        WHEN 'ほ' THEN
            ret := 'ホ';
        -- ま行
        WHEN 'ま' THEN
            ret := 'マ';
        WHEN 'み' THEN
            ret := 'ミ';
        WHEN 'む' THEN
            ret := 'ム';
        WHEN 'め' THEN
            ret := 'メ';
        WHEN 'も' THEN
            ret := 'モ';
        -- や行
        WHEN 'や' THEN
            ret := 'ヤ';
        WHEN 'ゆ' THEN
            ret := 'ユ';
        WHEN 'よ' THEN
            ret := 'ヨ';
        -- わ行
        WHEN 'わ' THEN
            ret := 'ワ';
        WHEN 'を' THEN
            ret := 'ヲ';
        WHEN 'ん' THEN
            ret := 'ン';
        -- が行
        WHEN 'が' THEN
            ret := 'ガ';
        WHEN 'ぎ' THEN
            ret := 'ギ';
        WHEN 'ぐ' THEN
            ret := 'グ';
        WHEN 'げ' THEN
            ret := 'ゲ';
        WHEN 'ご' THEN
            ret := 'ゴ';
        -- ざ行
        WHEN 'ざ' THEN
            ret := 'ザ';
        WHEN 'じ' THEN
            ret := 'ジ';
        WHEN 'ず' THEN
            ret := 'ズ';
        WHEN 'ぜ' THEN
            ret := 'ゼ';
        WHEN 'ぞ' THEN
            ret := 'ゾ';
        -- ダ行
        WHEN 'だ' THEN
            ret := 'ダ';
        WHEN 'ぢ' THEN
            ret := 'ヂ';
        WHEN 'づ' THEN
            ret := 'ヅ';
        WHEN 'で' THEN
            ret := 'デ';
        WHEN 'ど' THEN
            ret := 'ド';
        -- ば行
        WHEN 'ば' THEN
            ret := 'バ';
        WHEN 'び' THEN
            ret := 'ビ';
        WHEN 'ぶ' THEN
            ret := 'ブ';
        WHEN 'べ' THEN
            ret := 'ベ';
        WHEN 'ぼ' THEN
            ret := 'ボ';
        -- ぱ行
        WHEN 'ぱ' THEN
            ret := 'パ';
        WHEN 'ぴ' THEN
            ret := 'ピ';
        WHEN 'ぷ' THEN
            ret := 'プ';
        WHEN 'ぺ' THEN
            ret := 'ペ';
        WHEN 'ぽ' THEN
            ret := 'ポ';
        -- 小文字
        WHEN 'ぁ' THEN
            ret := 'ァ';
        WHEN 'ぃ' THEN
            ret := 'ィ';
        WHEN 'ぅ' THEN
            ret := 'ゥ';
        WHEN 'ぇ' THEN
            ret := 'ェ';
        WHEN 'ぉ' THEN
            ret := 'ォ';
        WHEN 'っ' THEN
            ret := 'ッ';
        WHEN 'ゃ' THEN
            ret := 'ャ';
        WHEN 'ゅ' THEN
            ret := 'ュ';
        WHEN 'ょ' THEN
            ret := 'ョ';
        ELSE
            -- 定義されていないものはそのまま返す
            ret := c;
    END CASE;
    RETURN ret;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 全角ひらがな文字列を全角カタカナ文字列に変更する関数。
CREATE FUNCTION zenkakuhiragana2zenkakukatakana_string (str TEXT)
RETURNS TEXT AS $$
DECLARE
    ret TEXT;
    i INTEGER := 1;
    -- 何文字取るか
    cap INTEGER := 1;
BEGIN

    WHILE i <= char_length(str)
    LOOP
        ret := concat(ret, zenkakuhiragana2zenkakukatakana(SUBSTRING(str, i, cap)));
        -- 取った数だけ進める
        i := i + cap;
    END LOOP;

    RETURN ret;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 全角カタカナを全角ひらがなに変更する
CREATE FUNCTION zenkakukatakana2zenkakuhiragana (c CHAR)
RETURNS CHAR AS $$
DECLARE
    ret CHAR;
BEGIN
    CASE c
        -- ア行
        WHEN 'ア' THEN
            ret := 'あ';
        WHEN 'イ' THEN
            ret := 'い';
        WHEN 'ウ' THEN
            ret := 'う';
        WHEN 'エ' THEN
            ret := 'え';
        WHEN 'オ' THEN
            ret := 'お';
        -- カ行
        WHEN 'カ' THEN
            ret := 'か';
        WHEN 'キ' THEN
            ret := 'き';
        WHEN 'ク' THEN
            ret := 'く';
        WHEN 'ケ' THEN
            ret := 'け';
        WHEN 'コ' THEN
            ret := 'こ';
        -- サ行
        WHEN 'サ' THEN
            ret := 'さ';
        WHEN 'シ' THEN
            ret := 'し';
        WHEN 'ス' THEN
            ret := 'す';
        WHEN 'セ' THEN
            ret := 'せ';
        WHEN 'ソ' THEN
            ret := 'そ';
        -- タ行
        WHEN 'タ' THEN
            ret := 'た';
        WHEN 'チ' THEN
            ret := 'ち';
        WHEN 'ツ' THEN
            ret := 'つ';
        WHEN 'テ' THEN
            ret := 'て';
        WHEN 'ト' THEN
            ret := 'と';
        -- ナ行
        WHEN 'ナ' THEN
            ret := 'な';
        WHEN 'ニ' THEN
            ret := 'に';
        WHEN 'ヌ' THEN
            ret := 'ぬ';
        WHEN 'ネ' THEN
            ret := 'ね';
        WHEN 'ノ' THEN
            ret := 'の';
        -- ハ行
        WHEN 'ハ' THEN
            ret := 'は';
        WHEN 'ヒ' THEN
            ret := 'ひ';
        WHEN 'フ' THEN
            ret := 'ふ';
        WHEN 'ヘ' THEN
            ret := 'へ';
        WHEN 'ホ' THEN
            ret := 'ほ';
        -- マ行
        WHEN 'マ' THEN
            ret := 'ま';
        WHEN 'ミ' THEN
            ret := 'み';
        WHEN 'ム' THEN
            ret := 'む';
        WHEN 'メ' THEN
            ret := 'め';
        WHEN 'モ' THEN
            ret := 'も';
        -- ヤ行
        WHEN 'ヤ' THEN
            ret := 'や';
        WHEN 'ユ' THEN
            ret := 'ゆ';
        WHEN 'ヨ' THEN
            ret := 'よ';
        -- ワ行
        WHEN 'ワ' THEN
            ret := 'わ';
        WHEN 'ヲ' THEN
            ret := 'を';
        WHEN 'ン' THEN
            ret := 'ん';
        -- ガ行
        WHEN 'ガ' THEN
            ret := 'がﾞ';
        WHEN 'ギ' THEN
            ret := 'ぎﾞ';
        WHEN 'グ' THEN
            ret := 'ぐﾞ';
        WHEN 'ゲ' THEN
            ret := 'げﾞ';
        WHEN 'ゴ' THEN
            ret := 'ごﾞ';
        -- ザ行
        WHEN 'ザ' THEN
            ret := 'ざ';
        WHEN 'ジ' THEN
            ret := 'じ';
        WHEN 'ズ' THEN
            ret := 'ず';
        WHEN 'ゼ' THEN
            ret := 'ぜ';
        WHEN 'ゾ' THEN
            ret := 'ぞ';
        -- ダ行
        WHEN 'ダ' THEN
            ret := 'だ';
        WHEN 'ヂ' THEN
            ret := 'ぢ';
        WHEN 'ヅ' THEN
            ret := 'づ';
        WHEN 'デ' THEN
            ret := 'で';
        WHEN 'ド' THEN
            ret := 'ど';
        -- バ行
        WHEN 'バ' THEN
            ret := 'ば';
        WHEN 'ビ' THEN
            ret := 'び';
        WHEN 'ブ' THEN
            ret := 'ぶ';
        WHEN 'ベ' THEN
            ret := 'べ';
        WHEN 'ボ' THEN
            ret := 'ぼ';
        -- パ行
        WHEN 'パ' THEN
            ret := 'ぱ';
        WHEN 'ピ' THEN
            ret := 'ぴ';
        WHEN 'プ' THEN
            ret := 'ぷ';
        WHEN 'ペ' THEN
            ret := 'ぺ';
        WHEN 'ポ' THEN
            ret := 'ぽ';
        -- 小文字
        WHEN 'ァ' THEN
            ret := 'ぁ';
        WHEN 'ィ' THEN
            ret := 'ぃ';
        WHEN 'ゥ' THEN
            ret := 'ぅ';
        WHEN 'ェ' THEN
            ret := 'ぇ';
        WHEN 'ォ' THEN
            ret := 'ぉ';
        WHEN 'ッ' THEN
            ret := 'っ';
        WHEN 'ャ' THEN
            ret := 'ゃ';
        WHEN 'ュ' THEN
            ret := 'ゅ';
        WHEN 'ョ' THEN
            ret := 'ょ';
        ELSE
            -- 定義されていないものはそのまま返す
            ret := c;
    END CASE;
    RETURN ret;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 全角カタカナ文字列を全角ひらがな文字列に変更する関数。
CREATE FUNCTION zenkakukatakana2zenkakuhiragana_string (str TEXT)
RETURNS TEXT AS $$
DECLARE
    ret TEXT;
    i INTEGER := 1;
    -- 何文字取るか
    cap INTEGER := 1;
BEGIN

    WHILE i <= char_length(str)
    LOOP
        ret := concat(ret, zenkakukatakana2zenkakuhiragana(SUBSTRING(str, i, cap)));
        -- 取った数だけ進める
        i := i + cap;
    END LOOP;

    RETURN ret;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE FUNCTION zenkaku2hankakukana (c CHAR)
RETURNS VARCHAR(2) AS $$
DECLARE
    ret VARCHAR(2);
BEGIN

    CASE c
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
        -- その他 伸ばし棒ー（マイナスとは違う）
        WHEN 'ー' THEN
            ret := 'ｰ';
        -- アルファベット
        -- 小文字
        WHEN 'ａ' THEN
            ret := 'a';
        WHEN 'ｂ' THEN
            ret := 'b';
        WHEN 'ｃ' THEN
            ret := 'c';
        WHEN 'ｄ' THEN
            ret := 'd';
        WHEN 'ｅ' THEN
            ret := 'e';
        WHEN 'ｆ' THEN
            ret := 'f';
        WHEN 'ｇ' THEN
            ret := 'g';
        WHEN 'ｈ' THEN
            ret := 'h';
        WHEN 'ｉ' THEN
            ret := 'i';
        WHEN 'ｊ' THEN
            ret := 'j';
        WHEN 'ｋ' THEN
            ret := 'k';
        WHEN 'ｌ' THEN
            ret := 'l';
        WHEN 'ｍ' THEN
            ret := 'm';
        WHEN 'ｎ' THEN
            ret := 'n';
        WHEN 'ｏ' THEN
            ret := 'o';
        WHEN 'ｐ' THEN
            ret := 'p';
        WHEN 'ｑ' THEN
            ret := 'q';
        WHEN 'ｒ' THEN
            ret := 'r';
        WHEN 'ｓ' THEN
            ret := 's';
        WHEN 'ｔ' THEN
            ret := 't';
        WHEN 'ｕ' THEN
            ret := 'u';
        WHEN 'ｖ' THEN
            ret := 'v';
        WHEN 'ｗ' THEN
            ret := 'w';
        WHEN 'ｘ' THEN
            ret := 'x';
        WHEN 'ｙ' THEN
            ret := 'y';
        WHEN 'ｚ' THEN
            ret := 'z';
        -- 大文字
        WHEN 'Ａ' THEN
            ret := 'A';
        WHEN 'Ｂ' THEN
            ret := 'B';
        WHEN 'Ｃ' THEN
            ret := 'C';
        WHEN 'Ｄ' THEN
            ret := 'D';
        WHEN 'Ｅ' THEN
            ret := 'E';
        WHEN 'Ｆ' THEN
            ret := 'F';
        WHEN 'Ｇ' THEN
            ret := 'G';
        WHEN 'Ｈ' THEN
            ret := 'H';
        WHEN 'Ｉ' THEN
            ret := 'I';
        WHEN 'Ｊ' THEN
            ret := 'J';
        WHEN 'Ｋ' THEN
            ret := 'K';
        WHEN 'Ｌ' THEN
            ret := 'L';
        WHEN 'Ｍ' THEN
            ret := 'M';
        WHEN 'Ｎ' THEN
            ret := 'N';
        WHEN 'Ｏ' THEN
            ret := 'O';
        WHEN 'Ｐ' THEN
            ret := 'P';
        WHEN 'Ｑ' THEN
            ret := 'Q';
        WHEN 'Ｒ' THEN
            ret := 'R';
        WHEN 'Ｓ' THEN
            ret := 'S';
        WHEN 'Ｔ' THEN
            ret := 'T';
        WHEN 'Ｕ' THEN
            ret := 'U';
        WHEN 'Ｖ' THEN
            ret := 'V';
        WHEN 'Ｗ' THEN
            ret := 'W';
        WHEN 'Ｘ' THEN
            ret := 'X';
        WHEN 'Ｙ' THEN
            ret := 'Y';
        WHEN 'Ｚ' THEN
            ret := 'Z';
        -- 数字
        WHEN '０' THEN
            ret := '0';
        WHEN '１' THEN
            ret := '1';
        WHEN '２' THEN
            ret := '2';
        WHEN '３' THEN
            ret := '3';
        WHEN '４' THEN
            ret := '4';
        WHEN '５' THEN
            ret := '5';
        WHEN '６' THEN
            ret := '6';
        WHEN '７' THEN
            ret := '7';
        WHEN '８' THEN
            ret := '8';
        WHEN '９' THEN
            ret := '9';
        ELSE
            -- 定義されていないものはそのまま返す
            ret := c;
    END CASE;
    RETURN ret;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

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
$$ LANGUAGE plpgsql IMMUTABLE;


-- 半角を全角に変更する
CREATE FUNCTION hankakukana2zenkaku (c VARCHAR(2))
RETURNS CHAR(1) AS $$
DECLARE
    ret CHAR(1);
BEGIN

    CASE c
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
        -- アルファベット
        -- 小文字
        WHEN 'a' THEN
            ret := 'ａ';
        WHEN 'b' THEN
            ret := 'ｂ';
        WHEN 'c' THEN
            ret := 'ｃ';
        WHEN 'd' THEN
            ret := 'ｄ';
        WHEN 'e' THEN
            ret := 'ｅ';
        WHEN 'f' THEN
            ret := 'ｆ';
        WHEN 'g' THEN
            ret := 'ｇ';
        WHEN 'h' THEN
            ret := 'ｈ';
        WHEN 'i' THEN
            ret := 'ｉ';
        WHEN 'j' THEN
            ret := 'ｊ';
        WHEN 'k' THEN
            ret := 'ｋ';
        WHEN 'l' THEN
            ret := 'ｌ';
        WHEN 'm' THEN
            ret := 'ｍ';
        WHEN 'n' THEN
            ret := 'ｎ';
        WHEN 'o' THEN
            ret := 'ｏ';
        WHEN 'p' THEN
            ret := 'ｐ';
        WHEN 'q' THEN
            ret := 'ｑ';
        WHEN 'r' THEN
            ret := 'ｒ';
        WHEN 's' THEN
            ret := 'ｓ';
        WHEN 't' THEN
            ret := 'ｔ';
        WHEN 'u' THEN
            ret := 'ｕ';
        WHEN 'v' THEN
            ret := 'ｖ';
        WHEN 'w' THEN
            ret := 'ｗ';
        WHEN 'x' THEN
            ret := 'ｘ';
        WHEN 'y' THEN
            ret := 'ｙ';
        WHEN 'z' THEN
            ret := 'ｚ';
        -- 大文字
        WHEN 'A' THEN
            ret := 'Ａ';
        WHEN 'B' THEN
            ret := 'Ｂ';
        WHEN 'C' THEN
            ret := 'Ｃ';
        WHEN 'D' THEN
            ret := 'Ｄ';
        WHEN 'E' THEN
            ret := 'Ｅ';
        WHEN 'F' THEN
            ret := 'Ｆ';
        WHEN 'G' THEN
            ret := 'Ｇ';
        WHEN 'H' THEN
            ret := 'Ｈ';
        WHEN 'I' THEN
            ret := 'Ｉ';
        WHEN 'J' THEN
            ret := 'Ｊ';
        WHEN 'K' THEN
            ret := 'Ｋ';
        WHEN 'L' THEN
            ret := 'Ｌ';
        WHEN 'M' THEN
            ret := 'Ｍ';
        WHEN 'N' THEN
            ret := 'Ｎ';
        WHEN 'O' THEN
            ret := 'Ｏ';
        WHEN 'P' THEN
            ret := 'Ｐ';
        WHEN 'Q' THEN
            ret := 'Ｑ';
        WHEN 'R' THEN
            ret := 'Ｒ';
        WHEN 'S' THEN
            ret := 'Ｓ';
        WHEN 'T' THEN
            ret := 'Ｔ';
        WHEN 'U' THEN
            ret := 'Ｕ';
        WHEN 'V' THEN
            ret := 'Ｖ';
        WHEN 'W' THEN
            ret := 'Ｗ';
        WHEN 'X' THEN
            ret := 'Ｘ';
        WHEN 'Y' THEN
            ret := 'Ｙ';
        WHEN 'Z' THEN
            ret := 'Ｚ';
        -- 数字
        WHEN '0' THEN
            ret := '０';
        WHEN '1' THEN
            ret := '１';
        WHEN '2' THEN
            ret := '２';
        WHEN '3' THEN
            ret := '３';
        WHEN '4' THEN
            ret := '４';
        WHEN '5' THEN
            ret := '５';
        WHEN '6' THEN
            ret := '６';
        WHEN '7' THEN
            ret := '７';
        WHEN '8' THEN
            ret := '８';
        WHEN '9' THEN
            ret := '９';
        ELSE
            -- 定義されていないものはそのまま返す
            ret := c;
    END CASE;
    RETURN ret;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

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
$$ LANGUAGE plpgsql IMMUTABLE;

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
$$ LANGUAGE plpgsql IMMUTABLE;

