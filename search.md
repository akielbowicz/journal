---
layout: default
title: search
---

<style>
#search-input {
  width: 100%;
  padding: 8px 12px;
  font-size: 16px;
  border: 1px solid #ddd;
  border-radius: 4px;
  margin-bottom: 16px;
  font-family: inherit;
}
#search-results {
  list-style: none;
  padding: 0;
}
#search-results li {
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid #eee;
}
#search-results .result-title {
  font-weight: bold;
  font-size: 1.1em;
}
#search-results .result-title a {
  text-decoration: none;
}
#search-results .result-snippet {
  color: #555;
  margin-top: 4px;
  font-size: 0.9em;
}
#search-results .result-path {
  color: #999;
  font-size: 0.8em;
  font-family: monospace;
}
</style>

# Search

<input type="text" id="search-input" placeholder="Type to search..." autofocus>

<ul id="search-results"></ul>

<script src="https://unpkg.com/lunr@2.3.9/lunr.min.js"></script>
<script src="{{ '/search-index.json' | relative_url }}"></script>
<script>
(function() {
  var idx = lunr(function() {
    this.ref('url');
    this.field('title', { boost: 10 });
    this.field('content');
    this.field('path', { boost: 5 });

    window.searchData.forEach(function(doc) {
      this.add(doc);
    }, this);
  });

  var input = document.getElementById('search-input');
  var results = document.getElementById('search-results');

  // Get query from URL if present
  var params = new URLSearchParams(window.location.search);
  if (params.has('q')) {
    input.value = params.get('q');
    doSearch(params.get('q'));
  }

  input.addEventListener('input', function() {
    doSearch(this.value);
  });

  function doSearch(query) {
    results.innerHTML = '';
    if (query.length < 2) return;

    // Add wildcards for fuzzy matching
    var terms = query.trim().split(/\s+/).map(function(t) {
      return t + '*';
    }).join(' ');

    var hits = idx.search(terms);
    if (hits.length === 0) {
      // Try fuzzy
      terms = query.trim().split(/\s+/).map(function(t) {
        return t + '~1';
      }).join(' ');
      hits = idx.search(terms);
    }

    hits.slice(0, 20).forEach(function(hit) {
      var doc = window.searchData.find(function(d) { return d.url === hit.ref; });
      if (!doc) return;

      var li = document.createElement('li');

      var snippet = doc.content.substring(0, 200);
      if (doc.content.length > 200) snippet += '...';

      li.innerHTML =
        '<div class="result-path">' + doc.path + '</div>' +
        '<div class="result-title"><a href="' + doc.url + '">' + doc.title + '</a></div>' +
        '<div class="result-snippet">' + snippet + '</div>';

      results.appendChild(li);
    });

    if (hits.length === 0) {
      results.innerHTML = '<li>No results found.</li>';
    }
  }
})();
</script>
