# Mendel Exit Comps — Password-Protected Site

Live: https://ade-b10.github.io/mendel-exit-comps/
Password: `ianandade` (shared with Ade + Ian)

## What this is
Living dashboard of LatAm + global spend-mgmt comps anchored to Mendel's Q1 2026 plan. Refreshed automatically on the 1st of each month via the `mendel-exit-comps-monthly` scheduled task.

## Refresh manually
```bash
# 1) Update the source file
# /Users/ade/Desktop/Urizen/Mendel_Exit_Comps_Dashboard.html
cp /Users/ade/Desktop/Urizen/Mendel_Exit_Comps_Dashboard.html source/

# 2) Re-encrypt
./update.sh

# 3) Commit + push
git add index.html
git commit -m "Refresh Mendel exit comps $(date +%Y-%m-%d)"
git push
```

GitHub Pages auto-deploys in ~30 seconds.
