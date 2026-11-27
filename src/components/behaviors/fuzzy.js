.pragma library

const SCORE_MATCH = 16;
const GAP_START = -3;
const GAP_EXTENSION = -1;
const BONUS_WHITE = 10;
const BONUS_DELIMITER = 9;
const BONUS_BOUNDARY = 8;
const BONUS_CAMEL = 7;
const BONUS_CONSECUTIVE = 4;
const FIRST_MULTIPLIER = 2;

function kind(c) {
    if (c === " " || c === "\t")
        return "white";
    if ("/:;|,".indexOf(c) >= 0)
        return "delimiter";
    if (c >= "0" && c <= "9")
        return "digit";
    if (c !== c.toLowerCase())
        return "upper";
    if (c !== c.toUpperCase())
        return "lower";
    return "other";
}

function bonus(text, i) {
    const prev = i === 0 ? "white" : kind(text[i - 1]);
    const cur = kind(text[i]);
    if (cur === "white" || cur === "delimiter" || cur === "other")
        return 0;
    if (prev === "white")
        return BONUS_WHITE;
    if (prev === "delimiter")
        return BONUS_DELIMITER;
    if (prev === "other")
        return BONUS_BOUNDARY;
    if ((prev === "lower" && cur === "upper") || (prev !== "digit" && cur === "digit"))
        return BONUS_CAMEL;
    return 0;
}

function match(query, text) {
    const q = query.trim().toLowerCase();
    if (q === "")
        return { score: 0, positions: [] };
    const lower = text.toLowerCase();
    const m = q.length, n = lower.length;
    if (m > n)
        return null;
    const bonuses = [];
    for (let i = 0; i < n; i++)
        bonuses.push(bonus(text, i));
    const NONE = -1e9;
    const score = [], chunk = [], back = [];
    for (let k = 0; k < m; k++) {
        score.push(new Array(n).fill(NONE));
        chunk.push(new Array(n).fill(0));
        back.push(new Array(n).fill(-1));
        for (let i = k; i < n; i++) {
            if (lower[i] !== q[k])
                continue;
            if (k === 0) {
                score[k][i] = SCORE_MATCH + bonuses[i] * FIRST_MULTIPLIER;
                chunk[k][i] = bonuses[i];
                continue;
            }
            if (score[k - 1][i - 1] > NONE) {
                const b = Math.max(bonuses[i], chunk[k - 1][i - 1], BONUS_CONSECUTIVE);
                const s = score[k - 1][i - 1] + SCORE_MATCH + b;
                if (s > score[k][i]) {
                    score[k][i] = s;
                    chunk[k][i] = b;
                    back[k][i] = i - 1;
                }
            }
            for (let j = k - 1; j < i - 1; j++) {
                if (score[k - 1][j] <= NONE)
                    continue;
                const gap = i - j - 1;
                const s = score[k - 1][j] + SCORE_MATCH + bonuses[i] + GAP_START + GAP_EXTENSION * (gap - 1);
                if (s > score[k][i]) {
                    score[k][i] = s;
                    chunk[k][i] = bonuses[i];
                    back[k][i] = j;
                }
            }
        }
    }
    let best = -1;
    for (let i = m - 1; i < n; i++)
        if (score[m - 1][i] > NONE && (best < 0 || score[m - 1][i] > score[m - 1][best]))
            best = i;
    if (best < 0)
        return null;
    const positions = [];
    for (let k = m - 1, i = best; k >= 0; i = back[k][i], k--)
        positions.unshift(i);
    return { score: score[m - 1][best], positions: positions };
}

function rank(query, options) {
    const results = [];
    for (let i = 0; i < options.length; i++) {
        const option = options[i];
        const found = match(query, option.title);
        if (found)
            results.push({ option: option, positions: found.positions, score: found.score, order: i });
    }
    if (query.trim() !== "")
        results.sort((a, b) => b.score - a.score || a.option.title.length - b.option.title.length || a.order - b.order);
    return results;
}

function escape(text) {
    return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

function emphasize(text, positions, color) {
    if (!positions || positions.length === 0)
        return escape(text);
    let out = "";
    let open = false;
    for (let i = 0; i < text.length; i++) {
        const hit = positions.indexOf(i) >= 0;
        if (hit && !open) {
            out += "<font color=\"" + color + "\">";
            open = true;
        } else if (!hit && open) {
            out += "</font>";
            open = false;
        }
        out += escape(text[i]);
    }
    return open ? out + "</font>" : out;
}
