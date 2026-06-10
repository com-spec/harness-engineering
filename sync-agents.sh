#!/bin/bash
set -euo pipefail

echo "Backing up..."
cp ~/.grok/AGENTS.md ~/.grok/AGENTS.md.bak.$(date +%Y%m%d%H%M%S)

echo "Copying..."
cp AGENTS.md ~/.grok/AGENTS.md

echo "Verifying..."
diff AGENTS.md ~/.grok/AGENTS.md

echo "Done."