# Final Project for Computational Social Sciences Exam

## Repository Layout

```
   R/          code for easing data manipulation
   analysis/           final analysis is performed
   data/           maps, electoral data, google trends data
   graphs/         code used to generate graphs
   methods/            testing different approaches to estimate dirichlet
   term_paper/         source code for the final paper
```

### `ingestion/`

One subdirectory per data source. Sources fall into two categories:

**News scrapers** (parquet output — consistent `title / link / published_at / text` schema):

| Source | Notes |
| :----- | :---- |
| `aviation_news/` | Aviation News Network |
| `bundeswehr/` | German Ministry of Defence (German + English) |
| `dsca_legacy/` | DSCA legacy scraper (MCW) |
| `eurasia_daily_monitor/` | Jamestown Foundation — deprecated, website format changed |
| `army_recognition/`, `asia_pacific_defense_journal/`, `asian_defence_blog/`, `asian_defence_journal_adj/`, `asian_military_review/`, `aviation_week/`, `bmpd_livejournal/`, `defence_blog/`, `defence_web/`, `defensa_com/`, `defense_industry_daily/`, `defense_news/`, `defense_one/`, `defense_studies/`, `defesa_aerea_naval/`, `dod_sar/`, `dsca/`, `jeune_afrique/`, `jstor_defsecint/`, `nwc_review/`, `rusi_journal/`, `us_house_admin/` | |
