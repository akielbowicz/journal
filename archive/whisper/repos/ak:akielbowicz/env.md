
# el-mundo-ha-vivido-equivocado
- Publish flow for an episode: edit md (`title: "Episodio NN"` → slug `episodio-NN`, filename irrelevant to URL) → cover via `just new-cover NN` (scaffold badge at y=260 overlaps decoracion; move to y≈310; preview with rsvg-convert) → local checks → `just publish-episodio NN` (WAV→MP3 V0, release `episodio-NN`, fires deploy) → commit+push. The publish's workflow_dispatch deploy run gets CANCELLED by the push's deploy run — expected, the push run is the one that matters.
- Episode md duration should match the converted MP3 (`-durSSSS` suffix seconds), not the WAV probe.
