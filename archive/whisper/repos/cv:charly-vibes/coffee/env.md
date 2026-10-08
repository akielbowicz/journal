
## GLM family mapping missing (2026-10-06)
`scripts/usage-tracker.py` `model_details()` (~:538) maps `deepseek` but has no `glm` rule — GLM-5.3-flash sessions (the ecosystem's incumbent: 44.6% of all pi msgs, $0.003/msg) fall into the unknown bucket. Cost still lands because pi logs carry `usage.cost.total` from OpenRouter, but family attribution is wrong. Fix: add `if "glm" in m: return ("glm", "5.3-flash")` next to the deepseek line. Session facts: GLM-5.3-flash = incumbent baseline for all model-comparison work (gpt-6.x has zero usage history).
