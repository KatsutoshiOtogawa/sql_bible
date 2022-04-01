
-- 全角ひらがなを全角カタカナに変更する
DELIMITER $$
CREATE FUNCTION zenkakuhiragana2zenkakukatakana (c CHAR(1))
RETURNS CHAR(1) DETERMINISTIC
BEGIN
    DECLARE ret CHAR(1);
    CASE c
        -- あ行
        WHEN 'あ' THEN
            SET ret = 'ア';
        WHEN 'い' THEN
            SET ret = 'イ';
        WHEN 'う' THEN
            SET ret = 'ウ';
        WHEN 'え' THEN
            SET ret = 'エ';
        WHEN 'お' THEN
            SET ret = 'オ';
        -- か行
        WHEN 'か' THEN
            SET ret = 'カ';
        WHEN 'き' THEN
            SET ret = 'キ';
        WHEN 'く' THEN
            SET ret = 'ク';
        WHEN 'け' THEN
            SET ret = 'ケ';
        WHEN 'こ' THEN
            SET ret = 'コ';
        -- さ行
        WHEN 'さ' THEN
            SET ret = 'サ';
        WHEN 'し' THEN
            SET ret = 'シ';
        WHEN 'す' THEN
            SET ret = 'ス';
        WHEN 'せ' THEN
            SET ret = 'セ';
        WHEN 'そ' THEN
            SET ret = 'ソ';
        -- た行
        WHEN 'た' THEN
            SET ret = 'タ';
        WHEN 'ち' THEN
            SET ret = 'チ';
        WHEN 'つ' THEN
            SET ret = 'ツ';
        WHEN 'て' THEN
            SET ret = 'ﾃ';
        WHEN 'と' THEN
            SET ret = 'ト';
        -- な行
        WHEN 'な' THEN
            SET ret = 'ナ';
        WHEN 'に' THEN
            SET ret = 'ニ';
        WHEN 'ぬ' THEN
            SET ret = 'ヌ';
        WHEN 'ね' THEN
            SET ret = 'ネ';
        WHEN 'の' THEN
            SET ret = 'ノ';
        -- は行
        WHEN 'は' THEN
            SET ret = 'ハ';
        WHEN 'ひ' THEN
            SET ret = 'ヒ';
        WHEN 'ふ' THEN
            SET ret = 'フ';
        WHEN 'へ' THEN
            SET ret = 'ヘ';
        WHEN 'ほ' THEN
            SET ret = 'ホ';
        -- ま行
        WHEN 'ま' THEN
            SET ret = 'マ';
        WHEN 'み' THEN
            SET ret = 'ミ';
        WHEN 'む' THEN
            SET ret = 'ム';
        WHEN 'め' THEN
            SET ret = 'メ';
        WHEN 'も' THEN
            SET ret = 'モ';
        -- や行
        WHEN 'や' THEN
            SET ret = 'ヤ';
        WHEN 'ゆ' THEN
            SET ret = 'ユ';
        WHEN 'よ' THEN
            SET ret = 'ヨ';
        -- わ行
        WHEN 'わ' THEN
            SET ret = 'ワ';
        WHEN 'を' THEN
            SET ret = 'ヲ';
        WHEN 'ん' THEN
            SET ret = 'ン';
        -- が行
        WHEN 'が' THEN
            SET ret = 'ガ';
        WHEN 'ぎ' THEN
            SET ret = 'ギ';
        WHEN 'ぐ' THEN
            SET ret = 'グ';
        WHEN 'げ' THEN
            SET ret = 'ゲ';
        WHEN 'ご' THEN
            SET ret = 'ゴ';
        -- ざ行
        WHEN 'ざ' THEN
            SET ret = 'ザ';
        WHEN 'じ' THEN
            SET ret = 'ジ';
        WHEN 'ず' THEN
            SET ret = 'ズ';
        WHEN 'ぜ' THEN
            SET ret = 'ゼ';
        WHEN 'ぞ' THEN
            SET ret = 'ゾ';
        -- ダ行
        WHEN 'だ' THEN
            SET ret = 'ダ';
        WHEN 'ぢ' THEN
            SET ret = 'ヂ';
        WHEN 'づ' THEN
            SET ret = 'ヅ';
        WHEN 'で' THEN
            SET ret = 'デ';
        WHEN 'ど' THEN
            SET ret = 'ド';
        -- ば行
        WHEN 'ば' THEN
            SET ret = 'バ';
        WHEN 'び' THEN
            SET ret = 'ビ';
        WHEN 'ぶ' THEN
            SET ret = 'ブ';
        WHEN 'べ' THEN
            SET ret = 'ベ';
        WHEN 'ぼ' THEN
            SET ret = 'ボ';
        -- ぱ行
        WHEN 'ぱ' THEN
            SET ret = 'パ';
        WHEN 'ぴ' THEN
            SET ret = 'ピ';
        WHEN 'ぷ' THEN
            SET ret = 'プ';
        WHEN 'ぺ' THEN
            SET ret = 'ペ';
        WHEN 'ぽ' THEN
            SET ret = 'ポ';
        -- 小文字
        WHEN 'ぁ' THEN
            SET ret = 'ァ';
        WHEN 'ぃ' THEN
            SET ret = 'ィ';
        WHEN 'ぅ' THEN
            SET ret = 'ゥ';
        WHEN 'ぇ' THEN
            SET ret = 'ェ';
        WHEN 'ぉ' THEN
            SET ret = 'ォ';
        WHEN 'っ' THEN
            SET ret = 'ッ';
        WHEN 'ゃ' THEN
            SET ret = 'ャ';
        WHEN 'ゅ' THEN
            SET ret = 'ュ';
        WHEN 'ょ' THEN
            SET ret = 'ョ';
        ELSE
            -- 定義されていないものはそのまま返す
            SET ret = c;
    END CASE;
    RETURN ret;
END;
$$
DELIMITER ;

-- 全角ひらがな文字列を全角カタカナ文字列に変更する関数。
DELIMITER $$
CREATE FUNCTION zenkakuhiragana2zenkakukatakana_string (str TEXT)
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE ret TEXT;
    DECLARE i INTEGER DEFAULT 1;
    -- 何文字取るか
    DECLARE cap INTEGER DEFAULT 1;
    WHILE i <= char_length(str) DO
        SET ret = concat(ret, zenkakuhiragana2zenkakukatakana(SUBSTRING(str, i, cap)));
        -- 取った数だけ進める
        SET i = i + cap;
	END WHILE;
    RETURN ret;
END;
$$
DELIMITER ;

-- 全角カタカナを全角ひらがなに変更する
DELIMITER $$
CREATE FUNCTION zenkakukatakana2zenkakuhiragana (c CHAR(1))
RETURNS CHAR(1) DETERMINISTIC
BEGIN
    /**
     * 全角カタカナを全角ひらがなに変更する。
     * @description 全角カタカナを全角ひらがなにする
     * @param {CHAR(1)} c 
     * @example zenkakukatakana2zenkakuhiragana('ア') -> 'あ'
     * @return {CHAR(1)} 全角ひらがな一文字が帰る。未定義の文字列は素通り。
    */
    DECLARE ret CHAR(1);
    CASE c
        -- ア行
        WHEN 'ア' THEN
            SET ret = 'あ';
        WHEN 'イ' THEN
            SET ret = 'い';
        WHEN 'ウ' THEN
            SET ret = 'う';
        WHEN 'エ' THEN
            SET ret = 'え';
        WHEN 'オ' THEN
            SET ret = 'お';
        -- カ行
        WHEN 'カ' THEN
            SET ret = 'か';
        WHEN 'キ' THEN
            SET ret = 'き';
        WHEN 'ク' THEN
            SET ret = 'く';
        WHEN 'ケ' THEN
            SET ret = 'け';
        WHEN 'コ' THEN
            SET ret = 'こ';
        -- サ行
        WHEN 'サ' THEN
            SET ret = 'さ';
        WHEN 'シ' THEN
            SET ret = 'し';
        WHEN 'ス' THEN
            SET ret = 'す';
        WHEN 'セ' THEN
            SET ret = 'せ';
        WHEN 'ソ' THEN
            SET ret = 'そ';
        -- タ行
        WHEN 'タ' THEN
            SET ret = 'た';
        WHEN 'チ' THEN
            SET ret = 'ち';
        WHEN 'ツ' THEN
            SET ret = 'つ';
        WHEN 'テ' THEN
            SET ret = 'て';
        WHEN 'ト' THEN
            SET ret = 'と';
        -- ナ行
        WHEN 'ナ' THEN
            SET ret = 'な';
        WHEN 'ニ' THEN
            SET ret = 'に';
        WHEN 'ヌ' THEN
            SET ret = 'ぬ';
        WHEN 'ネ' THEN
            SET ret = 'ね';
        WHEN 'ノ' THEN
            SET ret = 'の';
        -- ハ行
        WHEN 'ハ' THEN
            SET ret = 'は';
        WHEN 'ヒ' THEN
            SET ret = 'ひ';
        WHEN 'フ' THEN
            SET ret = 'ふ';
        WHEN 'ヘ' THEN
            SET ret = 'へ';
        WHEN 'ホ' THEN
            SET ret = 'ほ';
        -- マ行
        WHEN 'マ' THEN
            SET ret = 'ま';
        WHEN 'ミ' THEN
            SET ret = 'み';
        WHEN 'ム' THEN
            SET ret = 'む';
        WHEN 'メ' THEN
            SET ret = 'め';
        WHEN 'モ' THEN
            SET ret = 'も';
        -- ヤ行
        WHEN 'ヤ' THEN
            SET ret = 'や';
        WHEN 'ユ' THEN
            SET ret = 'ゆ';
        WHEN 'ヨ' THEN
            SET ret = 'よ';
        -- ワ行
        WHEN 'ワ' THEN
            SET ret = 'わ';
        WHEN 'ヲ' THEN
            SET ret = 'を';
        WHEN 'ン' THEN
            SET ret = 'ん';
        -- ガ行
        WHEN 'ガ' THEN
            SET ret = 'がﾞ';
        WHEN 'ギ' THEN
            SET ret = 'ぎﾞ';
        WHEN 'グ' THEN
            SET ret = 'ぐﾞ';
        WHEN 'ゲ' THEN
            SET ret = 'げﾞ';
        WHEN 'ゴ' THEN
            SET ret = 'ごﾞ';
        -- ザ行
        WHEN 'ザ' THEN
            SET ret = 'ざ';
        WHEN 'ジ' THEN
            SET ret = 'じ';
        WHEN 'ズ' THEN
            SET ret = 'ず';
        WHEN 'ゼ' THEN
            SET ret = 'ぜ';
        WHEN 'ゾ' THEN
            SET ret = 'ぞ';
        -- ダ行
        WHEN 'ダ' THEN
            SET ret = 'だ';
        WHEN 'ヂ' THEN
            SET ret = 'ぢ';
        WHEN 'ヅ' THEN
            SET ret = 'づ';
        WHEN 'デ' THEN
            SET ret = 'で';
        WHEN 'ド' THEN
            SET ret = 'ど';
        -- バ行
        WHEN 'バ' THEN
            SET ret = 'ば';
        WHEN 'ビ' THEN
            SET ret = 'び';
        WHEN 'ブ' THEN
            SET ret = 'ぶ';
        WHEN 'ベ' THEN
            SET ret = 'べ';
        WHEN 'ボ' THEN
            SET ret = 'ぼ';
        -- パ行
        WHEN 'パ' THEN
            SET ret = 'ぱ';
        WHEN 'ピ' THEN
            SET ret = 'ぴ';
        WHEN 'プ' THEN
            SET ret = 'ぷ';
        WHEN 'ペ' THEN
            SET ret = 'ぺ';
        WHEN 'ポ' THEN
            SET ret = 'ぽ';
        -- 小文字
        WHEN 'ァ' THEN
            SET ret = 'ぁ';
        WHEN 'ィ' THEN
            SET ret = 'ぃ';
        WHEN 'ゥ' THEN
            SET ret = 'ぅ';
        WHEN 'ェ' THEN
            SET ret = 'ぇ';
        WHEN 'ォ' THEN
            SET ret = 'ぉ';
        WHEN 'ッ' THEN
            SET ret = 'っ';
        WHEN 'ャ' THEN
            SET ret = 'ゃ';
        WHEN 'ュ' THEN
            SET ret = 'ゅ';
        WHEN 'ョ' THEN
            SET ret = 'ょ';
        ELSE
            -- 定義されていないものはそのまま返す
            SET ret = c;
    END CASE;
    RETURN ret;
END;
$$
DELIMITER ;

-- 全角カタカナ文字列を全角ひらがな文字列に変更する関数。
DELIMITER $$
CREATE FUNCTION zenkakukatakana2zenkakuhiragana_string (str TEXT)
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE ret TEXT;
    DECLARE i INTEGER DEFAULT 1;
    -- 何文字取るか
    DECLARE cap INTEGER DEFAULT 1;
    WHILE i <= char_length(str) DO
        SET ret = concat(ret, zenkakukatakana2zenkakuhiragana(SUBSTRING(str, i, cap)));
        -- 取った数だけ進める
        SET i = i + cap;
	END WHILE;
    RETURN ret;
END;
$$
DELIMITER ;

-- 全角カナを半角カナに変更する関数。
DELIMITER $$
CREATE FUNCTION zenkaku2hankakukana (c CHAR(1))
RETURNS VARCHAR(2) DETERMINISTIC
BEGIN
    DECLARE ret VARCHAR(2);
    CASE c
        -- ア行
        WHEN 'ア' THEN
            SET ret = 'ｱ';
        WHEN 'イ' THEN
            SET ret = 'ｲ';
        WHEN 'ウ' THEN
            SET ret = 'ｳ';
        WHEN 'エ' THEN
            SET ret = 'ｴ';
        WHEN 'オ' THEN
            SET ret = 'ｵ';
        -- カ行
        WHEN 'カ' THEN
            SET ret = 'ｶ';
        WHEN 'キ' THEN
            SET ret = 'ｷ';
        WHEN 'ク' THEN
            SET ret = 'ｸ';
        WHEN 'ケ' THEN
            SET ret = 'ｹ';
        WHEN 'コ' THEN
            SET ret = 'ｺ';
        -- サ行
        WHEN 'サ' THEN
            SET ret = 'ｻ';
        WHEN 'シ' THEN
            SET ret = 'ｼ';
        WHEN 'ス' THEN
            SET ret = 'ｽ';
        WHEN 'セ' THEN
            SET ret = 'ｾ';
        WHEN 'ソ' THEN
            SET ret = 'ｿ';
        -- タ行
        WHEN 'タ' THEN
            SET ret = 'ﾀ';
        WHEN 'チ' THEN
            SET ret = 'ﾁ';
        WHEN 'ツ' THEN
            SET ret = 'ﾂ';
        WHEN 'テ' THEN
            SET ret = 'ﾃ';
        WHEN 'ト' THEN
            SET ret = 'ﾄ';
        -- ナ行
        WHEN 'ナ' THEN
            SET ret = 'ﾅ';
        WHEN 'ニ' THEN
            SET ret = 'ﾆ';
        WHEN 'ヌ' THEN
            SET ret = 'ﾇ';
        WHEN 'ネ' THEN
            SET ret = 'ﾈ';
        WHEN 'ノ' THEN
            SET ret = 'ﾉ';
        -- ハ行
        WHEN 'ハ' THEN
            SET ret = 'ﾊ';
        WHEN 'ヒ' THEN
            SET ret = 'ﾋ';
        WHEN 'フ' THEN
            SET ret = 'ﾌ';
        WHEN 'ヘ' THEN
            SET ret = 'ﾍ';
        WHEN 'ホ' THEN
            SET ret = 'ﾎ';
        -- マ行
        WHEN 'マ' THEN
            SET ret = 'ﾏ';
        WHEN 'ミ' THEN
            SET ret = 'ﾐ';
        WHEN 'ム' THEN
            SET ret = 'ﾑ';
        WHEN 'メ' THEN
            SET ret = 'ﾒ';
        WHEN 'モ' THEN
            SET ret = 'ﾓ';
        -- ヤ行
        WHEN 'ヤ' THEN
            SET ret = 'ﾔ';
        WHEN 'ユ' THEN
            SET ret = 'ﾕ';
        WHEN 'ヨ' THEN
            SET ret = 'ﾖ';
        -- ワ行
        WHEN 'ワ' THEN
            SET ret = 'ﾜ';
        WHEN 'ヲ' THEN
            SET ret = 'ｦ';
        WHEN 'ン' THEN
            SET ret = 'ﾝ';
        -- ガ行
        WHEN 'ガ' THEN
            SET ret = 'ｶﾞ';
        WHEN 'ギ' THEN
            SET ret = 'ｷﾞ';
        WHEN 'グ' THEN
            SET ret = 'ｸﾞ';
        WHEN 'ゲ' THEN
            SET ret = 'ｹﾞ';
        WHEN 'ゴ' THEN
            SET ret = 'ｺﾞ';
        -- ザ行
        WHEN 'ザ' THEN
            SET ret = 'ｻﾞ';
        WHEN 'ジ' THEN
            SET ret = 'ｼﾞ';
        WHEN 'ズ' THEN
            SET ret = 'ｽﾞ';
        WHEN 'ゼ' THEN
            SET ret = 'ｾﾞ';
        WHEN 'ゾ' THEN
            SET ret = 'ｿﾞ';
        -- ダ行
        WHEN 'ダ' THEN
            SET ret = 'ﾀﾞ';
        WHEN 'ヂ' THEN
            SET ret = 'ﾁﾞ';
        WHEN 'ヅ' THEN
            SET ret = 'ﾂﾞ';
        WHEN 'デ' THEN
            SET ret = 'ﾃﾞ';
        WHEN 'ド' THEN
            SET ret = 'ﾄﾞ';
        -- バ行
        WHEN 'バ' THEN
            SET ret = 'ﾊﾞ';
        WHEN 'ビ' THEN
            SET ret = 'ﾋﾞ';
        WHEN 'ブ' THEN
            SET ret = 'ﾌﾞ';
        WHEN 'ベ' THEN
            SET ret = 'ﾍﾞ';
        WHEN 'ボ' THEN
            SET ret = 'ﾎﾞ';
        -- パ行
        WHEN 'パ' THEN
            SET ret = 'ﾊﾟ';
        WHEN 'ピ' THEN
            SET ret = 'ﾋﾟ';
        WHEN 'プ' THEN
            SET ret = 'ﾌﾟ';
        WHEN 'ペ' THEN
            SET ret = 'ﾍﾟ';
        WHEN 'ポ' THEN
            SET ret = 'ﾎﾟ';
        -- 小文字
        WHEN 'ァ' THEN
            SET ret = 'ｧ';
        WHEN 'ィ' THEN
            SET ret = 'ｨ';
        WHEN 'ゥ' THEN
            SET ret = 'ｩ';
        WHEN 'ェ' THEN
            SET ret = 'ｪ';
        WHEN 'ォ' THEN
            SET ret = 'ｫ';
        WHEN 'ッ' THEN
            SET ret = 'ｯ';
        WHEN 'ャ' THEN
            SET ret = 'ｬ';
        WHEN 'ュ' THEN
            SET ret = 'ｭ';
        WHEN 'ョ' THEN
            SET ret = 'ｮ';
        -- その他 伸ばし棒ー（マイナスとは違う）
        WHEN 'ー' THEN
            SET ret = 'ｰ';
        -- アルファベット
        -- 小文字
        WHEN 'ａ' THEN
            SET ret = 'a';
        WHEN 'ｂ' THEN
            SET ret = 'b';
        WHEN 'ｃ' THEN
            SET ret = 'c';
        WHEN 'ｄ' THEN
            SET ret = 'd';
        WHEN 'ｅ' THEN
            SET ret = 'e';
        WHEN 'ｆ' THEN
            SET ret = 'f';
        WHEN 'ｇ' THEN
            SET ret = 'g';
        WHEN 'ｈ' THEN
            SET ret = 'h';
        WHEN 'ｉ' THEN
            SET ret = 'i';
        WHEN 'ｊ' THEN
            SET ret = 'j';
        WHEN 'ｋ' THEN
            SET ret = 'k';
        WHEN 'ｌ' THEN
            SET ret = 'l';
        WHEN 'ｍ' THEN
            SET ret = 'm';
        WHEN 'ｎ' THEN
            SET ret = 'n';
        WHEN 'ｏ' THEN
            SET ret = 'o';
        WHEN 'ｐ' THEN
            SET ret = 'p';
        WHEN 'ｑ' THEN
            SET ret = 'q';
        WHEN 'ｒ' THEN
            SET ret = 'r';
        WHEN 'ｓ' THEN
            SET ret = 's';
        WHEN 'ｔ' THEN
            SET ret = 't';
        WHEN 'ｕ' THEN
            SET ret = 'u';
        WHEN 'ｖ' THEN
            SET ret = 'v';
        WHEN 'ｗ' THEN
            SET ret = 'w';
        WHEN 'ｘ' THEN
            SET ret = 'x';
        WHEN 'ｙ' THEN
            SET ret = 'y';
        WHEN 'ｚ' THEN
            SET ret = 'z';
        -- 大文字
        WHEN 'Ａ' THEN
            SET ret = 'A';
        WHEN 'Ｂ' THEN
            SET ret = 'B';
        WHEN 'Ｃ' THEN
            SET ret = 'C';
        WHEN 'Ｄ' THEN
            SET ret = 'D';
        WHEN 'Ｅ' THEN
            SET ret = 'E';
        WHEN 'Ｆ' THEN
            SET ret = 'F';
        WHEN 'Ｇ' THEN
            SET ret = 'G';
        WHEN 'Ｈ' THEN
            SET ret = 'H';
        WHEN 'Ｉ' THEN
            SET ret = 'I';
        WHEN 'Ｊ' THEN
            SET ret = 'J';
        WHEN 'Ｋ' THEN
            SET ret = 'K';
        WHEN 'Ｌ' THEN
            SET ret = 'L';
        WHEN 'Ｍ' THEN
            SET ret = 'M';
        WHEN 'Ｎ' THEN
            SET ret = 'N';
        WHEN 'Ｏ' THEN
            SET ret = 'O';
        WHEN 'Ｐ' THEN
            SET ret = 'P';
        WHEN 'Ｑ' THEN
            SET ret = 'Q';
        WHEN 'Ｒ' THEN
            SET ret = 'R';
        WHEN 'Ｓ' THEN
            SET ret = 'S';
        WHEN 'Ｔ' THEN
            SET ret = 'T';
        WHEN 'Ｕ' THEN
            SET ret = 'U';
        WHEN 'Ｖ' THEN
            SET ret = 'V';
        WHEN 'Ｗ' THEN
            SET ret = 'W';
        WHEN 'Ｘ' THEN
            SET ret = 'X';
        WHEN 'Ｙ' THEN
            SET ret = 'Y';
        WHEN 'Ｚ' THEN
            SET ret = 'Z';
        -- 数字
        WHEN '０' THEN
            SET ret = '0';
        WHEN '１' THEN
            SET ret = '1';
        WHEN '２' THEN
            SET ret = '2';
        WHEN '３' THEN
            SET ret = '3';
        WHEN '４' THEN
            SET ret = '4';
        WHEN '５' THEN
            SET ret = '5';
        WHEN '６' THEN
            SET ret = '6';
        WHEN '７' THEN
            SET ret = '7';
        WHEN '８' THEN
            SET ret = '8';
        WHEN '９' THEN
            SET ret = '9';
        ELSE
            -- 定義されていないものはそのまま返す
            SET ret = c;
    END CASE;
    RETURN ret;
END;
$$
DELIMITER ;

-- 全角文字列を半角文字列に変更する関数。
DELIMITER $$
CREATE FUNCTION zenkaku2hankakukana_string (str TEXT)
RETURNS TEXT DETERMINISTIC
BEGIN

    DECLARE ret TEXT;
    DECLARE i INTEGER DEFAULT 1;
    -- 何文字取るか
    DECLARE cap INTEGER DEFAULT 1;
    WHILE i <= char_length(str) DO
        SET ret = concat(ret, zenkaku2hankakukana(SUBSTRING(str, i, cap)));
        -- 取った数だけ進める
        SET i = i + cap;
	END WHILE;
    RETURN ret;
END;
$$
DELIMITER ;

-- 半角を全角に変更する
DELIMITER $$
CREATE FUNCTION hankakukana2zenkaku (c VARCHAR(2))
RETURNS CHAR(1) DETERMINISTIC
BEGIN

    DECLARE ret CHAR(1);
    CASE c
        -- ア行
        WHEN 'ｱ' THEN
            SET ret = 'ア';
        WHEN 'ｲ' THEN
            SET ret = 'イ';
        WHEN 'ｳ' THEN
            SET ret = 'ウ';
        WHEN 'ｴ' THEN
            SET ret = 'エ';
        WHEN 'ｵ' THEN
            SET ret = 'オ';
        -- カ行
        WHEN 'ｶ' THEN
            SET ret = 'カ';
        WHEN 'ｷ' THEN
            SET ret = 'キ';
        WHEN 'ｸ' THEN
            SET ret = 'ク';
        WHEN 'ｹ' THEN
            SET ret = 'ケ';
        WHEN 'ｺ' THEN
            SET ret = 'コ';
        -- サ行
        WHEN 'ｻ' THEN
            SET ret = 'サ';
        WHEN 'ｼ' THEN
            SET ret = 'シ';
        WHEN 'ｽ' THEN
            SET ret = 'ス';
        WHEN 'ｾ' THEN
            SET ret = 'セ';
        WHEN 'ｿ' THEN
            SET ret = 'ソ';
        -- タ行
        WHEN 'ﾀ' THEN
            SET ret = 'タ';
        WHEN 'ﾁ' THEN
            SET ret = 'チ';
        WHEN 'ﾂ' THEN
            SET ret = 'ツ';
        WHEN 'ﾃ' THEN
            SET ret = 'ﾃ';
        WHEN 'ﾄ' THEN
            SET ret = 'ト';
        -- ナ行
        WHEN 'ﾅ' THEN
            SET ret = 'ナ';
        WHEN 'ﾆ' THEN
            SET ret = 'ニ';
        WHEN 'ﾇ' THEN
            SET ret = 'ヌ';
        WHEN 'ﾈ' THEN
            SET ret = 'ネ';
        WHEN 'ﾉ' THEN
            SET ret = 'ノ';
        -- ハ行
        WHEN 'ﾊ' THEN
            SET ret = 'ハ';
        WHEN 'ﾋ' THEN
            SET ret = 'ヒ';
        WHEN 'ﾌ' THEN
            SET ret = 'フ';
        WHEN 'ﾍ' THEN
            SET ret = 'ヘ';
        WHEN 'ﾎ' THEN
            SET ret = 'ホ';
        -- マ行
        WHEN 'ﾏ' THEN
            SET ret = 'マ';
        WHEN 'ﾐ' THEN
            SET ret = 'ミ';
        WHEN 'ﾑ' THEN
            SET ret = 'ム';
        WHEN 'ﾒ' THEN
            SET ret = 'メ';
        WHEN 'ﾓ' THEN
            SET ret = 'モ';
        -- ヤ行
        WHEN 'ﾔ' THEN
            SET ret = 'ヤ';
        WHEN 'ﾕ' THEN
            SET ret = 'ユ';
        WHEN 'ﾖ' THEN
            SET ret = 'ヨ';
        -- ワ行
        WHEN 'ﾜ' THEN
            SET ret = 'ワ';
        WHEN 'ｦ' THEN
            SET ret = 'ヲ';
        WHEN 'ﾝ' THEN
            SET ret = 'ン';
        -- ガ行
        WHEN 'ｶﾞ' THEN
            SET ret = 'ガ';
        WHEN 'ｷﾞ' THEN
            SET ret = 'ギ';
        WHEN 'ｸﾞ' THEN
            SET ret = 'グ';
        WHEN 'ｹﾞ' THEN
            SET ret = 'ゲ';
        WHEN 'ｺﾞ' THEN
            SET ret = 'ゴ';
        -- ザ行
        WHEN 'ｻﾞ' THEN
            SET ret = 'ザ';
        WHEN 'ｼﾞ' THEN
            SET ret = 'ジ';
        WHEN 'ｽﾞ' THEN
            SET ret = 'ズ';
        WHEN 'ｾﾞ' THEN
            SET ret = 'ゼ';
        WHEN 'ｿﾞ' THEN
            SET ret = 'ゾ';
        -- ダ行
        WHEN 'ﾀﾞ' THEN
            SET ret = 'ダ';
        WHEN 'ﾁﾞ' THEN
            SET ret = 'ヂ';
        WHEN 'ﾂﾞ' THEN
            SET ret = 'ヅ';
        WHEN 'ﾃﾞ' THEN
            SET ret = 'デ';
        WHEN 'ﾄﾞ' THEN
            SET ret = 'ド';
        -- バ行
        WHEN 'ﾊﾞ' THEN
            SET ret = 'バ';
        WHEN 'ﾋﾞ' THEN
            SET ret = 'ビ';
        WHEN 'ﾌﾞ' THEN
            SET ret = 'ブ';
        WHEN 'ﾍﾞ' THEN
            SET ret = 'ベ';
        WHEN 'ﾎﾞ' THEN
            SET ret = 'ボ';
        -- パ行
        WHEN 'ﾊﾟ' THEN
            SET ret = 'パ';
        WHEN 'ﾋﾟ' THEN
            SET ret = 'ピ';
        WHEN 'ﾌﾟ' THEN
            SET ret = 'プ';
        WHEN 'ﾍﾟ' THEN
            SET ret = 'ペ';
        WHEN 'ﾎﾟ' THEN
            SET ret = 'ポ';
        -- 小文字
        WHEN 'ｧ' THEN
            SET ret = 'ァ';
        WHEN 'ｨ' THEN
            SET ret = 'ィ';
        WHEN 'ｩ' THEN
            SET ret = 'ゥ';
        WHEN 'ｪ' THEN
            SET ret = 'ェ';
        WHEN 'ｫ' THEN
            SET ret = 'ォ';
        WHEN 'ｯ' THEN
            SET ret = 'ッ';
        WHEN 'ｬ' THEN
            SET ret = 'ャ';
        WHEN 'ｭ' THEN
            SET ret = 'ュ';
        WHEN 'ｮ' THEN
            SET ret = 'ョ';
        -- その他 伸ばし棒-(マイナス)とは違う
        WHEN 'ｰ' THEN
            SET ret = 'ー';
        -- アルファベット
        -- 小文字
        WHEN 'a' THEN
            SET ret = 'ａ';
        WHEN 'b' THEN
            SET ret = 'ｂ';
        WHEN 'c' THEN
            SET ret = 'ｃ';
        WHEN 'd' THEN
            SET ret = 'ｄ';
        WHEN 'e' THEN
            SET ret = 'ｅ';
        WHEN 'f' THEN
            SET ret = 'ｆ';
        WHEN 'g' THEN
            SET ret = 'ｇ';
        WHEN 'h' THEN
            SET ret = 'ｈ';
        WHEN 'i' THEN
            SET ret = 'ｉ';
        WHEN 'j' THEN
            SET ret = 'ｊ';
        WHEN 'k' THEN
            SET ret = 'ｋ';
        WHEN 'l' THEN
            SET ret = 'ｌ';
        WHEN 'm' THEN
            SET ret = 'ｍ';
        WHEN 'n' THEN
            SET ret = 'ｎ';
        WHEN 'o' THEN
            SET ret = 'ｏ';
        WHEN 'p' THEN
            SET ret = 'ｐ';
        WHEN 'q' THEN
            SET ret = 'ｑ';
        WHEN 'r' THEN
            SET ret = 'ｒ';
        WHEN 's' THEN
            SET ret = 'ｓ';
        WHEN 't' THEN
            SET ret = 'ｔ';
        WHEN 'u' THEN
            SET ret = 'ｕ';
        WHEN 'v' THEN
            SET ret = 'ｖ';
        WHEN 'w' THEN
            SET ret = 'ｗ';
        WHEN 'x' THEN
            SET ret = 'ｘ';
        WHEN 'y' THEN
            SET ret = 'ｙ';
        WHEN 'z' THEN
            SET ret = 'ｚ';
        -- 大文字
        WHEN 'A' THEN
            SET ret = 'Ａ';
        WHEN 'B' THEN
            SET ret = 'Ｂ';
        WHEN 'C' THEN
            SET ret = 'Ｃ';
        WHEN 'D' THEN
            SET ret = 'Ｄ';
        WHEN 'E' THEN
            SET ret = 'Ｅ';
        WHEN 'F' THEN
            SET ret = 'Ｆ';
        WHEN 'G' THEN
            SET ret = 'Ｇ';
        WHEN 'H' THEN
            SET ret = 'Ｈ';
        WHEN 'I' THEN
            SET ret = 'Ｉ';
        WHEN 'J' THEN
            SET ret = 'Ｊ';
        WHEN 'K' THEN
            SET ret = 'Ｋ';
        WHEN 'L' THEN
            SET ret = 'Ｌ';
        WHEN 'M' THEN
            SET ret = 'Ｍ';
        WHEN 'N' THEN
            SET ret = 'Ｎ';
        WHEN 'O' THEN
            SET ret = 'Ｏ';
        WHEN 'P' THEN
            SET ret = 'Ｐ';
        WHEN 'Q' THEN
            SET ret = 'Ｑ';
        WHEN 'R' THEN
            SET ret = 'Ｒ';
        WHEN 'S' THEN
            SET ret = 'Ｓ';
        WHEN 'T' THEN
            SET ret = 'Ｔ';
        WHEN 'U' THEN
            SET ret = 'Ｕ';
        WHEN 'V' THEN
            SET ret = 'Ｖ';
        WHEN 'W' THEN
            SET ret = 'Ｗ';
        WHEN 'X' THEN
            SET ret = 'Ｘ';
        WHEN 'Y' THEN
            SET ret = 'Ｙ';
        WHEN 'Z' THEN
            SET ret = 'Ｚ';
        -- 数字
        WHEN '0' THEN
            SET ret = '０';
        WHEN '1' THEN
            SET ret = '１';
        WHEN '2' THEN
            SET ret = '２';
        WHEN '3' THEN
            SET ret = '３';
        WHEN '4' THEN
            SET ret = '４';
        WHEN '5' THEN
            SET ret = '５';
        WHEN '6' THEN
            SET ret = '６';
        WHEN '7' THEN
            SET ret = '７';
        WHEN '8' THEN
            SET ret = '８';
        WHEN '9' THEN
            SET ret = '９';
        ELSE
            -- 定義されていないものはそのまま返す
            SET ret = c;
    END CASE;
    RETURN ret;
END;
$$
DELIMITER ;

-- 合字（二つで一つの文字か判定）
DELIMITER $$
CREATE FUNCTION ligature (c VARCHAR(2))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE ret BOOLEAN DEFAULT FALSE;
    -- 2文字の時のみ
    IF char_length(c) = 2 THEN
        -- 濁音、　半濁音は他の音があって初めてなので
        -- 実際あるか同時は他の関数に委ねる。漫画などにある表現として「あ」の濁点とかがあるので。
        IF Substring(c, 2, 1) IN ('ﾞ', 'ﾟ') THEN
            SET ret = TRUE;
        END IF;
        -- 2文字以上の合字が出たら足して行く。
    -- 3文字以上の合字が出たらELSE IF で追加して行く。
    END IF;

    RETURN ret;
END;
$$
DELIMITER ;

DELIMITER $$
-- 半角文字列を全角文字列に変更する関数。
CREATE FUNCTION hankakukana2zenkaku_string (str TEXT)
RETURNS TEXT DETERMINISTIC
BEGIN

    DECLARE ret TEXT;
    DECLARE i INTEGER DEFAULT 1;
    -- 何文字取るか
    DECLARE cap INTEGER DEFAULT 1;
    WHILE i <= char_length(str) DO
        -- 合字かどうか。
        -- 指定の位置から最大二文字取る。
        IF ligature(SUBSTRING(str, i, 2)) THEN
            -- 2文字で一つの文字なので二文字取る。
            SET cap = 2;
        ELSE
            SET cap = 1; 
        END IF;
            SET ret = concat(ret, hankakukana2zenkaku(SUBSTRING(str, i, cap)));
            -- 取った数だけ進める
            SET i = i + cap;
    END WHILE;

    RETURN ret;
END;
$$
DELIMITER ;

