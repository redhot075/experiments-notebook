---
name: crypto-x-commenter
description: Analyze a crypto-related X (Twitter) post from a URL and generate English reply options in multiple styles. Use when the user shares an X post about crypto, NFT, DeFi, ICOs, airdrops, token launches, or drophunting and asks for comments/replies, tone variants, or short punchy reactions with a 140-character cap. Supports explicit mode cues like 'degen mode', 'smart analyst mode', 'skeptical mode', or shorthand like 'degen + link'.
---

# Crypto X Commenter

## Overview
Extract the post context (`who / what / why`) from an X link, then produce several English comment options in different styles: short slang, medium, and a full but still concise version under 140 characters.

## Mode selection

If the user specifies a mode, adapt tone accordingly:

- **degen mode**
  - High-energy crypto-native slang
  - More hype, momentum, conviction
  - Still avoid fabricated claims
- **smart analyst mode**
  - Sharper fundamentals/tokenomics framing
  - More signal, less meme language
  - Keep concise and actionable
- **skeptical mode**
  - Risk-first framing, more caution
  - Question assumptions and incentives
  - Include fraud/overhype awareness without accusations

If no mode is specified, use a balanced crypto-native tone.

## Workflow

1. Open and read the provided X post URL.
   - Prefer browser-based reading when available.
   - If direct access fails, try safe mirrors/fallbacks.
   - If still blocked, ask user to paste the post text.
2. Build a compact context summary:
   - **Who**: author/account identity and role in crypto context
   - **What**: claim/announcement/opinion in the post
   - **Why**: likely motive or significance (utility, hype, governance, tokenomics, growth, etc.)
3. Generate English comments in 3 buckets:
   - **Short (slang)**: ultra-short crypto-native style (`based`, `LFG`, etc.)
   - **Medium**: clear one-liner with a bit of substance
   - **Normal (<=140 chars)**: thoughtful but tweet-length
4. Validate limits and quality:
   - Keep all comments in English
   - Keep "Normal" comments <=140 characters
   - Avoid repetitive wording across variants
   - Avoid defamatory claims or fabricated facts

## Output format
Return exactly this structure:

- **Mode:** degen | smart analyst | skeptical | balanced

- **Who:** ...
- **What:** ...
- **Why:** ...
- **Comment options (EN):**
  - **Short:**
    1) ...
    2) ...
    3) ...
  - **Medium:**
    1) ...
    2) ...
    3) ...
  - **Normal (<=140 chars):**
    1) ...
    2) ...
    3) ...

## Style rules
- Sound like a long-time crypto participant (native jargon is fine, but keep readable).
- Mix optimism and critical thinking when appropriate.
- If the post is clearly promotional, include at least one cautiously skeptical option.
- Do not use emojis in every line; vary tone naturally.
- Keep “Short” comments punchy (roughly 2–8 words).

## Character-limit check
Before final output, quickly verify each “Normal” option fits 140 characters.
If one exceeds the limit, rewrite it rather than truncating awkwardly.
